import 'package:chat_app/repository/sign_out_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signout_state.dart';

class SignoutCubit extends Cubit<SignoutState> {
  final SignOutRepository _signOutRepository;
  SignoutCubit(this._signOutRepository) : super(SignoutInitial());

  Future<void> signOut() async {
    emit(SignOutloading());

    try {
      await _signOutRepository.signOut();
      emit(SignOutSuccess());
    } catch (e) {
      emit(
        SignOutError(
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
