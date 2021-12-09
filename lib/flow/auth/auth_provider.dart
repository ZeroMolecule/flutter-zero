import 'package:flutter/material.dart';
import 'package:flutter_zero/domain/data/session.dart';
import 'package:flutter_zero/domain/data/user.dart';
import 'package:flutter_zero/domain/repository/auth_repository.dart';
import 'package:flutter_zero/extensions/change_notifier_extensions.dart';
import 'package:flutter_zero/providers/di/repository_providers.dart';
import 'package:flutter_zero/util/async_action.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = ChangeNotifierProvider(
  (ref) => AuthProvider(ref),
);

class AuthProvider with ChangeNotifier {
  final Ref _ref;
  late final AuthRepository _authRepository = _ref.read(authRepositoryProvider);
  late final AsyncAction actionLogin = AsyncAction();
  late final AsyncAction actionLoginSocial = AsyncAction();
  late final AsyncAction actionLogout = AsyncAction();
  late final AsyncAction actionRegister = AsyncAction();
  late final AsyncAction actionResetPassword = AsyncAction();
  late final AsyncAction actionRequestPasswordReset = AsyncAction();

  AsyncValue<Session?> _sessionValue = const AsyncValue.loading();

  AuthProvider(this._ref);

  User? get user => _sessionValue.value?.user;

  String? get jwt => _sessionValue.value?.jwt;

  bool get isAuthenticated => _sessionValue.value != null;

  Future<void> init() async => asyncFetch<Session?>(
        (value) => _sessionValue = value,
        skipLoading: true,
        fetch: _authRepository.getSession,
      );

  Future<void> login({
    required String identifier,
    required String password,
  }) =>
      actionLogin.run(() async {
        final session = await _authRepository.login(
          identifier: identifier,
          password: password,
        );
        _sessionValue = AsyncValue.data(session);
        notifyListeners();
      });

  Future<void> loginGoogle() => actionLoginSocial.run(() async {
        final session = await _authRepository.loginGoogle();
        _sessionValue = AsyncValue.data(session);
        notifyListeners();
      });

  Future<void> loginApple() => actionLoginSocial.run(() async {
        final session = await _authRepository.loginApple();
        _sessionValue = AsyncValue.data(session);
        notifyListeners();
      });

  Future<void> register({
    required String email,
    required String password,
  }) =>
      actionRegister.run(() => _authRepository.register(
            email: email,
            password: password,
          ));

  Future<void> requestPasswordReset({
    required String email,
  }) =>
      actionRequestPasswordReset.run(() async {
        await _authRepository.requestPasswordReset(
          email: email,
        );
        await _authRepository.logout();
        _sessionValue = const AsyncValue.data(null);
        notifyListeners();
      });

  Future<void> resetPassword({
    required String code,
    required String password,
    required String passwordConfirm,
  }) =>
      actionResetPassword.run(() async {
        final session = await _authRepository.resetPassword(
          code: code,
          password: password,
          passwordConfirm: passwordConfirm,
        );
        _sessionValue = AsyncValue.data(session);
        notifyListeners();
      });

  Future<void> logout() => actionLogout.run(() async {
        await _authRepository.logout();
        _sessionValue = const AsyncValue.data(null);
        notifyListeners();
      });

  @override
  void dispose() async {
    await Future.wait([
      actionLogin.dispose(),
      actionLogout.dispose(),
      actionLoginSocial.dispose(),
      actionRegister.dispose(),
      actionResetPassword.dispose(),
      actionRequestPasswordReset.dispose(),
    ]);
    super.dispose();
  }
}
