import 'package:dartz/dartz.dart';
import 'package:ums/core/failures.dart';
import 'package:ums/core/usecase.dart';

import '../../../../core/api_response.dart';
import '../repository/auth_repository.dart';

class VerifyOtpUsecase extends Usecase<ApiResponse<String>, VerifyOtpParams> {
  final AuthRepository repository;
  VerifyOtpUsecase(this.repository);

  @override
  Future<Either<Failure, ApiResponse<String>>> call(VerifyOtpParams param) {
    return repository.verifyOtp(param.email, param.otp);
  }
}

class VerifyOtpParams {
  final String email;
  final String otp;

  VerifyOtpParams({required this.email, required this.otp});
}
