import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_project/core/errors/exceptions.dart';
import 'package:ecommerce_app_project/core/errors/failures.dart';
import 'package:ecommerce_app_project/core/services/data_services.dart';
import 'package:ecommerce_app_project/core/services/firebase_auth_services.dart';
import 'package:ecommerce_app_project/core/utils/backend_endpoint.dart';
import 'package:ecommerce_app_project/features/auth/data/models/user_model.dart';
import 'package:ecommerce_app_project/features/auth/domain/entites/user_entity.dart';
import 'package:ecommerce_app_project/features/auth/domain/repos/auth_repo.dart';
import 'package:ecommerce_app_project/prifes.dart';
import 'package:flutter/foundation.dart';


const String kUserData = 'user_data';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthServices firebaseAuthServices;
  final DatabaseService databaseService;

  AuthRepoImpl({
    required this.firebaseAuthServices,
    required this.databaseService,
  });

  void _log(String where, Object e) {
    if (kDebugMode) debugPrint('🟠 [AuthRepoImpl][$where] $e');
  }

  // ====== تنظيف حساب Firebase إذا فشل التخزين ======
  Future<void> _deleteUserSafely() async {
    try {
      final current = firebaseAuthServices.currentUser;
      if (current != null) {
        await firebaseAuthServices.deleteUserSafely(current);
      }
    } catch (e) {
      _log('deleteUserSafely/failed', e);
    }
  }

  // ================= SIGN UP =================
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final user = await firebaseAuthServices.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );

      final userEntity = UserEntity(name: name, email: email, uId: user.uid);

      await addUserData(user: userEntity);
      await saveUserData(user: userEntity); // ✅ مفيد بعد التسجيل

      return right(userEntity);
    } on CustomException catch (e) {
      await _deleteUserSafely();
      return left(ServerFailure(e.message));
    } catch (e) {
      await _deleteUserSafely();
      _log('createUserWithEmailAndPassword/Unexpected', e);
      return left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  // ================= LOGIN (EMAIL) =================
  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final user = await firebaseAuthServices.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // ✅ زي المهندس: اجلب الداتا من Firestore ثم خزّنها محليًا
      final userEntity = await getUserData(uid: user.uid);
      await saveUserData(user: userEntity);

      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      _log('signInWithEmailAndPassword/Unexpected', e);
      return left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  // ================= LOGIN (GOOGLE) =================
  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final user = await firebaseAuthServices.signInWithGoogle();

      final exists = await databaseService.checkIfDataExists(
        path: BackendEndpoint.addUserData, // users
        docuementId: user.uid,
      );

      if (!exists) {
        // ✅ أول مرة: ننشئ وثيقة المستخدم
        final newUser = UserEntity(
          name: user.displayName ?? '',
          email: user.email ?? '',
          uId: user.uid,
        );
        await addUserData(user: newUser);
      }

      // ✅ زي المهندس (وبشكل أصح): اجلب ثم خزّن محليًا
      final userEntity = await getUserData(uid: user.uid);
      await saveUserData(user: userEntity);

      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      _log('signInWithGoogle/Unexpected', e);
      return left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  // ================= Firestore helpers =================
  @override
  Future<void> addUserData({required UserEntity user}) async {
    await databaseService.addData(
      path: BackendEndpoint.addUserData, // users
      documentId: user.uId,
      data: UserModel.fromEntity(user).toMap(),
    );
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    final data = await databaseService.getData(
      path: BackendEndpoint.addUserData, // users
      docuementId: uid,
    );

    if (data == null) {
      throw CustomException(message: 'بيانات المستخدم غير موجودة.');
    }

    return UserModel.fromMap(data as Map<String, dynamic>);
  }

  // ================= Local cache (like engineer) =================
  @override
  Future<void> saveUserData({required UserEntity user}) async {
    final jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await Prefs.setString(kUserData, jsonData);
  }
}
