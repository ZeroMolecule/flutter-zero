import 'package:auto_route/auto_route.dart';
import 'package:flutter_zero/flow/auth/auth_provider.dart';
import 'package:flutter_zero/navigation/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthGuard extends AutoRouteGuard {
  final Ref _ref;

  AuthGuard(this._ref);

  AuthProvider get _authProvider => _ref.read(authProvider);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    await _authProvider.init();
    if (!_authProvider.isAuthenticated) {
      await router.navigate(const LoginRoute());
    }
    resolver.next(_authProvider.isAuthenticated);
  }
}
