// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'chuck_norris_joke.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChuckNorrisJoke _$ChuckNorrisJokeFromJson(Map<String, dynamic> json) {
  return _ChuckNorrisJoke.fromJson(json);
}

/// @nodoc
class _$ChuckNorrisJokeTearOff {
  const _$ChuckNorrisJokeTearOff();

  _ChuckNorrisJoke call(
      {required String id,
      @JsonKey(name: 'icon_url') String? iconUrl,
      String? url,
      required String value}) {
    return _ChuckNorrisJoke(
      id: id,
      iconUrl: iconUrl,
      url: url,
      value: value,
    );
  }

  ChuckNorrisJoke fromJson(Map<String, Object> json) {
    return ChuckNorrisJoke.fromJson(json);
  }
}

/// @nodoc
const $ChuckNorrisJoke = _$ChuckNorrisJokeTearOff();

/// @nodoc
mixin _$ChuckNorrisJoke {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'icon_url')
  String? get iconUrl => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChuckNorrisJokeCopyWith<ChuckNorrisJoke> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChuckNorrisJokeCopyWith<$Res> {
  factory $ChuckNorrisJokeCopyWith(
          ChuckNorrisJoke value, $Res Function(ChuckNorrisJoke) then) =
      _$ChuckNorrisJokeCopyWithImpl<$Res>;
  $Res call(
      {String id,
      @JsonKey(name: 'icon_url') String? iconUrl,
      String? url,
      String value});
}

/// @nodoc
class _$ChuckNorrisJokeCopyWithImpl<$Res>
    implements $ChuckNorrisJokeCopyWith<$Res> {
  _$ChuckNorrisJokeCopyWithImpl(this._value, this._then);

  final ChuckNorrisJoke _value;
  // ignore: unused_field
  final $Res Function(ChuckNorrisJoke) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? iconUrl = freezed,
    Object? url = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: iconUrl == freezed
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ChuckNorrisJokeCopyWith<$Res>
    implements $ChuckNorrisJokeCopyWith<$Res> {
  factory _$ChuckNorrisJokeCopyWith(
          _ChuckNorrisJoke value, $Res Function(_ChuckNorrisJoke) then) =
      __$ChuckNorrisJokeCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      @JsonKey(name: 'icon_url') String? iconUrl,
      String? url,
      String value});
}

/// @nodoc
class __$ChuckNorrisJokeCopyWithImpl<$Res>
    extends _$ChuckNorrisJokeCopyWithImpl<$Res>
    implements _$ChuckNorrisJokeCopyWith<$Res> {
  __$ChuckNorrisJokeCopyWithImpl(
      _ChuckNorrisJoke _value, $Res Function(_ChuckNorrisJoke) _then)
      : super(_value, (v) => _then(v as _ChuckNorrisJoke));

  @override
  _ChuckNorrisJoke get _value => super._value as _ChuckNorrisJoke;

  @override
  $Res call({
    Object? id = freezed,
    Object? iconUrl = freezed,
    Object? url = freezed,
    Object? value = freezed,
  }) {
    return _then(_ChuckNorrisJoke(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: iconUrl == freezed
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChuckNorrisJoke implements _ChuckNorrisJoke {
  _$_ChuckNorrisJoke(
      {required this.id,
      @JsonKey(name: 'icon_url') this.iconUrl,
      this.url,
      required this.value});

  factory _$_ChuckNorrisJoke.fromJson(Map<String, dynamic> json) =>
      _$_$_ChuckNorrisJokeFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'icon_url')
  final String? iconUrl;
  @override
  final String? url;
  @override
  final String value;

  @override
  String toString() {
    return 'ChuckNorrisJoke(id: $id, iconUrl: $iconUrl, url: $url, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChuckNorrisJoke &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.iconUrl, iconUrl) ||
                const DeepCollectionEquality()
                    .equals(other.iconUrl, iconUrl)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(iconUrl) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  _$ChuckNorrisJokeCopyWith<_ChuckNorrisJoke> get copyWith =>
      __$ChuckNorrisJokeCopyWithImpl<_ChuckNorrisJoke>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ChuckNorrisJokeToJson(this);
  }
}

abstract class _ChuckNorrisJoke implements ChuckNorrisJoke {
  factory _ChuckNorrisJoke(
      {required String id,
      @JsonKey(name: 'icon_url') String? iconUrl,
      String? url,
      required String value}) = _$_ChuckNorrisJoke;

  factory _ChuckNorrisJoke.fromJson(Map<String, dynamic> json) =
      _$_ChuckNorrisJoke.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'icon_url')
  String? get iconUrl => throw _privateConstructorUsedError;
  @override
  String? get url => throw _privateConstructorUsedError;
  @override
  String get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ChuckNorrisJokeCopyWith<_ChuckNorrisJoke> get copyWith =>
      throw _privateConstructorUsedError;
}
