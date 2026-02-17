import 'package:http/http.dart' as http;

import 'package:get_it/get_it.dart';
import 'package:ums/data/repository/auth_repository_impl.dart';
import 'package:ums/data/source/remote_source.dart';
import 'package:ums/domain/repository/auth_repository.dart';
import 'package:ums/domain/usecase/sign_up_usecase.dart';
import 'package:ums/presentation/bloc/auth_bloc_bloc.dart';

import 'domain/usecase/sign_in_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize dependencies here
  sl.registerLazySingleton<http.Client>(() => http.Client());

  sl
    ..registerLazySingleton<RemoteSource>(() => RemoteSourceImpl(sl()))
    ..registerLazySingleton<SignInUseCase>(() => SignInUseCase(sl()))
    ..registerLazySingleton<SignUpUsecase>(() => SignUpUsecase(sl()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerFactory(
    () => AuthBlocBloc(signInUseCase: sl(), signUpUsecase: sl()),
  );
}
