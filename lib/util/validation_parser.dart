import 'package:flutter_zero/gen/l10n.dart';
import 'package:flutter_zero/util/error_parser.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ValidationParser {
  final AppTranslations _t;
  final ErrorParser _errorParser;

  const ValidationParser(this._t, this._errorParser);

  Map<String, String> parse(
    FormControl control, {
    Map<String, String> overrides = const {},
  }) =>
      {
        ValidationMessage.email: _t.validationEmail,
        ValidationMessage.required: _t.validationRequired,
        'error': _errorParser.parse(control.getError('error')),
        ...overrides,
      };
}
