import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/gen/l10n.dart';

AppTranslations useTranslation() => use(const _TranslationHook());

class _TranslationHook extends Hook<AppTranslations> {
  const _TranslationHook({
    List<Object>? keys,
  }) : super(keys: keys);

  @override
  HookState<AppTranslations, Hook<AppTranslations>> createState() =>
      _TranslationHookState();
}

class _TranslationHookState
    extends HookState<AppTranslations, _TranslationHook> {
  @override
  AppTranslations build(BuildContext context) => AppTranslations.of(context);
}
