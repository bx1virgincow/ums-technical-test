part of 'auth_bloc_bloc.dart';

sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

// Sign in States
final class SignInLoadingState extends AuthBlocState {}

final class SignInSuccessState extends AuthBlocState {
  final LoginResponseEntity userEntity;
  SignInSuccessState(this.userEntity);
}

final class SignInFailureState extends AuthBlocState {
  final String message;
  SignInFailureState(this.message);
}

// Sign Up States

final class SignUpLoadingState extends AuthBlocState {}

final class SignUpSuccessState extends AuthBlocState {
  final ApiResponse<String> response;
  SignUpSuccessState(this.response);
}

final class SignUpFailureState extends AuthBlocState {
  final String message;
  SignUpFailureState(this.message);
}

// initiate login states

final class InitiateLoginLoading extends AuthBlocState {}

final class InitiateLoginSuccess extends AuthBlocState {
  final InitiateEntity entity;
  InitiateLoginSuccess(this.entity);
}

final class InitiateLoginFailure extends AuthBlocState {
  final String errorMessage;
  InitiateLoginFailure(this.errorMessage);
}

// verify otp states
final class VerifyOtpLoading extends AuthBlocState {}

final class VerifyOtpSuccess extends AuthBlocState {
  final ApiResponse<String> response;
  VerifyOtpSuccess(this.response);
}

final class VerifyOtpFailure extends AuthBlocState {
  final String errorMessage;
  VerifyOtpFailure(this.errorMessage);
}
