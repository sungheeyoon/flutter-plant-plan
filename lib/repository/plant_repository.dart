import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_plan/models/plant.dart';

///GET - ListPlant
///POST - CreatePlant
///Delete - DeletePlant
class PlantRepository {
  Stream listPlant() async* {
    //요청
    Stream<QuerySnapshot<Map<String, dynamic>>> plantList =
        FirebaseFirestore.instance.collection('plant_list').snapshots();
    yield plantList;
  }

  Future<Map<String, dynamic>> createPlant(Plant plant) async {
    ///body - request -  response - return
    return plant.toJson();
  }

  Future<Map<String, dynamic>> deletePlant(Plant plant) async {
    return plant.toJson();
  }
}
