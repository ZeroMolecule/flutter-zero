import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignInProvider = Provider.family<GoogleSignIn, List<String>>(
    (ref, scopes) => GoogleSignIn(scopes: scopes));

final facebookAuthProvider = Provider((ref) => FacebookAuth.instance);
