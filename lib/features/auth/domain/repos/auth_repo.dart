import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_project/core/errors/failures.dart';
import 'package:ecommerce_app_project/features/auth/domain/entites/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  );

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<Either<Failure, UserEntity>> signInWithGoogle();

  Future<void> addUserData({required UserEntity user});

  Future<UserEntity> getUserData({required String uid});

  Future<void> saveUserData({required UserEntity user});

}
