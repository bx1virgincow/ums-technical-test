part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final String? errorMessage;
  final UserEntity? user;
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.errorMessage,
    this.user,
  });
  
  @override
  List<Object?> get props => [status, errorMessage, user];
}
