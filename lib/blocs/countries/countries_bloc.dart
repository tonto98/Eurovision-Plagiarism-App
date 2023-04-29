import 'package:eurovision_app/blocs/countries/countries_state.dart';
import 'package:eurovision_app/repository/countries_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountriesBloc extends Cubit<CountriesState> {
  CountriesBloc() : super(CountriesInitial());

  void getCountries({bool withLoading = false}) async {
    if (withLoading) emit(CountriesLoading());

    try {
      final res = await CountriesRepository.getAllCountries();
      emit(CountriesSuccess(res.countries!));
    } catch (e) {
      emit(CountriesFail());
    }
  }
}
