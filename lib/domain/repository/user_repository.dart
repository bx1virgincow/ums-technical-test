

import 'package:dartz/dartz.dart';
import 'package:ums/core/failures.dart';
import 'package:ums/domain/entity/user_entity.dart';

abstract class UserRepository {

  Future<Either<Failure, UserEntity>> getUserInfo();
}

