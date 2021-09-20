enum AuthProvider { google, facebook, apple, local }

extension AuthProviderExtensions on AuthProvider {
  String get key {
    switch (this) {
      case AuthProvider.google:
        return 'google';
      case AuthProvider.facebook:
        return 'facebook';
      case AuthProvider.apple:
        return 'apple';
      case AuthProvider.local:
        return 'local';
      default:
        throw Exception('"$this" SocialProvider is not supported.');
    }
  }
}
