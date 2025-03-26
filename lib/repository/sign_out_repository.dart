import 'package:firebase_auth/firebase_auth.dart';

class SignOutRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    try {
      print("🔹 محاولة تسجيل الخروج...");
      await _auth.signOut();
      print("✅ تم تسجيل الخروج بنجاح!");
    } catch (e) {
      print("❌ فشل تسجيل الخروج: ${e.toString()}");
      throw Exception("فشل تسجيل الخروج: ${e.toString()}");
    }
  }
}
