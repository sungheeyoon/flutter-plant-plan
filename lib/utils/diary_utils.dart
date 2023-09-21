import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/diary/model/diary_card_model.dart';
import 'package:plant_plan/utils/colors.dart';

List<DiaryCardModel> getDiaryCardList(
    List<PlantModel> plantsState, bool isBookMark) {
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

void showCustomToast(BuildContext context, String msg) {
  final fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    width: 360.w,
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: grayBlack.withOpacity(0.6),
    ),
    child: Text(
      msg,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.white,
          ),
    ),
  );

  fToast.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 3),
    gravity: ToastGravity.BOTTOM,
  );
}
