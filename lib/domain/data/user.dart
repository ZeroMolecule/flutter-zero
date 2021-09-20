import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_zero/domain/data/auth_provider.dart';

import 'auth_provider.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  factory User(
      String email,
      @JsonKey(name: 'provider', fromJson: _parseProvider)
          AuthProvider provider) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

AuthProvider _parseProvider(dynamic provider) {
  switch (provider) {
    case 'google':
      return AuthProvider.google;
    case 'facebook':
      return AuthProvider.facebook;
    case 'apple':
      return AuthProvider.apple;
    default:
      throw Exception('"$provider" AuthProvider not supported.');
  }
}
