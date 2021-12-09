import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/extensions/navigator_extensions.dart';
import 'package:flutter_zero/flow/auth/auth_provider.dart';
import 'package:flutter_zero/hooks/async_action_hook.dart';
import 'package:flutter_zero/hooks/form_hook.dart';
import 'package:flutter_zero/navigation/app_router.gr.dart';
import 'package:flutter_zero/util/validation_parser.dart';
import 'package:flutter_zero/widgets/dialogs/info_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authProvider);
    final form = useForm({
      'email': FormControl<String>(validators: [
        Validators.required,
        Validators.email,
      ]),
      'password': FormControl<String>(validators: [
        Validators.required,
        Validators.minLength(6),
      ]),
    });

    final handleSubmit = useCallback(() {
      if ((form..markAllAsTouched()).valid) {
        provider.register(
          email: form.control('email').value,
          password: form.control('password').value,
        );
      }
    }, [provider, form]);

    useAsyncAction(provider.actionRegister, onDone: () {
      InfoDialog.show(
        context,
        titleText: 'Registration successful',
        contentText: 'Check your email',
        onPrimaryPressed: () => AutoRouter.of(context).popOrReplaceAll([
          const HomeRoute(),
        ]),
      );
    });

    return Scaffold(
      appBar: AppBar(),
      body: ReactiveForm(
        formGroup: form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ReactiveTextField(
              formControlName: 'email',
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              validationMessages: ValidationParser.parse,
            ),
            ReactiveTextField(
              formControlName: 'password',
              obscureText: true,
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              textCapitalization: TextCapitalization.none,
              validationMessages: ValidationParser.parse,
            ),
            ElevatedButton(onPressed: handleSubmit, child: Text('Register')),
          ],
        ),
      ),
    );
  }
}
