class ToonModel {
  final String thumb, id;

  ToonModel.fromJson(Map<String, dynamic> json)
      : thumb = json['thumb'],
        id = json['id'];
}
