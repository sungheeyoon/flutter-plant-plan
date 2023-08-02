//PlantModel
import 'package:plant_plan/add/model/plant_model.dart';

final data = {
  "docId": "8jGGOWwgaG1Q3XCM2Hft",
  "userImageUrl": "",
  "alias": "별칭",
  "favorite": false,
  "watringLastDay": "2023년 7월 16일 오후 11시 55분 53초 UTC+9",
  "repottingLastDay": "2023년 7월 16일 오후 11시 55분 53초 UTC+9",
  "nutrientLastDay": "2023년 7월 16일 오후 11시 55분 53초 UTC+9",
  //InformationModel
  "Information": {
    "id": 7,
    "imageUrl":
        'https://firebasestorage.googleapis.com/v0/b/plant-project-33dbe.appspot.com/o/images%2F1676546459731154?alt=media&token=0752b960-04a7-4043-aaa3-2cf9b3788a22',
    "name": "다육이",
    //tipModel
    "tip": {
      "watering": {"title": "", "context": ""},
      "sun": {"title": "", "context": ""},
      "temperature": {"title": "", "context": ""},
      "humidity": {"title": "", "context": ""},
      "soil": {"title": "", "context": ""},
      "repotting": {"title": "", "context": ""},
    }
  },
  "diary": [
    //DiaryModel
    {
      "date": "2023년 7월 16일 오후 11시 55분 53초 UTC+9",
      "emoji": "sad",
      "title": "반짝반짝 빛나는",
      "imageUrl": [],
      "context": "",
      "bookMark": "",
    },
  ],
  "alarms": [
    //AlarmModels
    {
      "field": "repotting",
      "id": "dbd28f99-33a7-4399-bc6c-98e3283234b1",
      "isOn": true,
      "offDates": [],
      "repeat": 1,
      "startTime": "2023년 7월 16일 오후 11시 55분 53초 UTC+9",
      "title": "ㅎㅎㅎㅎ",
    }
  ],
};

PlantModel plant = PlantModel.fromJson(data);
