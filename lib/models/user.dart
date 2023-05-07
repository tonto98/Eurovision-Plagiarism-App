class User {
  late String username;
  late int id;
  String? email;
  late List<PointVote> pointVotes;
  User({
    this.email,
    required this.username,
    required this.id,
    required this.pointVotes,
  });

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    username = json['username'];
    if (json['points'] != null) {
      if ((json['points'] as List).isNotEmpty) {
        pointVotes = <PointVote>[];
        json['points'].forEach((v) {
          pointVotes.add(PointVote.fromJson(v));
        });
      } else {
        pointVotes = [];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['id'] = id;
    data['username'] = username;
    data['points'] = pointVotes.map((v) => v.toJson()).toList();

    return data;
  }
}

class PointVote {
  late int countryId;
  late int points;

  PointVote({
    required this.countryId,
    required this.points,
  });

  PointVote.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['points'] = this.points;
    return data;
  }
}
