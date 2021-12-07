import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

extension _PublishSubjectExtensions<T> on PublishSubject<T> {
  void addSafe(T event) {
    if (!isClosed) {
      add(event);
    }
  }
}

extension ChangeNotifierExtensions on ChangeNotifier {
  Future<void> asyncFetch<T>(
    Function(AsyncValue<T> value) setter, {
    required Future<T> Function() fetch,
    bool skipLoading = false,
    bool notify = true,
  }) async {
    if (!skipLoading) {
      setter(const AsyncValue.loading());
      if (notify) notifyListeners();
    }
    setter(await AsyncValue.guard(fetch));
    if (notify) notifyListeners();
  }
}
