import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ums/core/api_response.dart';
import 'package:ums/feature/bottom_nav/domain/entity/initiate_entity.dart';
import 'package:ums/feature/bottom_nav/domain/entity/login_response_entity.dart';
import 'package:ums/feature/bottom_nav/domain/usecase/initiate_login_usecase.dart';
import 'package:ums/feature/bottom_nav/domain/usecase/sign_in_usecase.dart';
import 'package:ums/feature/bottom_nav/domain/usecase/sign_up_usecase.dart';
import 'package:ums/feature/bottom_nav/domain/usecase/verify_otp_usecase.dart';

import '../../../../core/token_manager.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final SignInUseCase signInUseCase;
  final SignUpUsecase signUpUsecase;
  final InitiateLoginUsecase initiateLoginUsecase;
  final VerifyOtpUsecase verifyOtpUsecase;
  AuthBlocBloc({
    required this.signInUseCase,
    required this.signUpUsecase,
    required this.initiateLoginUsecase,
    required this.verifyOtpUsecase,
  }) : super(AuthBlocInitial()) {
    on<SignUpEvent>(_onSignUpEvent);
    on<SignInEvent>(_onSignInEvent);
    on<InitiateLoginEvent>(_onInitiateLoginEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
  }

  FutureOr<void> _onSignUpEvent(
    SignUpEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(SignUpLoadingState());
    final result = await signUpUsecase(
      SignUpParams(
        email: event.email,
        username: event.username,
        password: event.password,
      ),
    );
    return result.fold(
      (failure) => emit(SignUpFailureState(failure.message)),
      (response) => emit(SignUpSuccessState(response)),
    );
  }

  FutureOr<void> _onSignInEvent(
    SignInEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(SignInLoadingState());
    final result = await signInUseCase(
      SignInParams(username: event.identifier, password: event.otp),
    );
    return result.fold((failure) => emit(SignInFailureState(failure.message)), (
      success,
    ) async {
      // save token
      await TokenManager.saveAccessToken(success.accessToken);
      // save user to shared preferences
      await TokenManager.saveUser(success.user);
      emit(SignInSuccessState(success));
    });
  }

  FutureOr<void> _onInitiateLoginEvent(
    InitiateLoginEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(InitiateLoginLoading());
    final results = await initiateLoginUsecase(
      InitiateParam(identifier: event.identifier, password: event.password),
    );
    return results.fold(
      (failure) {
        emit(InitiateLoginFailure(failure.message));
      },
      (data) {
        emit(InitiateLoginSuccess(data));
      },
    );
  }

  FutureOr<void> _onVerifyOtpEvent(
    VerifyOtpEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(VerifyOtpLoading());
    final results = await verifyOtpUsecase(
      VerifyOtpParams(email: event.email, otp: event.otp),
    );
    return results.fold(
      (failure) {
        emit(VerifyOtpFailure(failure.message));
      },
      (data) {
        emit(VerifyOtpSuccess(data));
      },
    );
  }
}
