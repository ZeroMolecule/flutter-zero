import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';

useStreamListener<T>(
  Stream<T> stream,
  Function(T) onData, {
  Function? onError,
  Function()? onDone,
  bool? cancelOnError,
  List<Object?> keys = const [],
}) {
  use(_StreamListenerHook<T>(
    stream: stream,
    onData: onData,
    onError: onError,
    cancelOnError: cancelOnError,
    onDone: onDone,
    keys: keys,
  ));
}

class _StreamListenerHook<T> extends Hook {
  final Stream<T> stream;
  final Function(T) onData;
  final Function? onError;
  final Function()? onDone;
  final bool? cancelOnError;

  const _StreamListenerHook({
    required this.stream,
    required this.onData,
    this.onError,
    this.onDone,
    this.cancelOnError,
    List<Object?> keys = const [],
  }) : super(keys: keys);

  @override
  HookState<dynamic, Hook> createState() => _StreamListenerHookState<T>();
}

class _StreamListenerHookState<T>
    extends HookState<dynamic, _StreamListenerHook<T>> {
  late final _compositeSubscription = CompositeSubscription();

  @override
  void initHook() {
    _compositeSubscription.add(hook.stream.listen(
      hook.onData,
      onError: hook.onError,
      onDone: hook.onDone,
      cancelOnError: hook.cancelOnError,
    ));
    super.initHook();
  }

  @override
  Widget? build(BuildContext context) {}

  @override
  void dispose() {
    _compositeSubscription.dispose();
    super.dispose();
  }
}
