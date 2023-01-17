class WeatherModel {
  final String imgUri, time, id;

  WeatherModel.fromJson(Map<String, dynamic> json)
      : imgUri = json['imgUri'],
        time = json['time'],
        id = json['id'];
}
