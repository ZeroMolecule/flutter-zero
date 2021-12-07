import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/extensions/navigator_extensions.dart';
import 'package:flutter_zero/flow/auth/providers/auth_provider.dart';
import 'package:flutter_zero/hooks/async_action_hook.dart';
import 'package:flutter_zero/hooks/global_key_hook.dart';
import 'package:flutter_zero/navigation/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useGlobalKey<FormState>();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final provider = ref.watch(authProvider);

    final handleLogin = useAsyncAction(
      () => provider.login(
        identifier: emailController.text,
        password: passwordController.text,
      ),
      onDone: () {
        AutoRouter.of(context).popOrReplaceAll([const HomeRoute()]);
      },
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => provider.loginGoogle(),
              child: const Text('Google'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Facebook'),
            ),
            ElevatedButton(
              onPressed: () => provider.loginApple(),
              child: const Text('Apple'),
            ),
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
                    onPressed: handleLogin,
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
