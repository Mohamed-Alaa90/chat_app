import 'package:chat_app/auth/login_or_register.dart';
import 'package:chat_app/pages/my_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGet extends StatelessWidget {
  const AuthGet({super.key});
  static const String route ='authGet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyHomePage();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
