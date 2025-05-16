import 'dart:convert';

class Country {
  String? artist;
  String? code;
  int? id;
  bool? inFinal;
  String? name;
  int? order;
  String? song;
  String? songUrl;
  Map<String, int>? pointList;

  Country({
    this.artist,
    this.code,
    this.id,
    this.inFinal,
    this.name,
    this.order,
    this.song,
    this.songUrl,
    this.pointList,
  });

  Country.fromJson(Map<String, dynamic> json) {
    artist = json['artist'];
    code = json['code'];
    id = json['id'];
    inFinal = json['inFinal'];
    name = json['name'];
    order = json['order'];
    song = json['song'];
    songUrl = json['songUrl'];
    try {
      pointList = {};
      Map<String, dynamic> jsonMap = json["pointlist"];
      print(jsonMap);
      jsonMap.forEach((key, value) {
        pointList![key] = value as int;
      });
    } catch (e) {
      pointList = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['artist'] = this.artist;
    data['code'] = this.code;
    data['id'] = this.id;
    data['inFinal'] = this.inFinal;
    data['name'] = this.name;
    data['order'] = this.order;
    data['song'] = this.song;
    data['songUrl'] = this.songUrl;
    return data;
  }

  @override
  String toString() {
    return "$id$name";
  }
}
