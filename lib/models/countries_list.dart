import 'country.dart';

class CountriesList {
  List<Country>? countries;

  CountriesList({this.countries});

  CountriesList.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Country>[];
      json['countries'].forEach((v) {
        countries!.add(Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
