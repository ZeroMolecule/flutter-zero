import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/domain/data/auth_provider.dart';
import 'package:flutter_zero/extensions/navigator_extensions.dart';
import 'package:flutter_zero/hooks/global_key_hook.dart';
import 'package:flutter_zero/hooks/util.dart';
import 'package:flutter_zero/navigation/app_router.gr.dart';
import 'package:flutter_zero/providers/auth_provider.dart';
import 'package:flutter_zero/providers/state/status.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = useGlobalKey<FormState>();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final viewController = useProvider(authViewControllerProvider);
    final status = useProvider(authStatusProvider).state;
    final session = useProvider(authProvider).state;
    final error = useProvider(authErrorProvider).state;

    useAsyncEffect(() {
      if (status == Status.fulfilled && session != null) {
        AutoRouter.of(context).popOrReplaceAll([const HomeRoute()]);
      }
    }, [status, session]);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () =>
                    viewController.socialSignIn(AuthProvider.google),
                child: const Text('Google')),
            ElevatedButton(
                onPressed: () =>
                    viewController.socialSignIn(AuthProvider.facebook),
                child: const Text('Facebook')),
            ElevatedButton(
                onPressed: () =>
                    viewController.socialSignIn(AuthProvider.apple),
                child: const Text('Apple')),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(hintText: 'Password'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      viewController.localSignIn(
                        identifier: emailController.text,
                        password: passwordController.text,
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
