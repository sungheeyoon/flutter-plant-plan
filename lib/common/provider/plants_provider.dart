import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/diary_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/common/model/plants_model.dart';
import 'package:plant_plan/services/firebase_service.dart';

final plantsProvider =
    StateNotifierProvider<PlantsNotifier, PlantsModelBase>((ref) {
  return PlantsNotifier();
});

class PlantsNotifier extends StateNotifier<PlantsModelBase> {
  PlantsNotifier() : super(PlantsModelLoading());

  Future<void> fetchPlants() async {
    try {
      await Future.delayed(const Duration(microseconds: 2500));
      List<PlantModel> data = await FirebaseService().fireBaseFetchPlant();
      state = PlantsModel(data: data);
    } catch (e) {
      state = PlantsModelError(message: "fetch error occurred");
    }
  }

  Future<void> updatePlant(
    String docId, {
    String? alias,
    String? userImageUrl,
    bool? favoriteToggle,
  }) async {
    if (alias == null && favoriteToggle == null && userImageUrl == null) {
      return;
    }
    final PlantsModel currentState = state as PlantsModel;
    final List<PlantModel> updatedPlants = [...currentState.data];

    for (int i = 0; i < updatedPlants.length; i++) {
      final PlantModel plant = updatedPlants[i];
      if (plant.docId == docId) {
        final updatedUserImageUrl = userImageUrl ?? plant.userImageUrl;
        final updatedAlias = alias ?? plant.alias;
        final updatedIsFavorite = favoriteToggle != null && favoriteToggle
            ? !plant.favorite
            : plant.favorite;
        final updatedPlant = plant.copyWith(
          alias: updatedAlias,
          favorite: updatedIsFavorite,
          userImageUrl: updatedUserImageUrl,
        );

        updatedPlants[i] = updatedPlant;

        break;
      }
    }

    state = PlantsModel(data: updatedPlants);

    try {
      final updatedData = {
        'alias':
            updatedPlants.firstWhere((plant) => plant.docId == docId).alias,
        'favorite':
            updatedPlants.firstWhere((plant) => plant.docId == docId).favorite,
        'userImageUrl': updatedPlants
            .firstWhere((plant) => plant.docId == docId)
            .userImageUrl,
      };

      await FirebaseService().fireBaseUpdatePlant(docId, updatedData);
    } catch (error) {
      state = PlantsModelError(message: error.toString());
    }
  }

  Future<void> deletePlant(String docId) async {
    final PlantsModel currentState = state as PlantsModel;
    final List<PlantModel> updatedPlants = [...currentState.data];
    bool shouldUpdateDatabase = false;
    PlantModel? plant;

    for (int i = 0; i < updatedPlants.length; i++) {
      if (updatedPlants[i].docId == docId) {
        plant = updatedPlants[i];

        updatedPlants.removeAt(i);
        shouldUpdateDatabase = true;

        break;
      } else {
        state = PlantsModelError(message: "docId dosen't exsist");
      }
    }
    state = PlantsModel(data: updatedPlants);
    if (shouldUpdateDatabase && plant is PlantModel) {
      try {
        await FirebaseService().fireBaseDeletePlant(plant);
      } catch (error) {
        state = PlantsModelError(message: error.toString());
      }
    }
  }

  Future<void> deleteAll() async {
    final PlantsModel currentState = state as PlantsModel;
    final List<PlantModel> allPlants = [...currentState.data];

    // 리스트를 수정하지 않고 삭제할 요소들을 따로 모으기
    List<PlantModel> plantsToDelete = [];

    for (PlantModel plant in allPlants) {
      plantsToDelete.add(plant);
    }

    // 따로 모은 요소들을 삭제
    for (PlantModel plant in plantsToDelete) {
      allPlants.remove(plant);
      try {
        await FirebaseService().fireBaseDeletePlant(plant);
      } catch (error) {
        state = PlantsModelError(message: error.toString());
      }
    }
    state = PlantsModel(data: allPlants);
  }

  Future<void> deleteAlarm(
    String alarmId,
    String docId,
  ) async {
    final PlantsModel currentState = state as PlantsModel;
    final List<PlantModel> updatedPlants = [...currentState.data];
    bool shouldUpdateDatabase = false;

    for (int i = 0; i < updatedPlants.length; i++) {
      if (updatedPlants[i].docId == docId) {
        final List<AlarmModel> alarms =
            List<AlarmModel>.from(updatedPlants[i].alarms);

        for (int j = 0; j < alarms.length; j++) {
          if (alarms[j].id == alarmId) {
            alarms.removeAt(j);
            shouldUpdateDatabase = true;
            break;
          }
        }

        updatedPlants[i] = updatedPlants[i].copyWith(alarms: alarms);
        break;
      }
    }
    state = PlantsModel(data: updatedPlants);
    if (shouldUpdateDatabase) {
      try {
        await FirebaseService().fireBaseDeleteAlarm(docId, alarmId);
      } catch (error) {
        state = PlantsModelError(message: error.toString());
      }
    }
  }

  Future<void> deleteDiary(
    String diaryId,
    String docId,
  ) async {
    final PlantsModel currentState = state as PlantsModel;
    final List<PlantModel> updatedPlants = [...currentState.data];
    bool shouldUpdateDatabase = false;

    for (int i = 0; i < updatedPlants.length; i++) {
      if (updatedPlants[i].docId == docId) {
        final List<DiaryModel> diaryEntries =
            List<DiaryModel>.from(updatedPlants[i].diary);

        for (int j = 0; j < diaryEntries.length; j++) {
          if (diaryEntries[j].id == diaryId) {
            diaryEntries.removeAt(j);
            shouldUpdateDatabase = true;
            break;
          }
        }

        updatedPlants[i] = updatedPlants[i].copyWith(diary: diaryEntries);
        break;
      }
    }
    state = PlantsModel(data: updatedPlants);
    if (shouldUpdateDatabase) {
      try {
        await FirebaseService().fireBaseDeleteDiary(docId, diaryId);
      } catch (error) {
        state = PlantsModelError(message: error.toString());
      }
    }
  }

