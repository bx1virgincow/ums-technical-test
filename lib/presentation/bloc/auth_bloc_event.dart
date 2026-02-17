part of 'auth_bloc_bloc.dart';

sealed class AuthBlocEvent {}

class SignInEvent extends AuthBlocEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthBlocEvent {
  final String email;
  final String username;
  final String password;

  SignUpEvent({
    required this.email,
    required this.username,
    required this.password,
  });
}


class GetProfileEvent extends AuthBlocEvent {
  final String token;
  GetProfileEvent({required this.token});
}