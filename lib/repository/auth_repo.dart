import 'dart:convert';

import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/core/constants.dart';
import 'package:eurovision_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class AuthRepository {
  static Future<User?> registerUser(String username) async {
    // final res = await http.post(
    //   Uri.parse("http://127.0.0.1:5000/users"),
    //   headers: ApplicationCore.headers,
    //   body: jsonEncode({"username": username}),
    // );

    try {
      final dio = Dio();
      dio.options.headers = ApplicationCore.headers;
      final res = await dio.post(
        "$baseUrl/users",
        data: {"username": username},
      );
      if (res.statusCode == 200) {
        User user = User.fromJson(res.data);
        return user;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse && e.response!.statusCode == 409) {
        User user = User.fromJson(e.response!.data);
        return user;
      }
    } catch (e) {
      throw Exception();
    }
    return null;
  }
}
