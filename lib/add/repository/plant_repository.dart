import 'package:cloud_firestore/cloud_firestore.dart';

final _referencePlantList =
    FirebaseFirestore.instance.collection('plant_list').get();

class PlantRepository {
  Future getPlantList() async {
    final first = FirebaseFirestore.instance
        .collection("plant_list")
        .orderBy("name")
        .limit(25);

    first.get().then(
      (documentSnapshots) async {
        // Get the last visible document
        final lastVisible = documentSnapshots.docs[documentSnapshots.size - 1];

        // Construct a new query starting at this document,
        // get the next 25 plant_list.
        final next = FirebaseFirestore.instance
            .collection("plant_list")
            .orderBy("population")
            .startAfter([lastVisible]).limit(25);

        // Use the query for pagination
        // ...
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}
