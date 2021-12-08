import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/hooks/translation_hook.dart';
import 'package:flutter_zero/util/error_parser.dart';
import 'package:flutter_zero/util/validation_parser.dart';

ValidationParser useValidationParser() {
  final t = useTranslation();
  return useMemoized(() => ValidationParser(t, ErrorParser(t)), [t]);
}
