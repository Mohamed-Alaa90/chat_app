import 'package:chat_app/repository/sign_out_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signout_state.dart';

class SignoutCubit extends Cubit<SignoutState> {
  final SignOutRepository repository;

  SignoutCubit(this.repository) : super(SignoutInitial());

  Future<void> signOut() async {
    try {
      print("🔹 Cubit: محاولة تسجيل الخروج...");
      emit(SignOutloading());
      await repository.signOut();
      print("✅ Cubit: تسجيل الخروج بنجاح");
      emit(SignOutSuccess());
    } catch (e) {
      print("❌ Cubit: فشل تسجيل الخروج: ${e.toString()}");
      emit(SignOutError(errorMessage: "فشل تسجيل الخروج"));
    }
  }
}
