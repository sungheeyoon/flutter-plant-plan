import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/common/model/user_info_model.dart';
import 'package:plant_plan/common/provider/userInfoProvider.dart';

final detailProvider =
    StateNotifierProvider<DetailState, UserInfoModel?>((ref) {
  final List<UserInfoModel> userInfoList = ref.read(userInfoProvider);
  return DetailState(
    userInfoList: userInfoList,
  );
});

class DetailState extends StateNotifier<UserInfoModel?> {
  final List<UserInfoModel> userInfoList;
  DetailState({
    required this.userInfoList,
  }) : super(null);

  Future<void> patchDetail(String docId) async {
    for (final userInfo in userInfoList) {
      if (userInfo.docId == docId) {
        state = userInfo;
        break;
      } else {
        state = null;
      }
    }
  }
}
