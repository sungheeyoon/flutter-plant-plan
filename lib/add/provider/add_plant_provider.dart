import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/information_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';

enum PlantField {
  watering,
  repotting,
  nutrient,
  none,
}

final addPlantProvider = StateNotifierProvider<AddPlantNotifier, PlantModel>(
  (ref) {
    return AddPlantNotifier();
  },
);

class AddPlantNotifier extends StateNotifier<PlantModel> {
  AddPlantNotifier()
      : super(
          PlantModel(
            information: InformationModel(),
          ),
        );

  void updateInformation(InformationModel information) {
    state = state.copyWith(information: information);
  }

  void resetInformation() {
    state = state.copyWith(information: InformationModel());
  }

  void updateAlias(String newAlias) {
    state = state.copyWith(alias: newAlias);
  }

  Future<void> updateDocId(String docId) async {
    state = state.copyWith(docId: docId);
  }

  void updateUserImageUrl(String userImageUrl) {
    state = state.copyWith(userImageUrl: userImageUrl);
  }

  void updateIsOn(String id) {
    final updatedAlarms = List<AlarmModel>.from(state.alarms);
    for (int i = 0; i < updatedAlarms.length; i++) {
      if (updatedAlarms[i].id == id) {
        updatedAlarms[i] =
            updatedAlarms[i].copyWith(isOn: !updatedAlarms[i].isOn);
        break;
      }
    }
    state = state.copyWith(alarms: updatedAlarms);
  }

  void updateAlarm(String id, AlarmModel newAlarm) {
    final updatedAlarms = List<AlarmModel>.from(state.alarms);
    bool found = false;

    for (int i = 0; i < updatedAlarms.length; i++) {
      if (updatedAlarms[i].id == id) {
        updatedAlarms[i] = newAlarm;
        found = true;
        break;
      }
    }

    if (!found) {
      updatedAlarms.add(newAlarm);
    }

    state = state.copyWith(alarms: updatedAlarms);
  }

  void alarmDelete(String id) {
    final updatedAlarms = List<AlarmModel>.from(state.alarms);
    for (int i = 0; i < updatedAlarms.length; i++) {
      if (updatedAlarms[i].id == id) {
        updatedAlarms.removeAt(i);
        break;
      }
    }
    state = state.copyWith(alarms: updatedAlarms);
  }

  void alarmAdd(AlarmModel alarm) {
    state.alarms.add(alarm);
  }

  void reset() {
    state = PlantModel(
      information: InformationModel(),
    );
  }
}
