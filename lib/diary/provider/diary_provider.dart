import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/diary_model.dart';

final diaryProvider = StateNotifierProvider<DiaryNotifier, DiaryModel>((ref) {
  return DiaryNotifier();
});

class DiaryNotifier extends StateNotifier<DiaryModel> {
  DiaryNotifier()
      : super(
          DiaryModel.newDiaryModel(
            date: DateTime.now(),
          ),
        );

  void setDateNow() {
    DateTime result = DateTime.now();

    state = state.copyWith(date: result);
  }

  void setContext(String context) {
    state = state.copyWith(context: context);
  }

  void setBookMark(bool bookMark) {
    state = state.copyWith(bookMark: bookMark);
  }

  void setEmoji(String emoji) {
    state = state.copyWith(emoji: emoji);
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setImageUrl(List<String> imageUrl) {
    state = state.copyWith(imageUrl: imageUrl);
  }

  void reset() {
    state = DiaryModel.newDiaryModel(
      date: DateTime.now(),
    );
  }

  void setDiary(DiaryModel diary) {
    state = diary;
  }
}
