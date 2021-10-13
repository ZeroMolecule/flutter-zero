import 'package:flutter_zero/example/domain/data/pokemon.dart';
import 'package:flutter_zero/example/providers/di/example_di_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final pokemonByIdProvider = FutureProvider.autoDispose.family<Pokemon, int>(
  (ref, id) {
    ref.maintainState = true;
    return ref.read(pokeApiProvider).getPokemonById(id);
  },
);
