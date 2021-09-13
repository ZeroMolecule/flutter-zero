import 'package:dio/dio.dart';
import 'package:flutter_zero/domain/data/session.dart';
import 'package:flutter_zero/domain/data/user.dart';
import 'package:retrofit/http.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthAPI {
  factory AuthAPI(Dio dio) = _AuthAPI;

  @GET('/auth/{provider}/callback')
  Future<Session> socialSignIn(
      @Path() String provider, @Query('access_token') String accessToken);

  @GET('/users/me')
  Future<User> me();
}
