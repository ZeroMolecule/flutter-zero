import 'package:dio/dio.dart';
import 'package:flutter_zero/example/domain/remote/poke_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final pokeDioProvider = Provider<Dio>(
  (ref) => Dio()..options = BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/'),
);

final pokeApiProvider = Provider<PokeAPI>(
  (ref) => PokeAPI(ref.read(pokeDioProvider)),
);
