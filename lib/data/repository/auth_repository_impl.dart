

import 'package:dartz/dartz.dart';
import 'package:ums/core/failures.dart';
import 'package:ums/data/source/remote_source.dart';
import 'package:ums/domain/entity/auth_entity.dart';
import 'package:ums/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final RemoteSource remoteSource;
  AuthRepositoryImpl(this.remoteSource);

  @override
  Future<Either<Failure, AuthEntity>> signIn(String username, String password) async{
    try{
      final results = await remoteSource.signIn(username, password);
      return Right(results.toEntity());
    }catch(e){
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> signUp(String email, String username, String password) async{
    try{
      final results = await remoteSource.signUp(email, username, password);
      return Right(results.toEntity());
    }catch(e){
      return Left(Failure(e.toString()));
    }
  }
  
}