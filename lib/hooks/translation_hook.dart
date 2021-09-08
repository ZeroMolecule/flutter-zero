import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

AppLocalizations useTranslation() => use(const _TranslationHook());

class _TranslationHook extends Hook<AppLocalizations> {
  const _TranslationHook({
    List<Object>? keys,
  }) : super(keys: keys);

  @override
  HookState<AppLocalizations, Hook<AppLocalizations>> createState() =>
      _TranslationHookState();
}

class _TranslationHookState
    extends HookState<AppLocalizations, _TranslationHook> {
  @override
  AppLocalizations build(BuildContext context) => AppLocalizations.of(context)!;
}
