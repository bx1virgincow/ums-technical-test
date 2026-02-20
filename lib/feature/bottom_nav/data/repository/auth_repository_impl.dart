import 'package:dartz/dartz.dart';
import 'package:ums/core/api_response.dart';
import 'package:ums/core/failures.dart';
import 'package:ums/core/typedef.dart';
import 'package:ums/feature/bottom_nav/data/source/remote_source.dart';
import 'package:ums/feature/bottom_nav/domain/entity/initiate_entity.dart';
import 'package:ums/feature/bottom_nav/domain/entity/login_response_entity.dart';
import 'package:ums/feature/bottom_nav/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final RemoteSource remoteSource;
  AuthRepositoryImpl(this.remoteSource);

  @override
  Future<Either<Failure, LoginResponseEntity>> signIn(
    String username,
    String password,
  ) async {
    try {
      final results = await remoteSource.signIn(username, password);
      if (!results.success) {
        return Left(Failure(results.message));
      }
      final res = results.data!.toEntity();
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiResponse<String>>> signUp(
    String email,
    String username,
    String password,
  ) async {
    try {
      final results = await remoteSource.signUp(email, username, password);
      if (!results.success) {
        return Left(Failure(results.message));
      }
      return Right(results);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  ResultFuture<InitiateEntity> initiateLogin(
    String identifier,
    String password,
  ) async {
    try {
      final results = await remoteSource.initiateLogin(identifier, password);

      if (!results.success) {
        return Left(Failure(results.message));
      }
      final initRes = results.data!.toEntity();
      return Right(initRes);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  ResultFuture<ApiResponse<String>> verifyOtp(String email, String otp) async {
    try {
      return remoteSource.verifyOtp(email, otp).then((results) {
        if (!results.success) {
          return Left(Failure(results.message));
        }
        return Right(results);
      });
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
