import 'package:cloud_firestore/cloud_firestore.dart';

class PlantModel {
  PlantModel({
    required this.id,
    required this.image,
    required this.name,
  });

  int id;
  String image;
  String name;

  factory PlantModel.fromFirestore(QueryDocumentSnapshot<Object?> doc) {
    return PlantModel(
      id: doc["id"],
      image: doc["image"],
      name: doc["name"],
    );
  }
}
