import 'package:hooks_riverpod/hooks_riverpod.dart';

enum Status {
  idle,
  pending,
  rejected,
  fulfilled,
}

Future<void> statefulAction({
  required StateController<Status> Function() status,
  required Future<dynamic> Function() action,
  StateController<dynamic> Function()? error,
}) async {
  status().state = Status.pending;
  try {
    await action();
    error?.call().state = null;
    status().state = Status.fulfilled;
  } catch (e, stack) {
    // todo: add error logging
    error?.call().state = e;
    status().state = Status.rejected;
  }
}

Future<void> statefulFetch<T>({
  required StateController<Status> Function() status,
  required StateController<T> Function() data,
  StateController<dynamic> Function()? error,
  required Future<dynamic> Function() fetch,
}) async {
  status().state = Status.pending;
  try {
    data().state = await fetch();
    error?.call().state = null;
    status().state = Status.fulfilled;
  } catch (e, stack) {
    // todo: add error logging
    error?.call().state = e;
    status().state = Status.rejected;
  }
}
