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
    @Path() String provider,
    @Query('access_token') String accessToken,
  );

  @POST('/auth/local')
  Future<Session> localSignInRequest(@Body() Map<String, dynamic> body);

  @POST('/auth/forgot-password')
  @FormUrlEncoded()
  Future<void> forgotPassword({@Field('email') required String email});

  @POST('/auth/reset-password')
  @FormUrlEncoded()
  Future<void> resetPasswordRequest({
    @Body() required Map<String, dynamic> body,
  });

  @GET('/users/me')
  Future<User> me();
}

extension AuthAPIExtensions on AuthAPI {
  Future<Session> localSignIn({
    required String identifier,
    required String password,
  }) =>
      localSignInRequest({
        'identifier': identifier,
        'password': password,
      });

  Future<void> resetPassword({
    required String code,
    required String password,
    required String passwordConfirm,
  }) =>
      resetPasswordRequest(body: {
        'code': code,
        'password': password,
        'passwordConfirmation': passwordConfirm,
      });
}
