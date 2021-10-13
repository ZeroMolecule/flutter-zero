import 'package:dio/dio.dart';
import 'package:flutter_zero/example/domain/data/pokemon.dart';
import 'package:flutter_zero/example/domain/remote/response/poke_api_list_response.dart';
import 'package:retrofit/http.dart';

part 'poke_api.g.dart';

@RestApi()
abstract class PokeAPI {
  factory PokeAPI(Dio dio) = _PokeAPI;

  @GET('pokemon')
  Future<PokeApiListResponse> getPokemon(
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  );

  @GET('pokemon/{name}')
  Future<Pokemon> getPokemonByName(
    @Path('name') String name,
  );

  @GET('pokemon/{id}')
  Future<Pokemon> getPokemonById(
    @Path('id') int id,
  );
}
