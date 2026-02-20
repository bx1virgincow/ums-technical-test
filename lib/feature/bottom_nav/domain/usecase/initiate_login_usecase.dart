import 'package:dartz/dartz.dart';
import 'package:ums/core/failures.dart';
import 'package:ums/core/usecase.dart';
import 'package:ums/feature/bottom_nav/domain/repository/auth_repository.dart';

import '../entity/initiate_entity.dart';

class InitiateLoginUsecase extends Usecase<InitiateEntity, InitiateParam> {
  final AuthRepository repository;
  InitiateLoginUsecase(this.repository);

  @override
  Future<Either<Failure, InitiateEntity>> call(InitiateParam param) {
    return repository.initiateLogin(param.identifier, param.password);
  }
}

class InitiateParam {
  final String identifier;
  final String password;
  InitiateParam({required this.identifier, required this.password});
}
