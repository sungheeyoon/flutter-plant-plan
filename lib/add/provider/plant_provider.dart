import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/plant_model.dart';

final selectedPlantProvider =
    StateNotifierProvider<SelectedPlantNotifier, PlantModel?>((ref) {
  return SelectedPlantNotifier();
});

class SelectedPlantNotifier extends StateNotifier<PlantModel?> {
  SelectedPlantNotifier() : super(null);
  void setPlant(PlantModel plant) {
    state = plant;
  }

  void reset() {
    state = null;
  }
}
