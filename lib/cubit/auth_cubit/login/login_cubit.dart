import 'package:chat_app/repository/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;
  LoginCubit(this._loginRepository) : super(LoginInitial());

  Future<void> signIn(String email, String password) async {
    emit(LoginLoading());
    try {
      final user = await _loginRepository.signIn(email, password);

      if (user is User) {
        emit(LoginSucsses(user: user));
      } else {
        emit(LoginError(errorMessage: user.toString()));
      }
    } catch (e) {
      emit(LoginError(errorMessage: e.toString()));
    }
  }
}
