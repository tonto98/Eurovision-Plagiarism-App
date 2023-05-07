import 'package:eurovision_app/blocs/countries/countries_state.dart';
import 'package:eurovision_app/models/country.dart';
import 'package:eurovision_app/repository/countries_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountriesBloc extends Cubit<CountriesState> {
  CountriesBloc() : super(CountriesInitial());
  List<Country> countries = [];

  void getCountries({bool withLoading = false}) async {
    if (withLoading) emit(CountriesLoading());

    try {
      final res = await CountriesRepository.getAllCountries();
      countries = res.countries!;
      emit(CountriesSuccess(res.countries!));
    } catch (e) {
      emit(CountriesFail());
    }
  }

  void updateCountriesState() {
    emit(CountriesSuccess(countries));
  }
}
