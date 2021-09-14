import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_zero/providers/di/storage_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthInterceptorsWrapper extends InterceptorsWrapper {
  ProviderReference ref;

  AuthInterceptorsWrapper(this.ref);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await ref.read(authStoreProvider).getAccessToken();

    if (token != null) {
      options.headers
          .addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});
    }

    return handler.next(options);
  }
}
