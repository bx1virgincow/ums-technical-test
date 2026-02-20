import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ums/core/token_manager.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<AppStarted>(_onAppStarted);
  }

  FutureOr<void> _onAppStarted(
    AppStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashInitial());
    emit(SplashLoading("Loading..."));
    final token = await TokenManager.getAccessToken();
    log('saved token: $token');
    if (token == null) {
      emit(NavigateToLogin());
      return;
    }
    emit(SplashLoading("Validating session..."));

   await Future.delayed(const Duration(seconds: 3)); 
   
    emit(NavigateToHome());

  }
}
