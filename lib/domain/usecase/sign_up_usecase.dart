import 'package:dartz/dartz.dart';
import 'package:ums/core/failures.dart';
import 'package:ums/core/usecase.dart';
import 'package:ums/domain/repository/auth_repository.dart';

import '../entity/auth_entity.dart';

class SignUpUsecase extends Usecase<AuthEntity, SignUpParams> {
  final AuthRepository repository;
  SignUpUsecase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(SignUpParams param) {
    return repository.signUp(param.email, param.username, param.password);
  }
}

class SignUpParams {
  final String email;
  final String username;
  final String password;

  SignUpParams({required this.email, required this.username, required this.password});
}
