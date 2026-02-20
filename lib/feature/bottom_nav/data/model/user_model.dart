
import '../../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.surname,
    required super.givenName,
    required super.phone,
    required super.email,
    required super.landmark,
    super.gpsCode,
    required super.role,
    required super.phoneVerified,
    required super.emailVerified,
    required super.emailVerifiedAt,
    super.phoneVerifiedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    surname,
    givenName,
    phone,
    email,
    landmark,
    gpsCode,
    role,
    phoneVerified,
    phoneVerifiedAt,
    emailVerified,
    emailVerifiedAt,
    createdAt,
    updatedAt,
  ];

  //factory method
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      surname: json["surname"],
      givenName: json["givenName"],
      phone: json["phone"],
      email: json["email"],
      landmark: json["landmark"],
      gpsCode: json["gpsCode"],
      role: json["role"],
      phoneVerified: json["phoneVerified"],
      emailVerified: json["emailVerified"],
      emailVerifiedAt: json["emailVerifiedAt"],
      phoneVerifiedAt: json["phoneVerifiedAt"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }

  // to entity method
  UserEntity toEntity() => UserEntity(
    id: id,
    surname: surname,
    givenName: givenName,
    phone: phone,
    email: email,
    landmark: landmark,
    gpsCode: gpsCode,
    role: role,
    phoneVerified: phoneVerified,
    emailVerified: emailVerified,
    emailVerifiedAt: emailVerifiedAt,
    phoneVerifiedAt: phoneVerifiedAt,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}