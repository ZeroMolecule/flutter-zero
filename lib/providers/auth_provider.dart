import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_zero/domain/data/session.dart';
import 'package:flutter_zero/providers/di/oauth_providers.dart';
import 'package:flutter_zero/providers/di/network_providers.dart';
import 'package:flutter_zero/providers/di/storage_providers.dart';
import 'package:flutter_zero/providers/state/status.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStatusProvider = StateProvider((ref) => Status.idle);
final authErrorProvider = StateProvider<dynamic>((ref) => null);
final authProvider = StateProvider<Session?>(
  (ref) => null,
);

final authViewControllerProvider = Provider((ref) => AuthViewController(ref));

class AuthViewController {
  final ProviderReference ref;

  AuthViewController(this.ref);

  GoogleSignIn _getGoogleSignInProvider() =>
      ref.read(googleSignInProvider(['email']));

  FacebookAuth _getFacebookAuthProvider() => ref.read(facebookAuthProvider);

  Future<String> _getGoogleAccessToken() async {
    final provider = _getGoogleSignInProvider();
    await provider.signIn();
    final authentication = await provider.currentUser!.authentication;
    return authentication.accessToken!;
  }

  Future<String> _getFacebookAccessToken() async {
    final provider = _getFacebookAuthProvider();
    final result = await provider.login();

    if (result.status == LoginStatus.success) {
      return result.accessToken!.token;
    }
    throw Exception(result.message);
  }

  Future<void> init() => statefulFetch(
      status: () => ref.read(authStatusProvider),
      error: () => ref.read(authErrorProvider),
      data: () => ref.read(authProvider),
      fetch: () async {
        final jwt = await ref.read(authStoreProvider).getAccessToken();
        if (jwt != null) {
          final user = await ref.read(authAPIProvider).me();
          return Session(user: user, jwt: jwt);
        }
      });

  Future<void> socialSignIn(String provider) => statefulFetch(
        status: () => ref.read(authStatusProvider),
        error: () => ref.read(authErrorProvider),
        data: () => ref.read(authProvider),
        fetch: () async {
          String accessToken;

          switch (provider) {
            case 'google':
              accessToken = await _getGoogleAccessToken();
              break;
            case 'facebook':
              accessToken = await _getFacebookAccessToken();
              break;
            default:
              throw Exception('"$provider" provider not supported.');
          }

          final session = await ref
              .read(authAPIProvider)
              .socialSignIn(provider, accessToken);
          await ref.read(authStoreProvider).setAccessToken(session.jwt);

          return session;
        },
      );

  Future<void> localSignIn(
          {required String identifier, required String password}) =>
      statefulFetch(
        status: () => ref.read(authStatusProvider),
        error: () => ref.read(authErrorProvider),
        data: () => ref.read(authProvider),
        fetch: () async {
          final res = await ref
              .read(authAPIProvider)
              .localSignIn({'identifier': identifier, 'password': password});
          await ref.read(authStoreProvider).setAccessToken(res.jwt);
          return res;
        },
      );

  Future<void> signOut() => statefulAction(
      status: () => ref.read(authStatusProvider),
      error: () => ref.read(authErrorProvider),
      action: () async {
        final session = ref.read(authProvider).state;
        final provider = session?.user.provider;

        switch (provider) {
          case 'google':
            await _getGoogleSignInProvider().signOut();
            break;
          case 'facebook':
            await _getFacebookAuthProvider().logOut();
            break;
        }
        await ref.read(authStoreProvider).removeAccessToken();
        ref.container.refresh(authProvider);
      });
}
