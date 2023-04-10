// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:plant_plan/add/model/plant_model.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final plantRepositoryProvider = Provider<PlantRepository>((ref) {
//   final repository = PlantRepository();

//   return repository;
// });

// class PlantRepository {
//   Future<QuerySnapshot> getPlants(
//     int limit, {
//     DocumentSnapshot? startAfter,
//   }) async {
//     final refPlants = FirebaseFirestore.instance
//         .collection('plant_list')
//         .orderBy('name')
//         .limit(limit);

//     if (startAfter == null) {
//       return await refPlants.get();
//     } else {
//       return await refPlants.startAfterDocument(startAfter).get();
//     }
//   }

//   Future<QuerySnapshot> getAllPlants() {
//     final refAllPlants = FirebaseFirestore.instance
//         .collection("plant_list")
//         .orderBy("name")
//         .get();

//     return refAllPlants;
//   }

//   List<PlantModel> _plantListFromSnapshot(QuerySnapshot snapshot) {
//     return snapshot.docs.map((doc) {
//       return PlantModel.fromJson(doc.data() as Map<String, dynamic>);
//     }).toList();
//   }
// }
