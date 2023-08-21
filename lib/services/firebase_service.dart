import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';

class FirebaseService {
  //사용자의 인증 상태
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //현재 로그인된 사용자의 정보
  late final User? _currentUser;

  FirebaseService() {
    _currentUser = _auth.currentUser;
  }
  Future<List<PlantModel>> fireBaseFetchPlant() async {
    final List<PlantModel> data = [];
    if (_currentUser != null) {
      final uid = _currentUser!.uid;
      final userDataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .get();

      data.addAll(userDataSnapshot.docs
          .map((doc) => PlantModel.fromJson(doc.data()))
          .toList());
    }
    return data;
  }

  Future<void> fireBaseUpdatePlant(
      String docId, Map<String, dynamic> updatedData) async {
    if (_currentUser != null) {
      final uid = _currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .doc(docId)
          .update(updatedData);
    }
  }

  Future<void> fireBaseUpdateAlarm(
      String docId, List<AlarmModel> updatedAlarms) async {
    if (_currentUser != null) {
      final uid = _currentUser!.uid;

      final plantData = {
        'alarms': updatedAlarms.map((alarm) => alarm.toJson()).toList(),
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
