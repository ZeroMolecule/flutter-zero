import 'package:dio/dio.dart';
import 'package:flutter_zero/domain/remote/chuck_norris_joke_api.dart';
import 'package:flutter_zero/domain/remote/interceptors/auth_interceptors_wrapper.dart';
import 'package:flutter_zero/util/env.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider<Dio>(
  (ref) => Dio()
    ..options = BaseOptions(baseUrl: Env.apiUrl)
    ..interceptors.add(AuthInterceptorsWrapper()),
);

final chuckNorrisJokeAPIProvider = Provider<ChuckNorrisJokeAPI>(
  (ref) => ChuckNorrisJokeAPI(ref.read(dioProvider)),
);
