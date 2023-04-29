import 'package:eurovision_app/blocs/auth/auth_state.dart';
import 'package:eurovision_app/models/user.dart';
import 'package:eurovision_app/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const AUTH_KEY = "auth";

class AuthBloc extends Cubit<AuthState> {
  bool isAuthenticated = false;
  String? username;
  User? user;
  AuthBloc() : super(AuthStateInitial()) {
    init();
  }

  void init() async {
    String? token = await _getLocalToken();
    if (token != null) {
      await logIn(username: token);
    } else {
      isAuthenticated = false;
      emit(AuthStateFail());
    }
  }

  Future<void> logIn({required String username}) async {
    // ping endpoint
    try {
      User? resUser = await AuthRepository.registerUser(username);
      if (resUser != null) {
        user = resUser;
        // save token
        _persistLocalToken(username);
        this.username = username;
        // emit success
        emit(AuthStateSuccess());
      } else {
        emit(AuthStateFail());
      }
    } catch (e) {
      emit(AuthStateFail());
    }
  }

  void logOut() {
    // delete token
    _deleteLocalToken();
    emit(AuthStateFail());
  }

  Future<String?> _getLocalToken() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    return _sp.getString(AUTH_KEY);
  }

  Future<void> _persistLocalToken(String token) async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _sp.setString(AUTH_KEY, token);
  }

  Future<void> _deleteLocalToken() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _sp.remove(AUTH_KEY);
  }

  int? getPointsForCountry(int id) {
    int? points;
    for (var element in user!.pointVotes) {
      if (element.countryId == id) {
        points = element.points;
      }
    }

    return points;
  }
}
