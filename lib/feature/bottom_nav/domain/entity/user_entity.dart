import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String surname;
  final String givenName;
  final String phone;
  final String email;
  final String landmark;
  final String? gpsCode;
  final String role;
  final bool phoneVerified;
  final bool emailVerified;
  final String? emailVerifiedAt;
  final String? phoneVerifiedAt;
  final String createdAt;
  final String updatedAt;

  const UserEntity({
    required this.id,
    required this.surname,
    required this.givenName,
    required this.phone,
    required this.email,
    required this.landmark,
    this.gpsCode,
    required this.role,
    required this.phoneVerified,
    required this.emailVerified,
    required this.emailVerifiedAt,
    this.phoneVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      surname: json['surname'],
      givenName: json['givenName'],
      phone: json['phone'],
      email: json['email'],
      landmark: json['landmark'],
      gpsCode: json['gpsCode'],
      role: json['role'],
      phoneVerified: json['phoneVerified'],
      emailVerified: json['emailVerified'],
      emailVerifiedAt: json['emailVerifiedAt'],
      phoneVerifiedAt: json['phoneVerifiedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surname': surname,
      'givenName': givenName,
      'phone': phone,
      'email': email,
      'landmark': landmark,
      'gpsCode': gpsCode,
      'role': role,
      'phoneVerified': phoneVerified,
      'emailVerified': emailVerified,
      'emailVerifiedAt': emailVerifiedAt,
      'phoneVerifiedAt': phoneVerifiedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

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
}
