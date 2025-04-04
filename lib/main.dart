import 'package:chat_app/auth/login_or_register.dart';
import 'package:chat_app/cubit/auth_cubit/login/login_cubit.dart';
import 'package:chat_app/cubit/auth_cubit/register/register_cubit.dart';
import 'package:chat_app/cubit/auth_cubit/signout/signout_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/login_screen.dart';
import 'package:chat_app/pages/register_screen.dart';
import 'package:chat_app/pages/my_home_page.dart';
import 'package:chat_app/auth/auth_get.dart';
import 'package:chat_app/repository/login_repository.dart';
import 'package:chat_app/repository/register_repository.dart';
import 'package:chat_app/repository/sign_out_repository.dart';
import 'package:chat_app/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(RegisterRepository()),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(LoginRepository()),
        ),
        BlocProvider<SignoutCubit>(
          create: (context) => SignoutCubit(SignOutRepository()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('-----------------------------User is currently signed out!');
      } else {
        print('-----------------------------User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (context, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: DarkTheme.theme,
            initialRoute: AuthGet.route,
            routes: {
              AuthGet.route: (context) => const AuthGet(),
              LoginOrRegister.route: (context) => const LoginOrRegister(),
              MyHomePage.route: (context) => MyHomePage(),
              RegisterScreen.route: (context) => const RegisterScreen(),
              LoginScreen.route: (context) =>  const LoginScreen(),
            },
          ),
    );
  }
}
