import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/information_model.dart';
import 'package:plant_plan/add/model/tip_model.dart';

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

  void updateId(String id) {
    state = state.copyWith(id: id);
  }

  void updateImageUrl(String imageUrl) {
    state = state.copyWith(imageUrl: imageUrl);
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateTips(List<TipModel> tips) {
    state = state.copyWith(tips: tips);
  }

  void reset() {
    state = InformationModel();
  }
}
