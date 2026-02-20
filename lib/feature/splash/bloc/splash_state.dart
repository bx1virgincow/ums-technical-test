part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();
  
  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

final class SplashLoading extends SplashState {
  final String message;
  const SplashLoading(this.message);
}

final class NavigateToHome extends SplashState {}

final class NavigateToLogin extends SplashState {}