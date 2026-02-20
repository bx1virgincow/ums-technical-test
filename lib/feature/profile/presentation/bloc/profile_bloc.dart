import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ums/core/token_manager.dart';
import 'package:ums/feature/bottom_nav/domain/entity/user_entity.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<LoadProfileEvent>(_onLoadProfileEvent);
  }

  FutureOr<void> _onLoadProfileEvent(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileState(status: ProfileStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    final user = await TokenManager.getUser();
    if (user == null) {
      emit(
        ProfileState(
          status: ProfileStatus.error,
          errorMessage: 'Failed to load profile',
        ),
      );
      return;
    }
    emit(
      ProfileState(
        status: ProfileStatus.loaded,
        user: user,
        errorMessage: null,
      ),
    );
  }
}
