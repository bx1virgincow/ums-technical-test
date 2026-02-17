import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ums/domain/entity/auth_entity.dart';
import 'package:ums/domain/usecase/sign_in_usecase.dart';
import 'package:ums/domain/usecase/sign_up_usecase.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final SignInUseCase signInUseCase;
  final SignUpUsecase signUpUsecase;
  AuthBlocBloc({required this.signInUseCase, required this.signUpUsecase})
    : super(AuthBlocInitial()) {
    on<SignUpEvent>(_onSignUpEvent);
    on<SignInEvent>(_onSignInEvent);
  }

  FutureOr<void> _onSignUpEvent(
    SignUpEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(SignUpLoadingState());
    final result = await signUpUsecase(
      SignUpParams(email: event.email, username: event.username, password: event.password),
    );
    result.fold(
      (failure) => emit(SignUpFailureState(failure.message)),
      (success) => emit(SignUpSuccessState()),
    );
  }

  FutureOr<void> _onSignInEvent(
    SignInEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(SignInLoadingState());
    final result = await signInUseCase(
      SignInParams(username: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(SignInFailureState(failure.message)),
      (success) => emit(SignInSuccessState(success)),
    );
  }
}
