import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';

enum PlantField {
  watering,
  repotting,
  nutrient,
}

final plantInformationProvider =
    StateNotifierProvider<PlantInformationNotifier, PlantInformationModel>(
        (ref) {
  return PlantInformationNotifier();
});

class PlantInformationNotifier extends StateNotifier<PlantInformationModel> {
  PlantInformationNotifier()
      : super(
          PlantInformationModel(
            alias: "",
            watering: PlantInformationKey(
              alarm: Alarm.newAlarm(
                startTime: DateTime.now(),
              ),
            ),
            repotting: PlantInformationKey(
              alarm: Alarm.newAlarm(
                startTime: DateTime.now(),
              ),
            ),
            nutrient: PlantInformationKey(
              alarm: Alarm.newAlarm(
                startTime: DateTime.now(),
              ),
            ),
          ),
        );
  void updatePlantField(
    PlantField field, {
    DateTime? lastDay,
    bool? toggleIsOn,
    Alarm? alarm,
  }) {
    PlantInformationKey updateKey(PlantInformationKey key) {
      Alarm updatedAlarm = alarm ?? key.alarm;
      if (toggleIsOn != null && toggleIsOn) {
        updatedAlarm = updatedAlarm.copyWith(isOn: !updatedAlarm.isOn);
      }
      return key.copyWith(
        lastDay: lastDay ?? key.lastDay,
        alarm: updatedAlarm,
      );
    }

    switch (field) {
      case PlantField.watering:
        state = state.copyWith(
          watering: updateKey(state.watering),
        );
        break;
      case PlantField.repotting:
        state = state.copyWith(
          repotting: updateKey(state.repotting),
        );
        break;
      case PlantField.nutrient:
        state = state.copyWith(
          nutrient: updateKey(state.nutrient),
        );
        break;
      default:
        // 예외 처리 혹은 기본 동작
        break;
    }
  }

  void updateAlias(String newAlias) {
    state = state.copyWith(alias: newAlias);
  }

  void fieldReset(PlantField field) {
    if (field == PlantField.watering) {
      state = PlantInformationModel(
        alias: "",
        watering: PlantInformationKey(
          alarm: Alarm.newAlarm(
            startTime: DateTime.now(),
          ),
        ),
        repotting: state.repotting,
        nutrient: state.nutrient,
      );
    } else if (field == PlantField.repotting) {
      state = PlantInformationModel(
        alias: "",
        watering: state.watering,
        repotting: PlantInformationKey(
          alarm: Alarm.newAlarm(
            startTime: DateTime.now(),
          ),
        ),
        nutrient: state.nutrient,
      );
    } else if (field == PlantField.nutrient) {
      state = PlantInformationModel(
        alias: "",
        watering: state.watering,
        repotting: state.repotting,
        nutrient: PlantInformationKey(
          alarm: Alarm.newAlarm(
            startTime: DateTime.now(),
          ),
        ),
      );
    }
  }

  void reset() {
    state = PlantInformationModel(
      alias: "",
      watering: PlantInformationKey(
        alarm: Alarm.newAlarm(
          startTime: DateTime.now(),
        ),
      ),
      repotting: PlantInformationKey(
        alarm: Alarm.newAlarm(
          startTime: DateTime.now(),
        ),
      ),
      nutrient: PlantInformationKey(
        alarm: Alarm.newAlarm(
          startTime: DateTime.now(),
        ),
      ),
    );
  }
}
