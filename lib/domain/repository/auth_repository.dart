import 'package:dartz/dartz.dart';
import 'package:ums/core/failures.dart';
import 'package:ums/domain/entity/auth_entity.dart';

abstract class AuthRepository {

  Future<Either<Failure, AuthEntity>> signIn(String username, String password);

  Future<Either<Failure, AuthEntity>> signUp(String email, String username, String password);

}

