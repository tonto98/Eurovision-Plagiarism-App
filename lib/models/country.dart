class Country {
  int id;
  String code;
  String name;
  String artist;
  String song;
  String songUrl;

  Country({
    required this.id,
    required this.code,
    required this.name,
    required this.artist,
    required this.song,
    required this.songUrl,
  });
}

class Score {
  int countryId;
  double points;
  Score(this.countryId, this.points);
}
