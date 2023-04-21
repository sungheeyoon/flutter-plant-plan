import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';

enum PlantField {
  watering,
  alias,
  repotting,
  nutrient,
}

final plantInformationProvider =
    StateNotifierProvider<PlantInformationNotifier, PlantInformationModel>(
        (ref) {
  return PlantInformationNotifier();
});

class PlantInformationNotifier extends StateNotifier<PlantInformationModel> {
  PlantInformationNotifier()
      : super(
          PlantInformationModel(
            watering: PlantInformationKey(
              alarm: Alarm(),
            ),
            repotting: PlantInformationKey(
              alarm: Alarm(),
            ),
            nutrient: PlantInformationKey(
              alarm: Alarm(),
            ),
          ),
        );

  void reset() {
    state = PlantInformationModel(
      watering: PlantInformationKey(
        alarm: Alarm(),
      ),
      repotting: PlantInformationKey(
        alarm: Alarm(),
      ),
      nutrient: PlantInformationKey(
        alarm: Alarm(),
      ),
    );
  }
}
