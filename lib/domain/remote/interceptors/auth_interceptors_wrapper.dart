import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_zero/domain/local/auth_store.dart';

class AuthInterceptorsWrapper extends InterceptorsWrapper {
  AuthStore authStore;

  AuthInterceptorsWrapper(this.authStore);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await authStore.getAccessToken();

    if (token != null) {
      options.headers
          .addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});
    }

    return handler.next(options);
  }
}
