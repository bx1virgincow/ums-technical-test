import 'package:ums/core/api_response.dart';
import 'package:ums/core/typedef.dart';
import 'package:ums/feature/bottom_nav/domain/entity/login_response_entity.dart';

import '../entity/initiate_entity.dart';

abstract class AuthRepository {
  ResultFuture<LoginResponseEntity> signIn(String username, String password);

  ResultFuture<ApiResponse<String>> signUp(
    String email,
    String username,
    String password,
  );

  ResultFuture<InitiateEntity> initiateLogin(
    String identifier,
    String password,
  );

  ResultFuture<ApiResponse<String>> verifyOtp(String email, String otp);
}
