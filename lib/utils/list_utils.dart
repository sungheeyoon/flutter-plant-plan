import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/list/model/list_card_model.dart';

List<ListCardModel> getCardList(List<PlantModel> plantsState, bool isFavorite) {
  List<ListCardModel> results = [];

  for (final PlantModel plant in plantsState) {
    if (isFavorite && !plant.favorite) {
      // isFavorite가 true이고 plant.favorite가 false인 경우 무시
      continue;
    }

    String docId = plant.docId;
    String title = plant.alias == "" ? plant.information.name : plant.alias;
    String imageUrl = plant.userImageUrl == ""
        ? plant.information.imageUrl
        : plant.userImageUrl;
    int dDay = -1;
    List<PlantField> fields = [];
    DateTime? timestamp = plant.timestamp;

    DateTime today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    List<AlarmModel> activeAlarms =
        plant.alarms.where((alarm) => alarm.isOn).toList();
    if (activeAlarms.isNotEmpty) {
      List<AlarmModel> closestAlarms = [];

      for (AlarmModel alarm in activeAlarms) {
        DateTime alarmDay = DateTime(
          alarm.startTime.year,
          alarm.startTime.month,
          alarm.startTime.day,
        );

        if (alarmDay == today) {
          alarmDay = alarmDay.add(Duration(days: alarm.repeat));
        }

        while (alarm.repeat > 0 && alarmDay.isBefore(today)) {
          alarmDay = alarmDay.add(Duration(days: alarm.repeat));
        }

        int difference = today.difference(alarmDay).inDays.abs();

        if (dDay == -1 || difference < dDay) {
          closestAlarms = [alarm];
          dDay = difference;
        } else if (difference == dDay) {
          closestAlarms.add(alarm);
        }
      }
      if (closestAlarms.isNotEmpty) {
        for (AlarmModel closestAlarm in closestAlarms) {
          if (closestAlarm.field == PlantField.watering) {
            if (fields.contains(PlantField.watering)) {
              continue;
            } else {
              fields.add(PlantField.watering);
            }
          }
          if (closestAlarm.field == PlantField.repotting) {
            if (fields.contains(PlantField.repotting)) {
              continue;
            } else {
              fields.add(PlantField.repotting);
            }
          }
          if (closestAlarm.field == PlantField.nutrient) {
            if (fields.contains(PlantField.nutrient)) {
              continue;
            } else {
              fields.add(PlantField.nutrient);
            }
          }
        }
      }
    }
    results.add(
      ListCardModel(
        docId: docId,
        title: title,
        imageUrl: imageUrl,
        dDay: dDay,
        fields: fields,
        favorite: plant.favorite,
        timestamp: timestamp as DateTime,
      ),
    );
  }

  return results;
}

// cardList를 D-Day 오름차순으로 정렬하는 함수
int compareByDDay(ListCardModel a, ListCardModel b) {
  if (a.dDay == -1) return 1;
  if (b.dDay == -1) return -1; // -1인 항목은 맨 뒤로 보내기
  return a.dDay.compareTo(b.dDay);
}

// timestamp기준 오름차순정렬
int compareByTimeStamp(ListCardModel a, ListCardModel b) {
  return b.timestamp.compareTo(a.timestamp);
}

// cardList를 이름 순서로 정렬하는 함수
int compareByTitle(ListCardModel a, ListCardModel b) {
  // 한글, 영어, 숫자, 특수문자 순서로 비교하여 정렬
  return a.title.compareTo(b.title);
}
