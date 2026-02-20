import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ums/core/token_manager.dart';
import 'package:ums/feature/bottom_nav/presentation/bloc/auth_bloc_bloc.dart';
import 'package:ums/feature/splash/screen/splash_screen.dart';

import 'di.dart';
import 'feature/profile/presentation/bloc/profile_bloc.dart';
import 'feature/splash/bloc/splash_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TokenManager.init();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBlocBloc>()),
        BlocProvider(create: (context) => sl<SplashBloc>()),
        BlocProvider(create: (context) => sl<ProfileBloc>()),
      ],
      child: MaterialApp(
        title: 'UMS',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
