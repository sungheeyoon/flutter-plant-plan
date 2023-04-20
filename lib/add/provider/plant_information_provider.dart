import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';

final plantInformationProvider =
    StateNotifierProvider<PlantInformationNotifier, PlantInformationModel?>(
        (ref) {
  return PlantInformationNotifier();
});

class PlantInformationNotifier extends StateNotifier<PlantInformationModel?> {
  PlantInformationNotifier() : super(null);

  void setPlantInformation(PlantInformationModel model) {
    state = model;
  }

  void reset() {
    state = null;
  }
}
