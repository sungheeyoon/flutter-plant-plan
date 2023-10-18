import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/information_model.dart';

final informationProvider =
    StateNotifierProvider<InformationNotifier, InformationModel>(
  (ref) {
    return InformationNotifier();
  },
);

class InformationNotifier extends StateNotifier<InformationModel> {
  InformationNotifier() : super(InformationModel());

  void updateInformation(InformationModel information) {
    state = information;
  }

  void resetInformation() {
    state = InformationModel();
  }

  void updateImageUrl(String imageUrl) {
    state = state.copyWith(imageUrl: imageUrl);
  }
}
