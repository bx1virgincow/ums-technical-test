import 'package:dartz/dartz.dart';
import 'package:ums/core/failures.dart';

import 'api_response.dart';


typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ApiFuture<T> = Future<ApiResponse<T>>;