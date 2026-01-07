import 'package:ecommerce_app_project/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices {
  // ✅ لوق موحّد لكل الأخطاء
  void _log(String where, Object e, StackTrace st) {
    if (kDebugMode) {
      debugPrint('🔴 [$where] ERROR: $e');
      debugPrintStack(stackTrace: st);
    }
  }

  // ✅ Getter عشان AuthRepoImpl يقدر يستخدم currentUser
  User? get currentUser => FirebaseAuth.instance.currentUser;

  // ✅ حذف المستخدم بأمان (بدون !)
  Future<void> deleteUserSafely(User user) async {
    try {
      await user.delete();
    } on FirebaseAuthException catch (e, st) {
      _log('deleteUserSafely/FirebaseAuthException', e, st);
      throw CustomException(message: e.message ?? 'تعذر حذف المستخدم.');
    } catch (e, st) {
      _log('deleteUserSafely/Unexpected', e, st);
      throw CustomException(message: 'حدث خطأ غير متوقع أثناء حذف المستخدم.');
    }
  }

  // ✅ إذا بدك دالة deleteUser زي قبل (لكن آمنة)
  Future<void> deleteCurrentUserSafely() async {
    final user = currentUser;
    if (user == null) return;
    await deleteUserSafely(user);
  }

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw CustomException(message: 'فشل إنشاء الحساب');
      }

      await user.updateDisplayName(name);
      return user;
    } on FirebaseAuthException catch (e, st) {
      _log('createUserWithEmailAndPassword/FirebaseAuthException', e, st);

      if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: 'هذا البريد مسجّل مسبقًا. جرّبي تسجيل الدخول.');
      } else if (e.code == 'weak-password') {
        throw CustomException(
            message: 'كلمة المرور ضعيفة. يجب أن تكون 6 أحرف أو أكثر.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: 'صيغة البريد الإلكتروني غير صحيحة.');
      } else {
        throw CustomException(message: e.message ?? 'حدث خطأ أثناء إنشاء الحساب.');
      }
    } on CustomException catch (e, st) {
      _log('createUserWithEmailAndPassword/CustomException', e, st);
      rethrow;
    } catch (e, st) {
      _log('createUserWithEmailAndPassword/Unexpected', e, st);
      throw CustomException(message: 'حدث خطأ غير متوقع. حاولي مرة أخرى.');
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw CustomException(message: 'فشل تسجيل الدخول');
      }

      return user;
    } on FirebaseAuthException catch (e, st) {
      _log('signInWithEmailAndPassword/FirebaseAuthException', e, st);

      if (e.code == 'user-not-found') {
        throw CustomException(message: 'هذا البريد غير مسجّل.');
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        throw CustomException(message: 'البريد أو كلمة المرور غير صحيحة.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: 'صيغة البريد الإلكتروني غير صحيحة.');
      } else {
        throw CustomException(message: e.message ?? 'حدث خطأ أثناء تسجيل الدخول.');
      }
    } on CustomException catch (e, st) {
      _log('signInWithEmailAndPassword/CustomException', e, st);
      rethrow;
    } catch (e, st) {
      _log('signInWithEmailAndPassword/Unexpected', e, st);
      throw CustomException(message: 'حدث خطأ غير متوقع. حاولي مرة أخرى.');
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw CustomException(message: 'تم إلغاء تسجيل الدخول');
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;
      if (user == null) {
        throw CustomException(message: 'فشل تسجيل الدخول');
      }

      return user;
    } on FirebaseAuthException catch (e, st) {
      _log('signInWithGoogle/FirebaseAuthException', e, st);
      throw CustomException(message: e.message ?? 'خطأ في تسجيل الدخول');
    } on CustomException catch (e, st) {
      _log('signInWithGoogle/CustomException', e, st);
      rethrow;
    } catch (e, st) {
      _log('signInWithGoogle/Unexpected', e, st);
      throw CustomException(message: 'حدث خطأ غير متوقع. حاولي مرة أخرى.');
    }
  }
}
