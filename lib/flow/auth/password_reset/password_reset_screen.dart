import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/extensions/navigator_extensions.dart';
import 'package:flutter_zero/flow/auth/password_reset/password_reset_provider.dart';
import 'package:flutter_zero/hooks/async_action_hook.dart';
import 'package:flutter_zero/hooks/form_hook.dart';
import 'package:flutter_zero/navigation/app_router.gr.dart';
import 'package:flutter_zero/util/validation_parser.dart';
import 'package:flutter_zero/widgets/dialogs/info_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PasswordResetScreen extends HookConsumerWidget {
  final String code;

  const PasswordResetScreen({
    Key? key,
    @pathParam required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(passwordResetProvider);
    final form = useForm({
      'password': FormControl<String>(validators: [
        Validators.required,
        Validators.minLength(6),
      ]),
      'passwordConfirm': FormControl<String>(),
    }, validators: [
      Validators.mustMatch('password', 'passwordConfirm')
    ]);

    final handleSubmit = useCallback(() {
      form.markAllAsTouched();
      if (form.valid) {
        return provider.submit(
          code: code,
          password: form.control('password').value,
          passwordConfirm: form.control('passwordConfirm').value,
        );
      }
    }, [form, provider, code]);

    useAsyncAction(
      provider.actionSubmit,
      onDone: () {
        InfoDialog.show(
          context,
          titleText: 'Success',
          contentText: 'Your password has been reset. Try using it to sign in',
          onPrimaryPressed: () => AutoRouter.of(context).popOrReplaceAll([
            const HomeRoute(),
          ]),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(),
      body: ReactiveForm(
        formGroup: form,
        child: Column(
          children: [
            ReactiveTextField(
              formControlName: 'password',
              validationMessages: ValidationParser.parse,
            ),
            const SizedBox(height: 12),
            ReactiveTextField(
              formControlName: 'passwordConfirm',
              validationMessages: ValidationParser.parse,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: handleSubmit,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
