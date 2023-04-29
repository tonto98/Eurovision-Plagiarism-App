import 'package:eurovision_app/models/country.dart';

import '../countries/countries_bloc.dart';

abstract class CountriesState {}

class CountriesInitial extends CountriesState {}

class CountriesLoading extends CountriesState {}

class CountriesSuccess extends CountriesState {
  List<Country> countries;
  CountriesSuccess(this.countries);
}

class CountriesFail extends CountriesState {}
