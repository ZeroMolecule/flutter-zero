import 'package:dio/dio.dart';
import 'package:flutter_zero/domain/data/chuck_norris_joke.dart';
import 'package:retrofit/http.dart';

part 'chuck_norris_joke_api.g.dart';

@RestApi()
abstract class ChuckNorrisJokeAPI {
  factory ChuckNorrisJokeAPI(Dio dio) = _ChuckNorrisJokeAPI;

  @GET('jokes/random')
  Future<ChuckNorrisJoke> getRandomJoke();
}
