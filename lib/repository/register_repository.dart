import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    }
  }

  String _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return "البريد الإلكتروني غير صالح";

      case 'email-already-in-use':
        return "البريد الإلكتروني مستخدم بالفعل، جرّب بريدًا آخر";

      case 'user-not-found':
        return "المستخدم غير موجود";

      case 'wrong-password':
        return "كلمة المرور غير صحيحة";

      case 'user-disabled':
        return "تم تعطيل الحساب";

      case 'too-many-requests':
        return "محاولات تسجيل دخول كثيرة، حاول لاحقًا";

      case 'network-request-failed':
        return "تأكد من اتصال الإنترنت";

      default:
        return "حدث خطأ غير متوقع، حاول مرة أخرى";
    }
  }
}
