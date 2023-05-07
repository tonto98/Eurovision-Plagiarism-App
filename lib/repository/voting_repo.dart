import 'package:dio/dio.dart';
import 'package:eurovision_app/core/app_core.dart';

class VotingRepository {
  static Future<bool> castVote(int countryId, int points) async {
    try {
      final dio = Dio();
      dio.options.headers = ApplicationCore.headers;
      final res = await dio.post(
        "http://127.0.0.1:5000/reviews/points",
        data: {
          "username": ApplicationCore().authBloc.username,
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
}
