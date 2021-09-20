import 'package:shared_preferences/shared_preferences.dart';

class AuthStore {
  static const _accessToken = 'access-token';

  SharedPreferences? _prefs;

  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
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
