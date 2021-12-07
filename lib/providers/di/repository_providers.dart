import 'package:flutter_zero/domain/repository/auth_repository.dart';
import 'package:flutter_zero/providers/di/network_providers.dart';
import 'package:flutter_zero/providers/di/storage_providers.dart';
import 'package:flutter_zero/util/apple_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final googleSignInProvider = Provider.family<GoogleSignIn, List<String>>(
  (ref, scopes) => GoogleSignIn(scopes: scopes),
);

final appleSignInProvider = Provider((ref) => AppleSignIn());

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    ref.read(authAPIProvider),
    ref.read(authStoreProvider),
    ref.read(googleSignInProvider(['email'])),
    ref.read(appleSignInProvider),
  ),
);
