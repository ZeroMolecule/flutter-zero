import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_zero/util/apple_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignInProvider = Provider.family<GoogleSignIn, List<String>>(
    (ref, scopes) => GoogleSignIn(scopes: scopes));

final facebookAuthProvider = Provider((ref) => FacebookAuth.instance);

final appleSignInProvider = Provider((ref) => AppleSignIn());
