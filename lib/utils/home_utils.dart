import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';

import 'package:plant_plan/common/model/alarm_with_userinfo.dart';

import 'package:plant_plan/add/model/alarm_model.dart';

//선택된날짜의 알람을가지고있는 알람들을 리턴
List<AlarmWithUserInfo> getSelectedDateList(
    List<PlantModel> plantsState, DateTime selectedDateState,
    [PlantField? field]) {
  List<AlarmWithUserInfo> results = [];

  for (final PlantModel plant in plantsState) {
    for (final AlarmModel alarm in plant.alarms) {
      if (alarm.isOn) {
        DateTime zeroStartTime = DateTime(
          alarm.startTime.year,
          alarm.startTime.month,
          alarm.startTime.day,
        );
        if (zeroStartTime != selectedDateState) {
          int difference = selectedDateState.difference(zeroStartTime).inDays;

          if ((difference == 0 && alarm.repeat == 0) ||
              (alarm.repeat > 0 &&
                  difference > -1 &&
                  difference % alarm.repeat == 0)) {
            results.add(
              AlarmWithUserInfo(
                alarm: alarm,
                alias: plant.alias,
                information: plant.information,
                userImageUrl: plant.userImageUrl,
                docId: plant.docId,
              ),
            );
          }
        }
      }
    }
  }

  if (field != null) {
    results = results.where((alarm) => alarm.alarm.field == field).toList();
  }

  return results;
}

//선택된날짜의 알람을가지고있는 알람들의 완료갯수를 카운팅
int calculateCompleteCount(
    List<AlarmWithUserInfo> selectedDateAlarms, DateTime selectedDateState) {
  int completeCount = 0;
  for (final AlarmWithUserInfo info in selectedDateAlarms) {
    if (info.alarm.offDates.contains(selectedDateState)) {
      completeCount++;
    }
  }
  return completeCount;
}
