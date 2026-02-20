import 'package:http/http.dart' as http;

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ums/feature/bottom_nav/data/repository/auth_repository_impl.dart';
import 'package:ums/feature/bottom_nav/data/source/remote_source.dart';
import 'package:ums/feature/bottom_nav/domain/repository/auth_repository.dart';
import 'package:ums/feature/bottom_nav/domain/usecase/initiate_login_usecase.dart';
import 'package:ums/feature/bottom_nav/domain/usecase/sign_up_usecase.dart';
import 'package:ums/feature/bottom_nav/domain/usecase/verify_otp_usecase.dart';
import 'package:ums/feature/bottom_nav/presentation/bloc/auth_bloc_bloc.dart';
import 'package:ums/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:ums/feature/splash/bloc/splash_bloc.dart';

import 'feature/bottom_nav/domain/usecase/sign_in_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<http.Client>(() => http.Client());

  sl
    ..registerLazySingleton<RemoteSource>(() => RemoteSourceImpl(sl()))
    ..registerLazySingleton<SignInUseCase>(() => SignInUseCase(sl()))
    ..registerLazySingleton<SignUpUsecase>(() => SignUpUsecase(sl()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
    ..registerLazySingleton<InitiateLoginUsecase>(
      () => InitiateLoginUsecase(sl()),
    )
    ..registerLazySingleton<VerifyOtpUsecase>(() => VerifyOtpUsecase(sl()));

  sl
    ..registerFactory<AuthBlocBloc>(
      () => AuthBlocBloc(
        signInUseCase: sl(),
        signUpUsecase: sl(),
        initiateLoginUsecase: sl(),
        verifyOtpUsecase: sl(),
      ),
    )
    ..registerFactory<SplashBloc>(() => SplashBloc())
    ..registerFactory<ProfileBloc>(() => ProfileBloc());
}
