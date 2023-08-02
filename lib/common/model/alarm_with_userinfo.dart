import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/information_model.dart';

class AlarmWithUserInfo {
  final AlarmModel alarm;
  final String alias;
  final InformationModel information;
  final String userImageUrl;
  final String docId;

  AlarmWithUserInfo({
    required this.alarm,
    required this.alias,
    required this.information,
    required this.userImageUrl,
    required this.docId,
  });
}
