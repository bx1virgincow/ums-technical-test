import 'package:ums/feature/bottom_nav/domain/entity/initiate_entity.dart';

class InitiateResponse {
  final String message;
  final bool verificationRequired;

  InitiateResponse({required this.message, required this.verificationRequired});

  factory InitiateResponse.fromJson(Map<String, dynamic> json) {
    return InitiateResponse(
      message: json['message'] as String,
      verificationRequired: json['verificationRequired'],
    );
  }

  InitiateEntity toEntity()=>InitiateEntity(
    message: message,
    verificationRequired: verificationRequired,
  );
}
