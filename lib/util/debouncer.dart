import 'dart:async';

import 'package:rxdart/rxdart.dart';

class _Event {
  final Future Function() primaryHandler;
  final Function(Object, StackTrace?)? errorHandler;

  _Event(this.primaryHandler, this.errorHandler);
}

class Debouncer {
  final Duration debounceTime;

  late final StreamSubscription _subscription;
  late final StreamController<_Event> _stream = StreamController.broadcast();

  Debouncer({this.debounceTime = const Duration(seconds: 1)}) {
    _subscription = _stream.stream.debounceTime(debounceTime).listen(
      (event) async {
        try {
          await event.primaryHandler();
        } catch (error, stack) {
          if (event.errorHandler != null) {
            event.errorHandler!.call(error, stack);
          } else {
            rethrow;
          }
        }
      },
    );
  }

  void debounce(
    Future Function() function, {
    Function(Object, StackTrace?)? onError,
  }) {
    _stream.add(_Event(function, onError));
  }

  Future<void> dispose() => _subscription.cancel();
}
