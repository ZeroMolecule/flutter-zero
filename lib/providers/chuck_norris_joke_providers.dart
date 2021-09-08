import 'package:flutter_zero/domain/data/chuck_norris_joke.dart';
import 'package:flutter_zero/providers/di/network_providers.dart';
import 'package:flutter_zero/providers/state/status.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chuckNorrisStatusProvider = StateProvider((ref) => Status.idle);
final chuckNorrisErrorProvider = StateProvider<dynamic>((ref) => null);
final chuckNorrisRandomJokeProvider = StateProvider<ChuckNorrisJoke?>(
  (ref) => null,
);

final chuckNorrisJokeViewControllerProvider = Provider(
  (ref) => ChuckNorrisJokeViewController(ref),
);

class ChuckNorrisJokeViewController {
  final ProviderReference ref;

  ChuckNorrisJokeViewController(this.ref);

  Future<void> fetchChuckNorrisRandomJoke() => statefulFetch(
        status: () => ref.read(chuckNorrisStatusProvider),
        error: () => ref.read(chuckNorrisErrorProvider),
        data: () => ref.read(chuckNorrisRandomJokeProvider),
        fetch: () => ref.read(chuckNorrisJokeAPIProvider).getRandomJoke(),
      );
}