  Future<void> updateAlarm(
    String alarmId,
    String docId, {
    DateTime? startTime,
    int? repeat,
    bool? isOnToggle,
    String? title,
    DateTime? offTime,
  }) async {
    if (startTime == null &&
        repeat == null &&
        isOnToggle == null &&
        title == null &&
        offTime == null) {
      return;
    }

    final PlantsModel currentState = state as PlantsModel;
    final List<PlantModel> updatedPlants = [...currentState.data];
    bool shouldUpdateDatabase = false;

    for (final PlantModel plant in updatedPlants) {
      if (plant.docId == docId) {
        final List<AlarmModel> alarms = List<AlarmModel>.from(plant.alarms);

        for (final AlarmModel alarm in alarms) {
          if (alarm.id == alarmId) {
            final updatedStartTime = startTime ?? alarm.startTime;
            final updatedRepeat = repeat ?? alarm.repeat;
            final updatedIsOn =
                isOnToggle != null && isOnToggle ? !alarm.isOn : alarm.isOn;
            final updatedTitle = title ?? alarm.title;
            final updatedOffDates = List<DateTime>.from(alarm.offDates);

            if (offTime != null) {
              if (updatedOffDates.contains(offTime)) {
                updatedOffDates.remove(offTime);
              } else {
                updatedOffDates.add(offTime);
              }
            }

            final updatedAlarm = alarm.copyWith(
              startTime: updatedStartTime,
              repeat: updatedRepeat,
              isOn: updatedIsOn,
              title: updatedTitle,
              offDates: updatedOffDates,
            );

            final index = alarms.indexOf(alarm);
            alarms[index] = updatedAlarm;

            shouldUpdateDatabase = true;

            break;
          }
        }

        final updatedPlant = plant.copyWith(alarms: alarms);
        final index = updatedPlants.indexOf(plant);
        updatedPlants[index] = updatedPlant;

        break;
      }
    }

    state = PlantsModel(data: updatedPlants);

    if (shouldUpdateDatabase) {
      try {
        await FirebaseService().fireBaseUpdateAlarm(docId,
            updatedPlants.firstWhere((plant) => plant.docId == docId).alarms);
      } catch (error) {
        state = PlantsModelError(message: error.toString());
      }
    }
  }

  Future<void> updateOrAddAlarm(
    String alarmId,
    String docId,
    AlarmModel newAlarm,
  ) async {
    final PlantsModel currentState = state as PlantsModel;
    final List<PlantModel> updatedPlants = [...currentState.data];
    bool shouldUpdateDatabase = false;

    for (final PlantModel plant in updatedPlants) {
      if (plant.docId == docId) {
        final List<AlarmModel> alarms = List<AlarmModel>.from(plant.alarms);
        bool foundExistingAlarm = false;

        for (final AlarmModel alarm in alarms) {
          if (alarm.id == alarmId) {
            final updatedAlarm = newAlarm.copyWith(id: alarm.id);
            final index = alarms.indexOf(alarm);
            alarms[index] = updatedAlarm;

            shouldUpdateDatabase = true;
            foundExistingAlarm = true;

            break;
          }
        }

        if (!foundExistingAlarm) {
          alarms.add(newAlarm);
          shouldUpdateDatabase = true;
        }

        final updatedPlant = plant.copyWith(alarms: alarms);
        final index = updatedPlants.indexOf(plant);
        updatedPlants[index] = updatedPlant;

        break;
      }
    }

    state = PlantsModel(data: updatedPlants);

    if (shouldUpdateDatabase) {
      try {
        await FirebaseService().fireBaseUpdateAlarm(docId,
            updatedPlants.firstWhere((plant) => plant.docId == docId).alarms);
      } catch (error) {
        state = PlantsModelError(message: error.toString());
      }
    }
  }

  Future<PlantModel> getPlant(String docId) async {
    final PlantsModel currentState = state as PlantsModel;

    for (final PlantModel plant in currentState.data) {
      if (docId == plant.docId) {
        return plant;
      }
    }

    throw Exception("docId와 매치되는 plant가 없습니다.: $docId");
  }

  Future<void> toggleDiaryBookmark(String docId, String diaryId) async {
    final PlantsModel currentState = state as PlantsModel;
    final updatedData = currentState.data.map((plant) {
      if (plant.docId == docId) {
        final updatedDiaryList = plant.diary.map((diary) {
          if (diary.id == diaryId) {
            return diary.copyWith(bookMark: !diary.bookMark);
          }
          return diary;
        }).toList();

        return plant.copyWith(diary: updatedDiaryList);
      }
      return plant;
    }).toList();

    state = currentState.copyWith(data: updatedData);

    try {
      await FirebaseService().toggleDiaryBookmark(docId, diaryId);
    } catch (error) {
      state = PlantsModelError(message: error.toString());
    }
  }

  Future<void> updatedDiaryList(String docId) async {
    final List<DiaryModel> newDiaryList =
        await FirebaseService().fetchDiaryList(docId);
    final PlantsModel currentState = state as PlantsModel;
    final updatedData = currentState.data.map((plant) {
      if (plant.docId == docId) {
        return plant.copyWith(diary: newDiaryList);
      }
      return plant;
    }).toList();

    state = currentState.copyWith(data: updatedData);
  }
}
