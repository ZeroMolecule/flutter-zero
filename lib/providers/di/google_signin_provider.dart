import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final googleSignInProvider = Provider.family<GoogleSignIn, List<String>>(
    (ref, scopes) => GoogleSignIn(scopes: scopes));
