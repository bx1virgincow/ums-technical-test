part of 'auth_bloc_bloc.dart';

sealed class AuthBlocEvent {}

class SignInEvent extends AuthBlocEvent {
  final String identifier;
  final String otp;

  SignInEvent({required this.identifier, required this.otp});
}

class SignUpEvent extends AuthBlocEvent {
  final String email;
  final String username = 'TestUser';
  final String password;

  SignUpEvent({required this.email, required this.password});
}

class InitiateLoginEvent extends AuthBlocEvent {
  final String identifier;
  final String password;

  InitiateLoginEvent({required this.identifier, required this.password});
}

class GetProfileEvent extends AuthBlocEvent {
  final String token;
  GetProfileEvent({required this.token});
}

class VerifyOtpEvent extends AuthBlocEvent {
  final String email;
  final String otp;

  VerifyOtpEvent({required this.email, required this.otp});
}
