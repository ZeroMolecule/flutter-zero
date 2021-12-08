import 'package:flutter_zero/navigation/app_router.gr.dart';
import 'package:flutter_zero/navigation/auth_guard.dart';
import 'package:flutter_zero/navigation/config_guard.dart';
import 'package:flutter_zero/navigation/splash_guard.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authGuardProvider = Provider((ref) => AuthGuard(ref));
final configGuardProvider = Provider((ref) => ConfigGuard(ref));
final splashGuardProvider = Provider((ref) => SplashGuard());
final appRouterProvider = Provider(
  (ref) => AppRouter(
    configGuard: ref.read(configGuardProvider),
    authGuard: ref.read(authGuardProvider),
    splashGuard: ref.read(splashGuardProvider),
  ),
);
