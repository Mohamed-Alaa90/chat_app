import 'package:firebase_auth/firebase_auth.dart';

class SignOutRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("فشل تسجيل الخروج: ${e.toString()}");
    }
  }
}
