import 'package:auto_route/auto_route.dart';
import 'package:flutter_zero/navigation/app_router.gr.dart';
import 'package:flutter_zero/providers/auth_provider.dart';
import 'package:flutter_zero/providers/state/status.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthGuard extends AutoRouteGuard {
  final ProviderReference ref;

  AuthGuard(this.ref);

  bool get isAuthenticated =>
      ref.read(authStatusProvider).state == Status.fulfilled &&
      ref.read(authProvider).state?.jwt != null;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    await ref.read(authViewControllerProvider).init();
    if (!isAuthenticated) {
      await router.navigate(const LoginRoute());
    }
    resolver.next(isAuthenticated);
  }
}
