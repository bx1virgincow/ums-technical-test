class AuthEntity {
  final int id;
  final String username;
  final String email;
  final String token;
  const AuthEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
  });
}
