import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/providers/state/status.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StatusContainer extends HookWidget {
  final Widget child;
  final Widget? error;
  final Widget? rejected;
  final Widget? pending;
  final Widget? idle;

  final StateProvider<Status> statusProvider;
  final StateProvider<dynamic>? errorProvider;

  final bool showIdle;
  final bool showPending;
  final bool showRejected;
  final bool showFulfilled;

  const StatusContainer({
    Key? key,
    required this.child,
    required this.statusProvider,
    this.errorProvider,
    this.error,
    this.rejected,
    this.pending,
    this.idle,
    this.showIdle = true,
    this.showPending = true,
    this.showRejected = true,
    this.showFulfilled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = useProvider(statusProvider).state;
    final error =
        errorProvider != null ? useProvider(errorProvider!).state : null;

    final bool showIdle = useMemoized(() {
      return this.showIdle && status == Status.idle;
    }, [status, this.showIdle]);

    final bool showPending = useMemoized(() {
      return this.showPending && status == Status.pending;
    }, [status, this.showPending]);

    final bool showRejected = useMemoized(() {
      return this.showRejected && status == Status.rejected;
    }, [status, this.showRejected]);

    final bool showFulfilled = useMemoized(() {
      return this.showFulfilled && status == Status.fulfilled;
    }, [status, this.showFulfilled]);

    print('status: $status');
    print('showIdle: $showIdle');
    print('this.showPending: ${this.showPending}');
    print('showPending: $showPending');
    print('showRejected: $showRejected');
    print('showFulfilled: $showFulfilled');

    if (showFulfilled) {
      return child;
    } else if (showRejected) {
      return rejected ?? _Rejected(error: error);
    } else if (showPending) {
      return pending ?? const _Pending();
    } else {
      return idle ?? Container();
    }
  }
}

class _Pending extends HookWidget {
  const _Pending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Rejected extends HookWidget {
  final dynamic error;

  const _Rejected({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error?.toString() ?? 'An error has occurred'),
    );
  }
}
