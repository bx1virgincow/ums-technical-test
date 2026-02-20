import '../../domain/entity/login_response_entity.dart';
import 'user_model.dart';

class LoginResponseModel {
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: UserModel.fromJson(json['user']),
    );
  }

  LoginResponseEntity toEntity() => LoginResponseEntity(
    accessToken: accessToken,
    refreshToken: refreshToken,
    user: user.toEntity(),
  );
}
