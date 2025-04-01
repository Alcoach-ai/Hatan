import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/screens/auth/splash_screen.dart';

import 'bloc/bloc_observer.dart';
import 'local/cache_helper.dart';
import 'models/dio_helper.dart';

Future<void> main() async {
  BlocOverrides.runZoned(() {}, blocObserver: MyBlocObserver());
  DioHelper.init();

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
