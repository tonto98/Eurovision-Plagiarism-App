import 'package:dio/dio.dart';
import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/models/user.dart';

class VotingRepository {
  static Future<bool> castVote(int countryId, int points) async {
    try {
      final dio = Dio();
      dio.options.headers = ApplicationCore.headers;
      final res = await dio.post(
        "http://127.0.0.1:5000/reviews/points",
        data: {
          "id": ApplicationCore().authBloc.user!.id,
          "countryId": countryId,
          "points": points,
        },
      );
      if (res.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception();
    }

    return false;
  }

  static Future<bool> setOrder(List<OrderItem> orders) async {
    var a = {
      "id": ApplicationCore().authBloc.user!.id,
      "orderlist":
          List.generate(orders.length, (index) => orders[index].toJson())
    };
    print(a);
    try {
      final dio = Dio();
      dio.options.headers = ApplicationCore.headers;
      final res = await dio.post(
        "http://127.0.0.1:5000/reviews/order",
        data: {
          "id": ApplicationCore().authBloc.user!.id,
          "orderlist":
              List.generate(orders.length, (index) => orders[index].toJson())
        },
      );
      if (res.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception();
    }

    return false;
  }
}
