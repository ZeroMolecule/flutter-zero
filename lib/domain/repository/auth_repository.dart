import 'package:flutter_zero/domain/data/auth_provider.dart';
import 'package:flutter_zero/domain/data/session.dart';
import 'package:flutter_zero/domain/local/auth_store.dart';
import 'package:flutter_zero/domain/remote/auth_api.dart';
import 'package:flutter_zero/util/apple_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepository {
  final AuthAPI _authAPI;
  final AuthStore _authStore;
  final GoogleSignIn _googleSignIn;
  final AppleSignIn _appleSignIn;

  AuthRepository(
    this._authAPI,
    this._authStore,
    this._googleSignIn,
    this._appleSignIn,
  );

  Future<String> _getGoogleAccessToken() async {
    await _googleSignIn.signIn();
    final authentication = await _googleSignIn.currentUser!.authentication;
    return authentication.accessToken!;
  }

  Future<String> _getAppleAccessToken() async {
    final credentials = await _appleSignIn.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName
    ]);
    return credentials.authorizationCode;
  }

  Future<Session> _loginSocial({
    required AuthProvider provider,
    required String accessToken,
  }) async {
    final session = await _authAPI.socialSignIn(provider.key, accessToken);
    await _authStore.setAccessToken(session.jwt);
    return session;
  }

  Future<Session?> getSession() async {
    final jwt = await _authStore.getAccessToken();
    if (jwt != null) {
      final user = await _authAPI.me();
      return Session(jwt: jwt, user: user);
    }
  }

  Future<Session> login({
    required String identifier,
    required String password,
  }) async {
    final session = await _authAPI.localSignin(
      identifier: identifier,
      password: password,
    );
    await _authStore.setAccessToken(session.jwt);
    return session;
  }

  Future<Session> loginGoogle() async {
    final token = await _getGoogleAccessToken();
    return _loginSocial(provider: AuthProvider.google, accessToken: token);
  }

  Future<Session> loginApple() async {
    final token = await _getAppleAccessToken();
    return _loginSocial(provider: AuthProvider.apple, accessToken: token);
  }

  Future<void> logout() async {
    await _authStore.removeAccessToken();
  }

  Future<void> requestPasswordReset({required String email}) async {
    return _authAPI.forgotPassword(email: email);
  }

  Future<void> resetPassword({
    required String code,
    required String password,
  }) async {
    return _authAPI.resetPassword(
      code: code,
      password: password,
      passwordConfirmation: password,
    );
  }
}
