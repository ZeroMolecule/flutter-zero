import 'package:flutter_zero/domain/data/session.dart';
import 'package:flutter_zero/providers/di/google_signin_provider.dart';
import 'package:flutter_zero/providers/di/network_providers.dart';
import 'package:flutter_zero/providers/state/status.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'di/app_providers.dart';

final authStatusProvider = StateProvider((ref) => Status.idle);
final authErrorProvider = StateProvider<dynamic>((ref) => null);
final authProvider = StateProvider<Session?>(
  (ref) => null,
);

final authViewControllerProvider = Provider((ref) => AuthViewController(ref));

class AuthViewController {
  static const accessTokenKey = 'access-token';
  final ProviderReference ref;

  AuthViewController(this.ref);

  _getGoogleSignInProvider() => ref.read(googleSignInProvider(['email']));

  Future<String?> _getGoogleAccessToken() async {
    final googleSignIn = _getGoogleSignInProvider();
    await googleSignIn.signIn();
    final authentication = await googleSignIn.currentUser!.authentication;
    return authentication.accessToken;
  }

  Future<void> init() async {
    statefulFetch(
        status: () => ref.read(authStatusProvider),
        error: () => ref.read(authErrorProvider),
        data: () => ref.read(authProvider),
        fetch: () async {
          final sp = await ref.read(sharedPreferencesProvider.future);
          final jwt = sp.getString(accessTokenKey);
          if (jwt != null) {
            final user = await ref.read(authAPIProvider).me();
            return Session(user: user, jwt: jwt);
          }
        });
  }

  Future<void> signIn(String provider) => statefulFetch(
        status: () => ref.read(authStatusProvider),
        error: () => ref.read(authErrorProvider),
        data: () => ref.read(authProvider),
        fetch: () async {
          String? accessToken;

          switch (provider) {
            case 'google':
              accessToken = await _getGoogleAccessToken();
          }

          if (accessToken != null) {
            final session = await ref
                .read(authAPIProvider)
                .socialSignIn(provider, accessToken);
            final prefs = await ref.read(sharedPreferencesProvider.future);
            prefs.setString(accessTokenKey, session.jwt);

            return session;
          }
        },
      );

  Future<void> signOut() => statefulFetch(
      status: () => ref.read(authStatusProvider),
      error: () => ref.read(authErrorProvider),
      data: () => ref.read(authProvider),
      fetch: () async {
        final session = ref.read(authProvider).state;
        final provider = session?.user.provider;

        switch (provider) {
          case 'google':
            await _getGoogleSignInProvider().signOut();
        }
        final prefs = await ref.read(sharedPreferencesProvider.future);
        prefs.remove(accessTokenKey);
      });
}
