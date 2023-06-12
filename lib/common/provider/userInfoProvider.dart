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
              selectedPhotoUrl: data['selectedPhotoUrl']),
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
          ),
        );
      }
    }

    state = datas;
  }
//   _getSelectedSnaps(from, to) {
//   DateTime startDate = from;
//   DateTime endDate = to;
//   List<DateTime> filteredSnapshot = [];
//   for(int i = 0; i < snapshot.length; i++){
//     DateTime snapshotDate = timestampToDateTime(snapshot[i]['capture_date']);
//     if(snapshotDate.isAfter(startDate) && snapshotDate.isBefore(endDate)){
//       filteredSnapshot.add(snapshotDate);
//     }
//   }
//   return filteredSnapshot;
// }
}
