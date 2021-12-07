import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/widgets/loading_overlay.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

useStreamListener<T>(
  Stream<T> stream,
  void Function(T value) onListen,
) {
  useEffect(() {
    final subscription = stream.listen(onListen);
    return subscription.cancel;
  }, [stream]);
}

useAsyncValueListener<T>(
  Stream<AsyncValue<T>> actionStream, {
  Function([BuildContext? context])? onLoading = _onLoading,
  Function([BuildContext? context])? dismissLoading = _dismissLoading,
  Function(Object error, [BuildContext? context, StackTrace? stack])? onError =
      _onError,
  Function([BuildContext? context])? dismissError = _dismissError,
  Function(T)? onData,
}) {
  final context = useContext();
  useStreamListener<AsyncValue<T>>(
    actionStream,
    (value) {
      value.when(
        data: (data) async {
          await dismissLoading?.call(context);
          await dismissError?.call(context);
          return onData?.call(data);
        },
        error: (error, stack) async {
          await dismissLoading?.call(context);
          return onError?.call(error, context, stack);
        },
        loading: () async {
          await dismissError?.call(context);
          return onLoading?.call(context);
        },
      );
    },
  );
}

void _onLoading([BuildContext? context]) {
  print('Loading...');
  if (context != null) LoadingOverlay.show(context);
}

void _dismissLoading([BuildContext? context]) {
  if (context != null) LoadingOverlay.dismiss();
  print('Not loading');
}

void _onError(Object error, [BuildContext? context, StackTrace? stack]) {
  print('Error...');
  print(error);
  print(stack);
  if (context != null) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      const SnackBar(content: Text('Something went wrong')),
    );
  }
}

void _dismissError([BuildContext? context]) {
  if (context != null) {
    ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
  }
  print('No more error');
}
