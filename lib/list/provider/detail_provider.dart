import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/list/model/detail_model.dart';

final detailProvider =
    StateNotifierProvider<DetailNotifier, DetailModelBase>((ref) {
  return DetailNotifier();
});

class DetailNotifier extends StateNotifier<DetailModelBase> {
  DetailNotifier() : super(DetailModelLoading());

  void updateDetail(PlantModel plant) {
    state = DetailModel(data: plant);
  }

  void updateUserImageUrl(String url) {
    if (state is DetailModel) {
      final DetailModel currentState = state as DetailModel;
      final updatedData = currentState.data.copyWith(userImageUrl: url);
      state = DetailModel(data: updatedData);
    } else {
      state = DetailModelError(message: 'Not DetailModel');
    }
  }

  void updateAlias(String text) {
    if (state is DetailModel) {
      final DetailModel currentState = state as DetailModel;
      final updatedData = currentState.data.copyWith(alias: text);
      state = DetailModel(data: updatedData);
    } else {
      state = DetailModelError(message: 'Not DetailModel');
    }
  }

  void toggleFavorite() {
    if (state is DetailModel) {
      final DetailModel currentState = state as DetailModel;
      final updatedData =
          currentState.data.copyWith(favorite: !currentState.data.favorite);
      state = DetailModel(data: updatedData);
    } else {
      state = DetailModelError(message: 'Not DetailModel');
    }
  }

  void toggleIsOnAlarm(String id) {
    if (state is DetailModel) {
      final DetailModel currentState = state as DetailModel;
      final updatedAlarms = List<AlarmModel>.from(currentState.data.alarms);
      for (int i = 0; i < updatedAlarms.length; i++) {
        if (updatedAlarms[i].id == id) {
          final updatedAlarm =
              updatedAlarms[i].copyWith(isOn: !updatedAlarms[i].isOn);
          updatedAlarms[i] = updatedAlarm;
          break;
        }
      }
      final updatedData = currentState.data.copyWith(alarms: updatedAlarms);
      state = DetailModel(data: updatedData);
    } else {
      state = DetailModelError(message: 'Not DetailModel');
    }
  }

  void deleteAlarm(String id) {
    if (state is DetailModel) {
      final DetailModel currentState = state as DetailModel;
      final updatedAlarms = List<AlarmModel>.from(currentState.data.alarms);
      for (int i = 0; i < updatedAlarms.length; i++) {
        if (updatedAlarms[i].id == id) {
          updatedAlarms.removeAt(i);
          break;
        }
      }
      final updatedData = currentState.data.copyWith(alarms: updatedAlarms);
      state = DetailModel(data: updatedData);
    } else {
      state = DetailModelError(message: 'Not DetailModel');
    }
  }

  @override
  void dispose() {
    state = DetailModelLoading();
    super.dispose();
  }
}
