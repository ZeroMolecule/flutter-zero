import 'package:auto_route/annotations.dart';
import 'package:flutter_zero/example/screens/pokemon_details_screen.dart';
import 'package:flutter_zero/navigation/auth_guard.dart';
import 'package:flutter_zero/screens/home/home_screen.dart';
import 'package:flutter_zero/screens/login/login_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      page: HomeScreen,
      guards: [AuthGuard],
    ),
    AutoRoute(
      page: LoginScreen,
      path: '/auth/login',
      usesPathAsKey: true,
    ),
    AutoRoute(
      page: PokemonDetailsScreen,
      path: '/pokemon/:id',
      usesPathAsKey: true,
    )
  ],
)
class $AppRouter {}
