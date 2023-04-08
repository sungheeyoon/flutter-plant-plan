// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:plant_plan/add/model/plant_model.dart';
// import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

// class SearchScreenFireUi extends StatelessWidget {
//   const SearchScreenFireUi({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final platnsQuery = FirebaseFirestore.instance
//         .collection('plant_list')
//         .orderBy('name')
//         .withConverter<PlantModel>(
//           fromFirestore: (snapshot, _) => PlantModel.fromJson(snapshot.data()!),
//           toFirestore: (plant, _) => plant.toJson(),
//         );

//     return FirestoreListView<PlantModel>(
//       query: platnsQuery,
//       itemBuilder: (context, snapshot) {
//         PlantModel plant = snapshot.data();

//         return Text('plant name is ${plant.name}');
//       },
//     );
//   }
// }
