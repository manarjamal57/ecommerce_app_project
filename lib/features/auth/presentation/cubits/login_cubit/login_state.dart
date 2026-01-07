import 'package:meta/meta.dart';
import '../../../domain/entites/user_entity.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserEntity userEntity;
  LoginSuccess({required this.userEntity});
}

final class LoginFailure extends LoginState {
  final String message;
  LoginFailure({required this.message});
}
