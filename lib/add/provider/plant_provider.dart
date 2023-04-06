import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/repository/plant_repository.dart';

class PlantsProvider extends ChangeNotifier {
  final _plantsSnapshot = <DocumentSnapshot>[];
  String _errorMessage = '';
  int documentLimit = 15;
  bool _hasNext = true;
  bool _isFetchingplants = false;
  final repository = PlantRepository();
  String get errorMessage => _errorMessage;

  bool get hasNext => _hasNext;

  List<PlantModel> get plants => _plantsSnapshot.map((snap) {
        final plant = snap.data();

        return PlantModel.fromJson(
          plant as Map<String, dynamic>,
        );
      }).toList();

  Future fetchNextplants() async {
    if (_isFetchingplants) return;

    _errorMessage = '';
    _isFetchingplants = true;

    try {
      final snap = await repository.getPlants(
        documentLimit,
        startAfter: _plantsSnapshot.isNotEmpty ? _plantsSnapshot.last : null,
      );
      _plantsSnapshot.addAll(snap.docs);

      if (snap.docs.length < documentLimit) _hasNext = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }

    _isFetchingplants = false;
  }
}
