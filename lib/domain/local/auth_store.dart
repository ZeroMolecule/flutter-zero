import 'package:flutter_zero/providers/di/app_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStore {
  static const _accessToken = 'access-token';

  final ProviderReference ref;

  AuthStore(this.ref);

  Future<SharedPreferences> _getPrefs() {
    return ref.read(sharedPreferencesProvider.future);
  }

  Future<String?> getAccessToken() async {
    final prefs = await _getPrefs();
    return prefs.getString(_accessToken);
  }

  Future<void> setAccessToken(String token) async {
    final prefs = await _getPrefs();
    prefs.setString(_accessToken, token);
  }

  Future<void> removeAccessToken() async {
    final prefs = await _getPrefs();
    prefs.remove(_accessToken);
  }
}
