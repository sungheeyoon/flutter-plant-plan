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

  void toggleAlarmDateTime(String id, String docId, DateTime time) async {
    final updatedData = List<UserInfoModel>.from(state);

    for (var userInfo in updatedData) {
      final updatedAlarms = List<Alarm>.from(userInfo.info.alarms);

      for (var alarm in updatedAlarms) {
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
