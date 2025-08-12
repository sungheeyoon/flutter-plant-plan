import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/diary/model/diary_card_model.dart';
import 'package:plant_plan/utils/colors.dart';

List<DiaryCardModel> getDiaryCardList({
  required List<PlantModel> plantsState,
  required bool isBookMark,
  required String selectedPlantDocId,
}) {
  List<DiaryCardModel> results = [];

  for (final PlantModel plant in plantsState) {
    String docId = plant.docId;
    String name = plant.information.name;
    String alias = plant.alias;
    String imageUrl = plant.userImageUrl == ""
        ? plant.information.imageUrl
        : plant.userImageUrl;

    for (final diary in plant.diary) {
      if (isBookMark && !diary.bookMark) {
        continue;
      }
      if (selectedPlantDocId.isEmpty || selectedPlantDocId == docId) {
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
  }
  results.sort((a, b) => b.diary.date.compareTo(a.diary.date));

  return results;
}

void showCustomToast(BuildContext context, String msg) {
  toastification.show(
    context: context,
    title: Text(
      msg,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.white,
          ),
    ),
    type: ToastificationType.info,
    style: ToastificationStyle.minimal,
    backgroundColor: grayBlack.withOpacity(0.6),
    foregroundColor: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 3),
    showProgressBar: false,
    showIcon: false,
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  );
}
