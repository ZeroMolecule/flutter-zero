import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/widgets/loading_overlay.dart';

void _showLoading(BuildContext context) => LoadingOverlay.show(context);

void _dismissLoading() => LoadingOverlay.dismiss();

void _showError(BuildContext context, Object error, StackTrace? stack) {
  ScaffoldMessenger.maybeOf(context)?.showSnackBar(
    const SnackBar(content: Text('Something went wrong')),
  );
}

void _dismissError(BuildContext context) {
  ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
}

useAsyncAction<T>(
  Future<T> Function() action, {
  Function()? onDone,
  Function(T)? onData,
  Function(Object error, [StackTrace? stack])? showError,
  Function()? showLoading,
  Function()? dismissLoading = _dismissLoading,
  Function()? dismissError,
  List<Object?> keys = const [],
}) {
  final context = useContext();
  return useCallback(() async {
    showLoading ??= () => _showLoading(context);
    showError ??= (Object error, [StackTrace? stack]) => _showError(
          context,
          error,
          stack,
        );
    dismissError ??= () => _dismissError(context);

    dismissError?.call();
    showLoading?.call();
    final T result;
    try {
      result = await action();
      dismissLoading?.call();
    } catch (error, stack) {
      showError?.call(error, stack);
      dismissLoading?.call();
      return;
    }
    onDone?.call();
    onData?.call(result);
  }, keys);
}
