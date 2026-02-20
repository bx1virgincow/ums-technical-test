import 'package:dartz/dartz.dart';
import 'package:ums/core/failures.dart';
import 'package:ums/core/usecase.dart';
import 'package:ums/feature/bottom_nav/domain/entity/login_response_entity.dart';
import '../repository/auth_repository.dart';

class SignInUseCase extends Usecase<LoginResponseEntity, SignInParams> {
  final AuthRepository repository;
  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, LoginResponseEntity>> call(SignInParams param) {
    return repository.signIn(param.username, param.password);
  }
}

class SignInParams {
  final String username;
  final String password;

  SignInParams({required this.username, required this.password});
}
