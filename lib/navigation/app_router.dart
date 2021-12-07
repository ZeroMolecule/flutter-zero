import 'package:auto_route/annotations.dart';
import 'package:flutter_zero/flow/auth/screens/login_screen.dart';
import 'package:flutter_zero/flow/home/home_screen.dart';
import 'package:flutter_zero/navigation/auth_guard.dart';
import 'package:flutter_zero/navigation/config_guard.dart';
import 'package:flutter_zero/navigation/splash_guard.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      page: HomeScreen,
      guards: [ConfigGuard, AuthGuard, SplashGuard],
    ),
    AutoRoute(
      page: LoginScreen,
      path: '/auth/login',
      usesPathAsKey: true,
      guards: [ConfigGuard, SplashGuard],
    ),
  ],
)
class $AppRouter {}
