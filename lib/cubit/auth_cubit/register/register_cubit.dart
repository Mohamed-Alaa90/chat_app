import 'package:chat_app/repository/register_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository _authRepository;
  RegisterCubit(this._authRepository) : super(RegisterInitial());

  Future<void> signUp(String email, String password, String name) async {
    emit(RegisterLoading());
    try {
      final user = await _authRepository.signUp(email, password, name);

      if (user is User) {
        emit(RegisterSuccess(user: user));
      } else {
        emit(RegisterError(errorMessage: user.toString()));
      }
    } catch (e) {
      emit(RegisterError(errorMessage: e.toString()));
    }
  }
}
