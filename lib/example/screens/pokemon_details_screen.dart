import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/example/domain/data/pokemon.dart';
import 'package:flutter_zero/example/providers/pokemon_providers.dart';
import 'package:flutter_zero/widgets/async_value_container.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PokemonDetailsScreen extends HookWidget {
  final int pokemonId;

  const PokemonDetailsScreen({
    Key? key,
    @PathParam('id') required this.pokemonId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonValue = useProvider(pokemonByIdProvider(pokemonId));
    return Scaffold(
      appBar: AppBar(),
      body: AsyncValueContainer<Pokemon>(
        value: pokemonValue,
        onData: (pokemon) => Center(child: _Pokemon(pokemon: pokemon)),
      ),
    );
  }
}

class _Pokemon extends HookWidget {
  final Pokemon pokemon;

  const _Pokemon({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (pokemon.image != null) Image.network(pokemon.image!),
        const SizedBox(height: 16),
        Text(pokemon.name),
      ],
    );
  }
}
