// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppTranslations {
  AppTranslations();

  static AppTranslations? _current;

  static AppTranslations get current {
    assert(_current != null,
        'No instance of AppTranslations was loaded. Try to initialize the AppTranslations delegate before accessing AppTranslations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppTranslations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppTranslations();
      AppTranslations._current = instance;

      return instance;
    });
  }

  static AppTranslations of(BuildContext context) {
    final instance = AppTranslations.maybeOf(context);
    assert(instance != null,
        'No instance of AppTranslations present in the widget tree. Did you add AppTranslations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppTranslations? maybeOf(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations);
  }

  /// `This field is required`
  String get validationRequired {
    return Intl.message(
      'This field is required',
      name: 'validationRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please provide a valid email address`
  String get validationEmail {
    return Intl.message(
      'Please provide a valid email address',
      name: 'validationEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password is too short`
  String get validationPasswordShort {
    return Intl.message(
      'Password is too short',
      name: 'validationPasswordShort',
      desc: '',
      args: [],
    );
  }

  /// `Flutter Zero`
  String get appName {
    return Intl.message(
      'Flutter Zero',
      name: 'appName',
      desc: 'The name of the app',
      args: [],
    );
  }

  /// `Please wait`
  String get loadingMessage {
    return Intl.message(
      'Please wait',
      name: 'loadingMessage',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get errorMessage {
    return Intl.message(
      'Something went wrong',
      name: 'errorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Random Pokemon`
  String get randomPokemon {
    return Intl.message(
      'Random Pokemon',
      name: 'randomPokemon',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppTranslations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppTranslations> load(Locale locale) => AppTranslations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
