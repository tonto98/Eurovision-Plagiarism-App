import 'package:eurovision_app/blocs/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Cubit<AuthState> {
  late bool isAuthenticated;
  late String username;
  AuthBloc() : super(AuthStateInitial()) {
    // pitaj SP ako postoji user
    isAuthenticated = false;
    username = "filip";
    if (isAuthenticated) {
      emit(AuthStateSuccess());
    } else {
      emit(AuthStateFail());
    }
  }

  void logIn({required String username}) {
    this.username = username;
    emit(AuthStateSuccess());
  }

  void logOut() {
    emit(AuthStateFail());
  }
}
