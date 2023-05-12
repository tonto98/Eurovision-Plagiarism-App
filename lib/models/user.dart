class User {
  late String username;
  late int id;
  String? email;
  late List<PointVote> pointVotes;
  late List<OrderItem> orderItems;
  User({
    this.email,
    required this.username,
    required this.id,
    required this.pointVotes,
    required this.orderItems,
  });

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    username = json['username'];
    if (json['pointlist'] != null) {
      if ((json['pointlist'] as List).isNotEmpty) {
        pointVotes = <PointVote>[];
        json['pointlist'].forEach((v) {
          pointVotes.add(PointVote.fromJson(v));
        });
      } else {
        pointVotes = [];
      }
    }
    if (json['orderlist'] != null) {
      if ((json['orderlist'] as List).isNotEmpty) {
        orderItems = <OrderItem>[];
        json['orderlist'].forEach((v) {
          orderItems.add(OrderItem.fromJson(v));
        });
      } else {
        orderItems = [];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['id'] = id;
    data['username'] = username;
    data['pointlist'] = pointVotes.map((v) => v.toJson()).toList();
    data['orderlist'] = pointVotes.map((v) => v.toJson()).toList();

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

class OrderItem {
  late int countryId;
  late int orderNumber;

  OrderItem({
    required this.countryId,
    required this.orderNumber,
  });

  OrderItem.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    orderNumber = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['order'] = this.orderNumber;
    return data;
  }
}
