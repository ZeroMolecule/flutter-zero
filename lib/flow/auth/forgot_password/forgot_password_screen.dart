import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/flow/auth/auth_provider.dart';
import 'package:flutter_zero/hooks/async_action_hook.dart';
import 'package:flutter_zero/hooks/form_hook.dart';
import 'package:flutter_zero/util/validation_parser.dart';
import 'package:flutter_zero/widgets/dialogs/info_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authProvider);
    final form = useForm({
      'email': FormControl<String>(
        validators: [
          Validators.required,
          Validators.email,
        ],
        value: 'david.macan+qa@zeromolecule.com',
      ),
    });

    final handleSubmit = useCallback(() async {
      FocusScope.of(context).unfocus();
      form.markAllAsTouched();
      if (form.valid) {
        return provider.requestPasswordReset(
          email: form.control('email').value,
        );
      }
    }, [provider, form]);

    useAsyncAction(
      provider.actionRequestPasswordReset,
      onDone: () {
        InfoDialog.show(
          context,
          titleText: 'Done',
          contentText: 'Gud gud',
          onPrimaryPressed: () => AutoRouter.of(context).pop(),
        );
      },
      onError: (error, _) => form.control('email').setErrors({'error': error}),
      onDismissError: () => form.control('email').removeError('error'),
    );
    return Scaffold(
      appBar: AppBar(),
      body: ReactiveForm(
        formGroup: form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReactiveTextField(
              formControlName: 'email',
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              autofocus: true,
              validationMessages: ValidationParser.parse,
            ),
            const SizedBox(height: 12),
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
