import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plant_plan/models/toon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<ToonModel>> getTodaysToons() async {
    List<ToonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //response.body는 String 이므로 jsonDecode를 사용하여 json 형태로 변환
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        //JSON 각각의 아이템을 WebtoonModel 인스턴스로 생성
        webtoonInstances.add(ToonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
