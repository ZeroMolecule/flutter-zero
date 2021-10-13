import 'package:dio/dio.dart';
import 'package:flutter_zero/domain/remote/auth_api.dart';
import 'package:flutter_zero/domain/remote/interceptors/auth_interceptors_wrapper.dart';
import 'package:flutter_zero/providers/di/storage_providers.dart';
import 'package:flutter_zero/util/env.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider<Dio>(
  (ref) => Dio()
    ..options = BaseOptions(baseUrl: Env.apiUrl)
    ..interceptors.add(AuthInterceptorsWrapper(ref.read(authStoreProvider))),
);

final authAPIProvider = Provider<AuthAPI>(
  (ref) => AuthAPI(ref.read(dioProvider)),
);
