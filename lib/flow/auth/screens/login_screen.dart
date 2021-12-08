import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/extensions/navigator_extensions.dart';
import 'package:flutter_zero/flow/auth/providers/auth_provider.dart';
import 'package:flutter_zero/hooks/async_action_hook.dart';
import 'package:flutter_zero/hooks/form_hook.dart';
import 'package:flutter_zero/hooks/validation_parser_hook.dart';
import 'package:flutter_zero/navigation/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authProvider);
    final validationParser = useValidationParser();
    final form = useForm({
      'email': FormControl<String>(value: 'demo@mail.com', validators: [
        Validators.required,
        Validators.email,
      ]),
      'password': FormControl<String>(value: 'xxx123', validators: [
        Validators.required,
        Validators.minLength(6),
      ]),
    });

    final handleLogin = useCallback(() async {
      FocusScope.of(context).unfocus();
      form.markAllAsTouched();
      if (form.valid) {
        return provider.login(
          identifier: form.control('email').value,
          password: form.control('password').value,
        );
      }
    }, [form, provider]);

    useAsyncAction(
      provider.actionLogin,
      onDone: () => AutoRouter.of(context).popOrReplaceAll([const HomeRoute()]),
      onError: (e, _) => form.control('password').setErrors({'error': e}),
      onDismissError: () => form.control('password').removeError('error'),
      keys: [form, provider],
    );
    useAsyncAction(
      provider.actionLoginSocial,
      onDone: () => AutoRouter.of(context).popOrReplaceAll([const HomeRoute()]),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: provider.loginGoogle,
              child: const Text('Google'),
            ),
            ElevatedButton(
              onPressed: provider.loginApple,
              child: const Text('Apple'),
            ),
            ReactiveForm(
              formGroup: form,
              child: Column(
                children: [
                  ReactiveTextField(
                    formControlName: 'email',
                    decoration: const InputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validationMessages: validationParser.parse,
                  ),
                  ReactiveTextField(
                    formControlName: 'password',
                    decoration: const InputDecoration(hintText: 'Password'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validationMessages: validationParser.parse,
                  ),
                  ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: handleLogin,
                  ),
                  ElevatedButton(
                    onPressed: () => AutoRouter.of(context).navigate(
                      const ForgotPasswordRoute(),
                    ),
                    child: const Text('Forgot password'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
