import 'package:flutter_zero/example/domain/data/pokemon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'poke_api_list_response.freezed.dart';
part 'poke_api_list_response.g.dart';

@freezed
abstract class PokeApiListResponse with _$PokeApiListResponse {
  factory PokeApiListResponse({
    required List<Pokemon> results,
  }) = _PokeApiListResponse;

  factory PokeApiListResponse.fromJson(Map<String, dynamic> json) =>
      _$PokeApiListResponseFromJson(json);
}
