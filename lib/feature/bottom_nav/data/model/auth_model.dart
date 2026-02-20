import 'package:ums/feature/bottom_nav/domain/entity/auth_entity.dart';

class AuthModel {
  final int id;
  final String username;
  final String email;
  final String token;
  AuthModel({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      token: json['token'],
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      id: this.id,
      username: this.username,
      email: this.email,
      token: this.token
    );
  }
}
