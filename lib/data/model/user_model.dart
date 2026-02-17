
import 'package:ums/domain/entity/user_entity.dart';

class UserModel {
  final int id;
  final String username;
  final String email;
  final String password;
  final String token;
  final String createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.token,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      token: json['token'],
      createdAt: json['created_at'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: this.id,
      username: this.username,
      email: this.email,
      password: this.password,
      token: this.token,
      createdAt: this.createdAt
    );
  } 
}