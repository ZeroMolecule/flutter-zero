import 'package:flutter_zero/navigation/app_router.gr.dart';
import 'package:flutter_zero/navigation/auth_guard.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authGuardProvider = Provider((ref) => AuthGuard(ref));
final appRouterProvider = Provider(
  (ref) => AppRouter(
    authGuard: ref.read(authGuardProvider),
  ),
);
