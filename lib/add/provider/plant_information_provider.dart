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
              alarm: Alarm(),
            ),
            repotting: PlantInformationKey(
              alarm: Alarm(),
            ),
            nutrient: PlantInformationKey(
              alarm: Alarm(),
            ),
          ),
        );
  void updatePlantField(
    PlantField field, {
    String? newDay,
    int? newRepeat,
    String? newTitle,
    String? newStartDate,
  }) {
    PlantInformationKey updateKey(PlantInformationKey key) {
      return key.copyWith(
        day: newDay ?? key.day,
        alarm: key.alarm.copyWith(
          repeat: newRepeat ?? key.alarm.repeat,
          title: newTitle ?? key.alarm.title,
          startDate: newStartDate ?? key.alarm.startDate,
        ),
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

  void reset() {
    state = PlantInformationModel(
      alias: "",
      watering: PlantInformationKey(
        alarm: Alarm(),
      ),
      repotting: PlantInformationKey(
        alarm: Alarm(),
      ),
      nutrient: PlantInformationKey(
        alarm: Alarm(),
      ),
    );
  }
}
