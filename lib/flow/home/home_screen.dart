import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/flow/auth/providers/auth_provider.dart';
import 'package:flutter_zero/hooks/async_action_hook.dart';
import 'package:flutter_zero/hooks/translation_hook.dart';
import 'package:flutter_zero/navigation/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = useTranslation();
    final provider = ref.read(authProvider);
    final user = ref.watch(authProvider.select((value) => value.user));
    final isAuthenticated = ref.watch(
      authProvider.select((value) => value.isAuthenticated),
    );

    final handleLogin = useCallback(() {
      AutoRouter.of(context).navigate(const LoginRoute());
    }, [provider]);

    useAsyncAction(provider.actionLogout);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user != null) Text(user.email),
            ElevatedButton(
              onPressed: isAuthenticated ? provider.logout : handleLogin,
              child: Text(isAuthenticated ? 'Logout' : 'Login'),
            ),
          ],
        ),
      ),
    );
  }
}
