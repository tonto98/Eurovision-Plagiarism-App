import 'package:eurovision_app/blocs/countries/countries_state.dart';
import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/models/country.dart';
import 'package:eurovision_app/models/user.dart';
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

  Country getCountryById(int id) {
    return countries.firstWhere((element) => element.id == id);
  }

  List<Country> getCountriesSorted() {
    List<Country> res = [];
    for (var country in countries) {
      int? points = _getPointsForCountry(country.id!);
      if (points == null) {
        res.add(country);
      } else {
        int index = 0;
        bool added = false;
        for (var cur in res) {
          if (points >= (_getPointsForCountry(cur.id!) ?? -999)) {
            res.insert(index, country);
            index++;
            added = true;
            break;
          }
          index++;
        }
        if (index == 0 || !added) {
          res.add(country);
        }
      }
    }
    return res;
  }

  int? _getPointsForCountry(int id) {
    List<PointVote> votes = ApplicationCore().authBloc.user!.pointVotes;
    int? res;
    for (var vote in votes) {
      if (vote.countryId == id) {
        res = vote.points;
      }
    }
    return res;
  }
}
