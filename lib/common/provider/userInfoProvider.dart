import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/common/model/user_info_model.dart';

final userInfoProvider =
    StateNotifierProvider<UserInfoNotifier, List<UserInfoModel>>((ref) {
  return UserInfoNotifier();
});

class UserInfoNotifier extends StateNotifier<List<UserInfoModel>> {
  UserInfoNotifier() : super([]);

  void fetchUserData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final List<UserInfoModel> datas = [];
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
        final info = PlantInformationModel.fromJson(
          data['plantInformation'],
        );
        final plant = PlantModel.fromJson(
          {
            'id': data['id'],
            'image': data['image'],
            'name': data['name'],
          },
        );

        datas.add(
          UserInfoModel(
            info: info,
            plant: plant,
            selectedPhotoUrl: data['selectedPhotoUrl'],
            docId: data['docId'],
          ),
        );
      }
    }
    state = datas;
  }

  void fetchUserDataForSelectedDay(DateTime selectedDay) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final List<UserInfoModel> datas = [];

    if (user != null) {
      final uid = user.uid;
      final userDataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .where('isSelectedDay', isEqualTo: selectedDay)
          .get();

      final userData = userDataSnapshot.docs.map((doc) => doc.data()).toList();

      for (var data in userData) {
        final info = PlantInformationModel.fromJson(data['plantInformation']);
        final plant = PlantModel.fromJson({
          'id': data['id'],
          'image': data['image'],
          'name': data['name'],
        });

        datas.add(
          UserInfoModel(
            info: info,
            plant: plant,
            selectedPhotoUrl: data['selectedPhotoUrl'],
            docId: data['docId'],
          ),
        );
      }
    }

    state = datas;
  }

  void updateAlarm(
    String alarmId,
    String docId, {
    DateTime? startTime,
    int? repeat,
    bool? isOn,
    String? title,
  }) async {
    if (startTime == null && repeat == null && isOn == null && title == null) {
      // startTime, repeat, isOn, title 모두 null인 경우 함수를 종료.
      return;
    }

    final List<UserInfoModel> updatedData = List<UserInfoModel>.from(state);
    bool shouldUpdateDatabase = false; // 데이터베이스 업데이트 필요 여부

    for (final UserInfoModel userInfo in updatedData) {
      final List<Alarm> alarms = List<Alarm>.from(userInfo.info.alarms);

      for (final Alarm alarm in alarms) {
        if (alarm.id == alarmId) {
          // null이 아니면  alarm을 업데이트.
          final updatedStartTime = startTime ?? alarm.startTime;
          final updatedRepeat = repeat ?? alarm.repeat;
          final updatedIsOn = isOn ?? alarm.isOn;
          final updatedTitle = title ?? alarm.title;

          // 업데이트된 알람을 생성.
          final updatedAlarm = alarm.copyWith(
            startTime: updatedStartTime,
            repeat: updatedRepeat,
            isOn: updatedIsOn,
            title: updatedTitle,
          );

          // 기존 알람을 업데이트된 알람으로 교체.
          final index = alarms.indexOf(alarm);
          alarms[index] = updatedAlarm;

          // 알람이 업데이트되었으므로 데이터베이스 업데이트 필요
          shouldUpdateDatabase = true;

          break;
        }
      }

      // userInfo.info.alarms 업데이트
      final updatedInfo = userInfo.info.copyWith(alarms: alarms);
      final index = updatedData.indexOf(userInfo);
      updatedData[index] = userInfo.copyWith(info: updatedInfo);
    }

    if (shouldUpdateDatabase) {
      // 데이터베이스 업데이트
      final FirebaseAuth auth = FirebaseAuth.instance;
      final user = auth.currentUser;

      if (user != null) {
        final uid = user.uid;

        final plantData = {
          'alarms': updatedData
              .firstWhere((userInfo) => userInfo.docId == docId)
              .info
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
    state = updatedData;
  }

  //alarm.offDates 에 DateTime 을넣어 그날 알람이 off됐는지 여부를확인
  void toggleAlarmDateTime(String id, String docId, DateTime time) async {
    final updatedData = List<UserInfoModel>.from(state);

    for (final UserInfoModel userInfo in updatedData) {
      final updatedAlarms = List<Alarm>.from(userInfo.info.alarms);

      for (final Alarm alarm in updatedAlarms) {
        if (alarm.id == id) {
          final updatedOffDates = List<DateTime>.from(alarm.offDates);

          if (updatedOffDates.contains(time)) {
            updatedOffDates.remove(time);
          } else {
            updatedOffDates.add(time);
          }

          final updatedAlarm = alarm.copyWith(offDates: updatedOffDates);

          final index = updatedAlarms.indexOf(alarm);
          updatedAlarms[index] = updatedAlarm;

          break;
        }
      }

      final updatedInfo = userInfo.info.copyWith(alarms: updatedAlarms);

      final index = updatedData.indexOf(userInfo);
      updatedData[index] = userInfo.copyWith(info: updatedInfo);
    }

    state = updatedData;

    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      final uid = user.uid;

      final plantData = {
        'alarms': updatedData
            .firstWhere((userInfo) => userInfo.docId == docId)
            .info
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
}
