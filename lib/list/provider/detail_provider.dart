import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';

final detailProvider =
    StateNotifierProvider<DetailNotifier, PlantModel?>((ref) {
  final List<PlantModel> userInfoList = ref.watch(plantsProvider);
  return DetailNotifier(
    userInfoList: userInfoList,
  );
});

class DetailNotifier extends StateNotifier<PlantModel?> {
  final List<PlantModel> userInfoList;
  DetailNotifier({
    required this.userInfoList,
  }) : super(null);

  Future<void> patchDetail(String docId) async {
    PlantModel? matchingUserInfo;

    for (final userInfo in userInfoList) {
      if (userInfo.docId == docId) {
        matchingUserInfo = userInfo;
        break;
      }
    }

    state = matchingUserInfo;
  }

  void toggleFavorite() {
    state = state!.copyWith(favorite: !state!.favorite);
  }
}
