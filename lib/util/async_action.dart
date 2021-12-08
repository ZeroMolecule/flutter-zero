import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

typedef ActionStream<T> = Stream<AsyncValue<T>>;

class AsyncAction<T> {
  late final PublishSubject<AsyncValue<T>> _publisher = PublishSubject();

  ActionStream<T> get stream => _publisher.stream;

  Future<void> run(Future<T> Function() action) async {
    _publisher.add(const AsyncValue.loading());
    _publisher.add(await AsyncValue.guard(action));
  }

  Future<void> dispose() async {
    await stream.drain();
    await _publisher.close();
  }
}
