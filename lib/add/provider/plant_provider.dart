import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/plant_model.dart';

class PlantsStateNotifier extends StateNotifier<List<PlantModel>> {
  PlantsStateNotifier() : super([]) {
    paginate();
  }

  Future<void> paginate({
    int fetchCount = 20,
    //추가로 데이터 더 가져오기
    // true 추가로 데이터 더 가져옴
    //false - 새로고침(현재 상태를 덮어씌움)
    bool fetchMore = false,
    //강제로 다시 로딩하기
    //true - CursorPaginationLoading()
    bool forceRefetch = false,
  }) async {}
}
