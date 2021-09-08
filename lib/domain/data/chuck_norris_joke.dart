import 'package:freezed_annotation/freezed_annotation.dart';

part 'chuck_norris_joke.freezed.dart';
part 'chuck_norris_joke.g.dart';

@freezed
abstract class ChuckNorrisJoke with _$ChuckNorrisJoke {
  factory ChuckNorrisJoke({
    required String id,
    @JsonKey(name: 'icon_url') String? iconUrl,
    String? url,
    required String value,
  }) = _ChuckNorrisJoke;

  factory ChuckNorrisJoke.fromJson(Map<String, dynamic> json) =>
      _$ChuckNorrisJokeFromJson(json);
}
