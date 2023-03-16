import 'package:eurovision_app/blocs/auth/auth_bloc.dart';

class ApplicationCore {
  static final ApplicationCore _instance = ApplicationCore._internal();

  factory ApplicationCore() => _instance;

  ApplicationCore._internal();

  final AuthBloc authBloc = AuthBloc();

  Future<void> onCreate() async {}
}
