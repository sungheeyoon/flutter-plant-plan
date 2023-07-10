import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';

enum PlantField {
  watering,
  repotting,
  nutrient,
  none,
}

final plantInformationProvider =
    StateNotifierProvider<PlantInformationNotifier, PlantInformationModel>(
  (ref) {
    return PlantInformationNotifier();
  },
);

class PlantInformationNotifier extends StateNotifier<PlantInformationModel> {
  PlantInformationNotifier()
      : super(
          PlantInformationModel(),
        );

  void updateLastDay(
    PlantField field,
    DateTime lastDay,
  ) {
    switch (field) {
      case PlantField.watering:
        state = state.copyWith(watringLastDay: lastDay);
        break;
      case PlantField.repotting:
        state = state.copyWith(repottingLastDay: lastDay);
        break;
      case PlantField.nutrient:
        state = state.copyWith(nutrientLastDay: lastDay);
        break;
      default:
        break;
    }
  }

  void updateAlias(String newAlias) {
    state = state.copyWith(alias: newAlias);
  }

  void updateIsOn(String id) {
    final updatedAlarms = List<Alarm>.from(state.alarms);
    for (int i = 0; i < updatedAlarms.length; i++) {
      if (updatedAlarms[i].id == id) {
        updatedAlarms[i] =
            updatedAlarms[i].copyWith(isOn: !updatedAlarms[i].isOn);
        break;
      }
    }
    state = state.copyWith(alarms: updatedAlarms);
  }

  void updateAlarm(String id, Alarm newAlarm) {
    final updatedAlarms = List<Alarm>.from(state.alarms);
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
    final updatedAlarms = List<Alarm>.from(state.alarms);
    for (int i = 0; i < updatedAlarms.length; i++) {
      if (updatedAlarms[i].id == id) {
        updatedAlarms.removeAt(i);
        break;
      }
    }
    state = state.copyWith(alarms: updatedAlarms);
  }

  void alarmAdd(Alarm alarm) {
    state.alarms.add(alarm);
  }

  void reset() {
    state = PlantInformationModel();
  }
}
