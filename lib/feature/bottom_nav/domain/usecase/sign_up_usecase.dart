import 'package:dartz/dartz.dart';
import 'package:ums/core/api_response.dart';
import 'package:ums/core/failures.dart';
import 'package:ums/core/usecase.dart';
import 'package:ums/feature/bottom_nav/domain/repository/auth_repository.dart';


class SignUpUsecase extends Usecase<ApiResponse<String>, SignUpParams> {
  final AuthRepository repository;
  SignUpUsecase(this.repository);

  @override
  Future<Either<Failure, ApiResponse<String>>> call(SignUpParams param) {
    return repository.signUp(param.email, param.username, param.password);
  }
}

class SignUpParams {
  final String email;
  final String username;
  final String password;

  SignUpParams({required this.email, required this.username, required this.password});
}
