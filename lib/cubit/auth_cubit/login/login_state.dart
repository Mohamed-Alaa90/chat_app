part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String errorMessage;

  LoginError({required this.errorMessage});
}

class LoginSucsses extends LoginState {
  final User user;

  LoginSucsses({required this.user});
}
