
class UserEntity {
  final int id;
  final String username;
  final String email;
  final String password;
  final String token;
  final String createdAt;

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.token,
    required this.createdAt,
  });
}