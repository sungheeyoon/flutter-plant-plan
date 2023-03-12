import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_plan/models/plant.dart';

///GET - ListPlant
///POST - CreatePlant
///Delete - DeletePlant
class PlantRepository {
  final _fireCloud = FirebaseFirestore.instance.collection('plant_list');
  Future<List<Plant>> getPlantList() async {
    List<Plant> plantList = [];
    try {
      final plants = await _fireCloud.get();
      for (var plant in plants.docs) {
        plantList.add(Plant.fromJson(plant.data()));
      }
      return plantList;
    } on FirebaseException catch (e) {
      print("Failed with error '${e.code}': ${e.message}");
      return plantList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Plant> createPlant({
    required int id,
    required String imageUrl,
    required String name,
  }) async {
    try {
      await _fireCloud.add({"id": id, "name": name, "imageUrl": imageUrl});
    } on FirebaseException catch (e) {
      print("Failed with error '${e.code}': ${e.message}");
    } catch (e) {
      throw Exception(e.toString());
    }
    return Plant(id: id, name: name, imgUrl: imageUrl);
  }

  Future<Map<String, dynamic>> deletePlant(Plant plant) async {
    return plant.toJson();
  }
}
