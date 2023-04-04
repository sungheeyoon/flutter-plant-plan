import 'package:cloud_firestore/cloud_firestore.dart';

class PlantRepository {
  Future<void> getPlantList() async {
    final first = FirebaseFirestore.instance
        .collection("plant_list")
        .orderBy("name")
        .limit(1);

    print('first = $first');

    final paginateFirst = await first.get().then(
      (documentSnapshots) async {
        // Get the last visible document
        final lastVisible = documentSnapshots.docs[documentSnapshots.size - 1];

        // Construct a new query starting at this document,
        // get the next 25 plant_list.
        final next = FirebaseFirestore.instance
            .collection("plant_list")
            .orderBy("name")
            .startAfter([lastVisible]).limit(2);
        print('paginateNext = $next');
        // Use the query for pagination
        // ...
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}
