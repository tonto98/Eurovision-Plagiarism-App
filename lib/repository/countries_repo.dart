import 'dart:convert';

import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/core/constants.dart';
import 'package:eurovision_app/models/countries_list.dart';
import 'package:eurovision_app/models/country.dart';
import 'package:http/http.dart' as http;

class CountriesRepository {
  static Future<CountriesList> getAllCountries() async {
    final response = await http.get(
      Uri.parse("$baseUrl/countries"),
      headers: ApplicationCore.headers,
    );
    try {
      final result = CountriesList.fromJson(jsonDecode(response.body));
      return result;
    } catch (e) {
      return CountriesList();
    }
  }

  static Future<Country> getCountryById(int id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/countries?id=$id"),
      headers: ApplicationCore.headers,
    );
    try {
      final result = Country.fromJson(jsonDecode(response.body));
      return result;
    } catch (e) {
      print(e);
      return Country();
    }
  }
}
