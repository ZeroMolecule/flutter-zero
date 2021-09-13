import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_zero/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptorsWrapper extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AuthViewController.accessTokenKey);

    if (token != null) {
      options.headers
          .addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});
    }

    return handler.next(options);
  }
}
