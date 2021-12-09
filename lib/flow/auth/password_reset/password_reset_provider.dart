import 'package:flutter/material.dart';
import 'package:flutter_zero/domain/repository/auth_repository.dart';
import 'package:flutter_zero/providers/di/repository_providers.dart';
import 'package:flutter_zero/util/async_action.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final passwordResetProvider = ChangeNotifierProvider.autoDispose(
  (ref) => PasswordResetProvider(ref),
);

class PasswordResetProvider with ChangeNotifier {
  final Ref _ref;
  late final AuthRepository _authRepository = _ref.read(authRepositoryProvider);

  late final AsyncAction actionSubmit = AsyncAction();

  PasswordResetProvider(this._ref);

  Future<void> submit({
    required String code,
    required String password,
    required String passwordConfirm,
  }) =>
      actionSubmit.run(() => _authRepository.resetPassword(
            code: code,
            password: password,
            passwordConfirm: passwordConfirm,
          ));

  @override
  void dispose() async {
    await actionSubmit.dispose();
    super.dispose();
  }
}
