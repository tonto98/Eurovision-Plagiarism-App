class Results {
  List<ResultOrderItem>? orderItem;
  List<ResultPointItem>? pointlist;

  Results({this.orderItem, this.pointlist});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['orderlist'] != null) {
      orderItem = <ResultOrderItem>[];
      json['orderlist'].forEach((v) {
        orderItem!.add(new ResultOrderItem.fromJson(v));
      });
    }
    if (json['pointlist'] != null) {
      pointlist = <ResultPointItem>[];
      json['pointlist'].forEach((v) {
        pointlist!.add(new ResultPointItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderItem != null) {
      data['orderlist'] = this.orderItem!.map((v) => v.toJson()).toList();
    }
    if (this.pointlist != null) {
      data['pointlist'] = this.pointlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultPointItem {
  int? countryId;
  double? points;

  ResultPointItem({this.countryId, this.points});

  ResultPointItem.fromJson(Map<String, dynamic> json) {
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

class ResultOrderItem {
  int? countryId;
  double? order;

  ResultOrderItem({this.countryId, this.order});

  ResultOrderItem.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['order'] = this.order;
    return data;
  }
}
