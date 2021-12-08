import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/hooks/stream_listener_hook.dart';
import 'package:flutter_zero/util/async_action.dart';
import 'package:flutter_zero/widgets/dialogs/loading_overlay.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  AsyncAction<T> action, {
  Function()? onDone,
  Function(T)? onData,
  Function(Object error, StackTrace? stack)? onError,
  Function()? onLoading,
  Function()? onDismissLoading,
  Function()? onDismissError,
  List<Object?> keys = const [],
}) {
  final context = useContext();
  useStreamListener<AsyncValue<T>>(
    action.stream,
    (event) async {
      if (onDismissLoading != null) {
        await onDismissLoading();
      } else {
        _dismissLoading();
      }

      if (onDismissError != null) {
        await onDismissError();
      } else {
        _dismissError(context);
      }

      await event.when(
        data: (data) async {
          onDone?.call();
          onData?.call(data);
        },
        error: (error, stack) async {
          if (onError != null) {
            onError(error, stack);
          } else {
            _showError(context, error, stack);
          }
        },
        loading: () async {
          if (onLoading != null) {
            onLoading();
          } else {
            _showLoading(context);
          }
        },
      );
    },
    keys: keys,
  );
}
