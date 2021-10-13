import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AsyncValueContainer<T> extends HookWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) onData;
  final Widget Function()? onLoading;
  final Widget Function(Object error, StackTrace? stackTrace)? onError;

  const AsyncValueContainer({
    Key? key,
    required this.value,
    required this.onData,
    this.onLoading,
    this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: onData,
      loading: onLoading ?? () => const AsyncLoadingWidget(),
      error: onError ??
          (error, stackTrace) => AsyncErrorWidget(
                error: error,
                stackTrace: stackTrace,
              ),
    );
  }
}

class AsyncLoadingWidget<T> extends HookWidget {
  const AsyncLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class AsyncErrorWidget<T> extends HookWidget {
  final Object error;
  final StackTrace? stackTrace;

  const AsyncErrorWidget({
    Key? key,
    required this.error,
    this.stackTrace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error.toString()),
    );
  }
}
