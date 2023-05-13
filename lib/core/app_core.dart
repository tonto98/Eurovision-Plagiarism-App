import 'package:eurovision_app/blocs/auth/auth_bloc.dart';
import 'package:eurovision_app/blocs/countries/countries_bloc.dart';
import 'package:eurovision_app/blocs/results/results_bloc.dart';

class ApplicationCore {
  static final ApplicationCore _instance = ApplicationCore._internal();

  factory ApplicationCore() => _instance;

  ApplicationCore._internal();

  final AuthBloc authBloc = AuthBloc();
  final CountriesBloc countriesBloc = CountriesBloc();
  final ResultsBloc resultsBloc = ResultsBloc();

  static Map<String, String> headers = {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*/*",
    "Accept-Encodig": "gzip, deflate, br",
    "Connection": "keep-alive"
  };

  Future<void> onCreate() async {
    countriesBloc.getCountries();
  }
}
