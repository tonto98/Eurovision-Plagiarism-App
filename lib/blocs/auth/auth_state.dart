import '../auth/auth_bloc.dart';

abstract class AuthState {}

class AuthStateInitial extends AuthState {}

class AuthStateSuccess extends AuthState {}

class AuthStateFail extends AuthState {}
