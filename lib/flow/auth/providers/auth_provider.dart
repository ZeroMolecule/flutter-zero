import 'package:flutter/material.dart';
import 'package:flutter_zero/domain/data/session.dart';
import 'package:flutter_zero/domain/data/user.dart';
import 'package:flutter_zero/domain/repository/auth_repository.dart';
import 'package:flutter_zero/extensions/change_notifier_extensions.dart';
import 'package:flutter_zero/providers/di/repository_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = ChangeNotifierProvider(
  (ref) => AuthProvider(ref),
);

class AuthProvider with ChangeNotifier {
  final Ref _ref;
  late final AuthRepository _authRepository = _ref.read(authRepositoryProvider);

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

  Future<Session> login({
    required String identifier,
    required String password,
  }) async {
    final session = await _authRepository.login(
      identifier: identifier,
      password: password,
    );
    _sessionValue = AsyncValue.data(session);
    notifyListeners();
    return session;
  }

  Future<Session> loginGoogle() async {
    final session = await _authRepository.loginGoogle();
    _sessionValue = AsyncValue.data(session);
    notifyListeners();
    return session;
  }

  Future<Session> loginApple() async {
    final session = await _authRepository.loginApple();
    _sessionValue = AsyncValue.data(session);
    notifyListeners();
    return session;
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _sessionValue = const AsyncValue.data(null);
    notifyListeners();
  }
}