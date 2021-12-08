import 'package:flutter_zero/providers/di/validator_providers.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef Validator<T> = String? Function(T value);

final forgotPasswordValidatorProvider = StateNotifierProvider.autoDispose(
  (ref) => ForgotPasswordValidator(ref.watch(emailValidatorProvider)),
);

class ForgotPasswordValidator extends StateNotifier<Validator<String?>> {
  final FieldValidator<String?> _emailValidator;

  ForgotPasswordValidator(this._emailValidator) : super(_emailValidator.call);

  void addError(Object error) {
    state = (value) => _emailValidator.call(value) ?? error.toString();
  }

  void clearError() {
    state = _emailValidator.call;
  }
}
