import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final plantRepositoryProvider = Provider<PlantRepository>((ref) {
  final repository = PlantRepository();

  return repository;
});

class PlantRepository {
  Stream<List<PlantModel>> getPlants(
    int limit, {
    DocumentSnapshot? last,
  }) {
    final refPlants = FirebaseFirestore.instance
        .collection("plant_list")
        .orderBy("name")
        .limit(limit);

    if (last == null) {
      return refPlants.snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => PlantModel.fromJson(doc.data())).toList());
    } else {
      return refPlants
          .startAfterDocument(last)
          .snapshots()
          .map(_plantListFromSnapshot);
    }
  }

  Stream<List<PlantModel>> getAllPlants() {
    final refAllPlants =
        FirebaseFirestore.instance.collection("plant_list").orderBy("name");

    return refAllPlants.snapshots().map(_plantListFromSnapshot);
  }

  List<PlantModel> _plantListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PlantModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
