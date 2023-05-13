import 'dart:convert';

import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/core/constants.dart';
import 'package:eurovision_app/models/results.dart';
import 'package:http/http.dart' as http;

class ResultsRepository {
  static Future<Results> getResults() async {
    final response = await http.get(
      Uri.parse("$baseUrl/reviews"),
      headers: ApplicationCore.headers,
    );

    final result = Results.fromJson(jsonDecode(response.body));

    return result;
  }
}
