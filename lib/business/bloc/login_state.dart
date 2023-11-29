part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoggedOut extends LoginState {}

class LoginLoading extends LoginState {}

class LoggedIn extends LoginState {
  final String jwt;

  LoggedIn(this.jwt);
}
