import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/info_input_model.dart';

final infoInputProvider =
    StateNotifierProvider<InfoInputNotifier, InfoInputModel>((ref) {
  return InfoInputNotifier();
});

class InfoInputNotifier extends StateNotifier<InfoInputModel> {
  InfoInputNotifier()
      : super(
          const InfoInputModel(),
        );

  void setInfoInput({
    required InfoKey key,
    required String value,
  }) {
    state = state.copyWith(
      // key에 따라서 적절한 프로퍼티를 업데이트
      alias: key == InfoKey.alias ? value : state.alias,
      wateringDay: key == InfoKey.wateringDay ? value : state.wateringDay,
      repottingDay: key == InfoKey.repottingDay ? value : state.repottingDay,
      nutrientDay: key == InfoKey.nutrientDay ? value : state.nutrientDay,
    );
  }

  void reset() {
    state = const InfoInputModel();
  }
}
