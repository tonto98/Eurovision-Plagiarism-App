import 'dart:convert';

import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/models/countries_list.dart';
import 'package:http/http.dart' as http;

class CountriesRepository {
  static Future<CountriesList> getAllCountries() async {
    final response = await http.get(
      Uri.parse("http://127.0.0.1:5000/countries"),
      headers: ApplicationCore.headers,
    );

    final result = CountriesList.fromJson(jsonDecode(response.body));

    return result;
  }
}