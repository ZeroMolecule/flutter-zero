import 'package:dio/dio.dart';

class AuthInterceptorsWrapper extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // todo: token insertion logic
    return handler.next(options);
  }
}
