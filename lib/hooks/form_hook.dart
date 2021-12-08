import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

FormGroup useForm(
  Map<String, AbstractControl<dynamic>> controls, {
  List<ValidatorFunction> validators = const [],
  List<AsyncValidatorFunction> asyncValidators = const [],
  int asyncValidatorsDebounceTime = 250,
  bool disabled = false,
}) =>
    useMemoized(
      () => FormGroup(
        controls,
        validators: validators,
        asyncValidators: asyncValidators,
        asyncValidatorsDebounceTime: asyncValidatorsDebounceTime,
        disabled: disabled,
      ),
      [],
    );
