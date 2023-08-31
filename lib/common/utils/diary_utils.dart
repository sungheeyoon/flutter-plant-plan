import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/diary/model/diary_card_model.dart';

List<DiaryCardModel> getDiaryCardList(List<PlantModel> plantsState) {
  List<DiaryCardModel> results = [];

  for (final PlantModel plant in plantsState) {
    String docId = plant.docId;
    String name = plant.information.name;
    String alias = plant.alias;
    String imageUrl = plant.userImageUrl == ""
        ? plant.information.imageUrl
        : plant.userImageUrl;

    for (final diary in plant.diary) {
      //DiaryCardModel result 에있는
      //DateTime result.diary.date 의 시간 내림차순으로 정렬하는코드만들어줘  여기에넣는게좋을까?
      results.add(
        DiaryCardModel(
          docId: docId,
          name: name,
          alias: alias,
          imageUrl: imageUrl,
          diary: diary,
        ),
      );
    }
  }
  results.sort((a, b) => b.diary.date.compareTo(a.diary.date));

  return results;
}
