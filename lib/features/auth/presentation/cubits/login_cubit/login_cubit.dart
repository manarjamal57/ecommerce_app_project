import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_project/features/auth/domain/repos/auth_repo.dart';
import 'package:ecommerce_app_project/features/auth/presentation/cubits/login_cubit/login_state.dart';
import 'package:meta/meta.dart';



class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());

  final AuthRepo authRepo;

  Future<void> signIn(String email, String password) async {
    emit(LoginLoading());
    final result = await authRepo.signInWithEmailAndPassword(email, password);

    result.fold(
      (failure) => emit(LoginFailure(message: failure.message)),
      (user) => emit(LoginSuccess(userEntity: user)),
    );
  }
  Future<void> signInWithGoogle() async {
  emit(LoginLoading());

  final result = await authRepo.signInWithGoogle();

  result.fold(
    (failure) => emit(LoginFailure(message: failure.message)),
    (user) => emit(LoginSuccess(userEntity: user)),
  );
}

}
