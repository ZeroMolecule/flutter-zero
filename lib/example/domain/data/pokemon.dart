import 'package:flutter_zero/example/domain/remote/poke_api_parser.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@freezed
abstract class Pokemon with _$Pokemon {
  factory Pokemon({
    required String name,
    @JsonKey(name: 'sprites', fromJson: PokeApiParser.parseImage) String? image,
    int? height,
    int? weight,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
}
