import 'package:cloud_firestore/cloud_firestore.dart';

///GET - ListPlant
///POST - CreatePlant
///Delete - DeletePlant
class PlantRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> ListPlant() async* {
    //요청
    final plantList =
        FirebaseFirestore.instance.collection('plant_list').snapshots();
  }
}
