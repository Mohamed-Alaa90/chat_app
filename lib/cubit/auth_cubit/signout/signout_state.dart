part of 'signout_cubit.dart';

@immutable
abstract class SignoutState {}

class SignoutInitial extends SignoutState {}

class SignOutloading extends SignoutState {}

class SignOutSuccess extends SignoutState {}

class SignOutError extends SignoutState {
  final String errorMessage;

  SignOutError({required this.errorMessage});
}
