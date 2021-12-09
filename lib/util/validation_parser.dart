import 'package:flutter_zero/gen/l10n.dart';
import 'package:flutter_zero/util/error_parser.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ValidationParser {
  const ValidationParser._();

  static Map<String, String> parse(
    FormControl control, {
    Map<String, String> overrides = const {},
  }) {
    final t = AppTranslations.current;
    return {
      ValidationMessage.email: t.validationEmail,
      ValidationMessage.required: t.validationRequired,
      'error': ErrorParser.parse(control.getError('error')),
      ...overrides,
    };
  }
}
