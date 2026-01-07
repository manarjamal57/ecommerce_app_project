import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_project/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../domain/entites/user_entity.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    emit(SignupLoading());

    final result =
        await authRepo.createUserWithEmailAndPassword(email, password, name);

    result.fold(
      (failure) {
        // ✅ لوق سبب الفشل
        if (kDebugMode) {
          debugPrint('❌ Signup failed: ${failure.message}');
        }
        emit(SignupFailure(message: failure.message));
      },
      (userEntity) {
        // ✅ لوق نجاح (اختياري)
        if (kDebugMode) {
          debugPrint('✅ Signup success: ${userEntity.uId}');
        }
        emit(SignupSuccess(userEntity: userEntity));
      },
    );
  }
}
