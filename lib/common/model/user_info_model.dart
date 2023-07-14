import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';

part 'user_info_model.freezed.dart';
part 'user_info_model.g.dart';

@freezed
class UserInfoModel with _$UserInfoModel {
  factory UserInfoModel({
    required PlantInformationModel info,
    required PlantModel plant,
    required String selectedPhotoUrl,
    required String docId,
  }) = _UserInfoModel;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);
}
