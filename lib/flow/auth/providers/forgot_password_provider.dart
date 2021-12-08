import 'package:flutter/material.dart';
import 'package:flutter_zero/providers/di/repository_providers.dart';
import 'package:flutter_zero/util/async_action.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final forgotPasswordProvider = ChangeNotifierProvider.autoDispose(
  (ref) => ForgotPasswordProvider(ref),
);

class ForgotPasswordProvider with ChangeNotifier {
  final Ref _ref;
  late final _authRepository = _ref.read(authRepositoryProvider);

  late final actionSubmit = AsyncAction();

  ForgotPasswordProvider(this._ref);

  Future<void> submit({required String email}) => actionSubmit
      .run(() => _authRepository.requestPasswordReset(email: email));

  @override
  void dispose() {
    actionSubmit.dispose();
    super.dispose();
  }
}
