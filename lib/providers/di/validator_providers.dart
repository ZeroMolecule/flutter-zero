import 'package:flutter_zero/gen/l10n.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final emailValidatorProvider = Provider((ref) {
  final t = AppTranslations.current;
  return EmailValidator(errorText: t.validationEmail);
});

final passwordValidatorProvider = Provider.autoDispose(
  (ref) {
    final t = AppTranslations.current;
    return MultiValidator([
      RequiredValidator(errorText: t.validationRequired),
      MinLengthValidator(6, errorText: t.validationPasswordShort),
    ]);
  },
);
