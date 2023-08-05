import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';

final plantsProvider =
    StateNotifierProvider<PlantsNotifier, List<PlantModel>>((ref) {
  return PlantsNotifier();
});

class PlantsNotifier extends StateNotifier<List<PlantModel>> {
  PlantsNotifier() : super([]);

  void fetchUserData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final List<PlantModel> datas = [];
    if (user != null) {
      final uid = user.uid;
      final userDataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .get();

      // userDataSnapshot로부터 데이터 추출
      final userData = userDataSnapshot.docs.map((doc) => doc.data()).toList();

      for (var data in userData) {
        final PlantModel plant = PlantModel.fromJson(data);

        datas.add(plant);
      }
    }
    state = datas;
  }

  // void fetchUserDataForSelectedDay(DateTime selectedDay) async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final user = auth.currentUser;
  //   final List<PlantModel> datas = [];

  //   if (user != null) {
  //     final uid = user.uid;
  //     final userDataSnapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uid)
  //         .collection('plants')
  //         .where('isSelectedDay', isEqualTo: selectedDay)
  //         .get();

  //     final userData = userDataSnapshot.docs.map((doc) => doc.data()).toList();

  //     for (var data in userData) {
  //       final info = PlantInformationModel.fromJson(data['plantInformation']);
  //       final plant = PlantModel.fromJson({
  //         'id': data['id'],
  //         'image': data['image'],
  //         'name': data['name'],
  //       });

  //       datas.add(
  //         PlantModel(
  //           info: info,
  //           plant: plant,
  //           selectedPhotoUrl: data['selectedPhotoUrl'],
  //           docId: data['docId'],
  //         ),
  //       );
  //     }
  //   }

  //   state = datas;
  // }

  void updateAlarm(
    String alarmId,
    String docId, {
    DateTime? startTime,
    int? repeat,
    bool? isOn,
    String? title,
    DateTime? offTime,
  }) async {
    if (startTime == null &&
        repeat == null &&
        isOn == null &&
        title == null &&
        offTime == null) {
      // startTime, repeat, isOn, title 모두 null인 경우 함수를 종료.
      return;
    }

    final List<PlantModel> updatedPlants = List<PlantModel>.from(state);
    bool shouldUpdateDatabase = false; // 데이터베이스 업데이트 필요 여부

    for (final PlantModel plant in updatedPlants) {
      if (plant.docId == docId) {
        final List<AlarmModel> alarms = List<AlarmModel>.from(plant.alarms);
        for (final AlarmModel alarm in alarms) {
          if (alarm.id == alarmId) {
            // null이 아니면  alarm을 업데이트.
            final updatedStartTime = startTime ?? alarm.startTime;
            final updatedRepeat = repeat ?? alarm.repeat;
            final updatedIsOn = isOn ?? alarm.isOn;
            final updatedTitle = title ?? alarm.title;
            final updatedOffDates = List<DateTime>.from(alarm.offDates);
            if (offTime != null) {
              if (updatedOffDates.contains(offTime)) {
                updatedOffDates.remove(offTime);
              } else {
                updatedOffDates.add(offTime);
              }
            }

            // 업데이트된 알람을 생성.
            final updatedAlarm = alarm.copyWith(
              startTime: updatedStartTime,
              repeat: updatedRepeat,
              isOn: updatedIsOn,
              title: updatedTitle,
              offDates: updatedOffDates,
            );

            // 기존 알람을 업데이트된 알람으로 교체.
            final index = alarms.indexOf(alarm);
            alarms[index] = updatedAlarm;

            // 알람이 업데이트되었으므로 데이터베이스 업데이트 필요
            shouldUpdateDatabase = true;

            break;
          }
        }
        final updatePlant = plant.copyWith(alarms: alarms);
        final index = updatedPlants.indexOf(plant);
        updatedPlants[index] = updatePlant;

        break; // 원하는 PlantModel을 찾았으므로 루프를 종료
      }

      // Plant.alarms 업데이트
    }

    if (shouldUpdateDatabase) {
      // 데이터베이스 업데이트
      final FirebaseAuth auth = FirebaseAuth.instance;
      final user = auth.currentUser;

      if (user != null) {
        final uid = user.uid;

        final plantData = {
          'alarms': updatedPlants
              .firstWhere((plant) => plant.docId == docId)
              .alarms
              .map((alarm) => alarm.toJson())
              .toList(),
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('plants')
            .doc(docId)
            .update(plantData);
      }
    }

    // 전체 상태를 업데이트
    state = updatedPlants;
  }
}