import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final _actionPublisherProvider =
    Provider.autoDispose.family<PublishSubject<AsyncValue>, dynamic>(
  (ref, key) {
    final subject = PublishSubject<AsyncValue>();
    ref.onDispose(() {
      subject.close();
    });
    return subject;
  },
);

class ActionsProvider {
  static AutoDisposeStreamProvider<AsyncValue<T>> stream<K, T>(K key) =>
      StreamProvider.autoDispose<AsyncValue<T>>(
        (ref) => ref.watch(_actionPublisherProvider(key)).stream.cast(),
      );

  static AutoDisposeProvider<PublishSubject<AsyncValue<T>>> publisher<K, T>(
    K key,
  ) =>
      _actionPublisherProvider(key)
          as AutoDisposeProvider<PublishSubject<AsyncValue<T>>>;
}
