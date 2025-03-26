import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        // 'userName': userCredential.user!.displayName,
      });
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseAuthError(e));
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
