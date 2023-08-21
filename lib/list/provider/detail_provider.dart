import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/list/model/detail_model.dart';

final detailProvider =
    StateNotifierProvider<DetailNotifier, DetailModelBase>((ref) {
  return DetailNotifier();
});

class DetailNotifier extends StateNotifier<DetailModelBase> {
  DetailNotifier() : super(DetailModelLoading());

  void updateDetail(PlantModel data) {
    state = DetailModel(data: data);
  }

  void toggleFavorite() {
    if (state is DetailModel) {
      final DetailModel currentState = state as DetailModel;
      final updatedData =
          currentState.data.copyWith(favorite: currentState.data.favorite);
      state = DetailModel(data: updatedData);
    } else {
      state = DetailModelError(message: 'Not PlantModel');
    }
  }
}
