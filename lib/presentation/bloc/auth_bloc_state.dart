part of 'auth_bloc_bloc.dart';

sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

// Sign in States
final class SignInLoadingState extends AuthBlocState {}

final class SignInSuccessState extends AuthBlocState {
  final AuthEntity userEntity;
  SignInSuccessState(this.userEntity);
}

final class SignInFailureState extends AuthBlocState {
  final String message;
  SignInFailureState(this.message);
}

// Sign Up States

final class SignUpLoadingState extends AuthBlocState {}

final class SignUpSuccessState extends AuthBlocState {}

final class SignUpFailureState extends AuthBlocState {
  final String message;
  SignUpFailureState(this.message);
}
