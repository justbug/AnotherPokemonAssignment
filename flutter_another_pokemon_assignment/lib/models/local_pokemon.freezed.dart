// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_pokemon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LocalPokemon _$LocalPokemonFromJson(Map<String, dynamic> json) {
  return _LocalPokemon.fromJson(json);
}

/// @nodoc
mixin _$LocalPokemon {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get imageURL => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  int get created => throw _privateConstructorUsedError;
  int get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this LocalPokemon to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocalPokemon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalPokemonCopyWith<LocalPokemon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalPokemonCopyWith<$Res> {
  factory $LocalPokemonCopyWith(
    LocalPokemon value,
    $Res Function(LocalPokemon) then,
  ) = _$LocalPokemonCopyWithImpl<$Res, LocalPokemon>;
  @useResult
  $Res call({
    String id,
    String name,
    String imageURL,
    bool isFavorite,
    int created,
    int updatedAt,
  });
}

/// @nodoc
class _$LocalPokemonCopyWithImpl<$Res, $Val extends LocalPokemon>
    implements $LocalPokemonCopyWith<$Res> {
  _$LocalPokemonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalPokemon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageURL = null,
    Object? isFavorite = null,
    Object? created = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            imageURL: null == imageURL
                ? _value.imageURL
                : imageURL // ignore: cast_nullable_to_non_nullable
                      as String,
            isFavorite: null == isFavorite
                ? _value.isFavorite
                : isFavorite // ignore: cast_nullable_to_non_nullable
                      as bool,
            created: null == created
                ? _value.created
                : created // ignore: cast_nullable_to_non_nullable
                      as int,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocalPokemonImplCopyWith<$Res>
    implements $LocalPokemonCopyWith<$Res> {
  factory _$$LocalPokemonImplCopyWith(
    _$LocalPokemonImpl value,
    $Res Function(_$LocalPokemonImpl) then,
  ) = __$$LocalPokemonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String imageURL,
    bool isFavorite,
    int created,
    int updatedAt,
  });
}

/// @nodoc
class __$$LocalPokemonImplCopyWithImpl<$Res>
    extends _$LocalPokemonCopyWithImpl<$Res, _$LocalPokemonImpl>
    implements _$$LocalPokemonImplCopyWith<$Res> {
  __$$LocalPokemonImplCopyWithImpl(
    _$LocalPokemonImpl _value,
    $Res Function(_$LocalPokemonImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocalPokemon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageURL = null,
    Object? isFavorite = null,
    Object? created = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$LocalPokemonImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        imageURL: null == imageURL
            ? _value.imageURL
            : imageURL // ignore: cast_nullable_to_non_nullable
                  as String,
        isFavorite: null == isFavorite
            ? _value.isFavorite
            : isFavorite // ignore: cast_nullable_to_non_nullable
                  as bool,
        created: null == created
            ? _value.created
            : created // ignore: cast_nullable_to_non_nullable
                  as int,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalPokemonImpl implements _LocalPokemon {
  const _$LocalPokemonImpl({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.isFavorite,
    this.created = 0,
    this.updatedAt = 0,
  });

  factory _$LocalPokemonImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalPokemonImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String imageURL;
  @override
  final bool isFavorite;
  @override
  @JsonKey()
  final int created;
  @override
  @JsonKey()
  final int updatedAt;

  @override
  String toString() {
    return 'LocalPokemon(id: $id, name: $name, imageURL: $imageURL, isFavorite: $isFavorite, created: $created, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalPokemonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageURL, imageURL) ||
                other.imageURL == imageURL) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    imageURL,
    isFavorite,
    created,
    updatedAt,
  );

  /// Create a copy of LocalPokemon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalPokemonImplCopyWith<_$LocalPokemonImpl> get copyWith =>
      __$$LocalPokemonImplCopyWithImpl<_$LocalPokemonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalPokemonImplToJson(this);
  }
}

abstract class _LocalPokemon implements LocalPokemon {
  const factory _LocalPokemon({
    required final String id,
    required final String name,
    required final String imageURL,
    required final bool isFavorite,
    final int created,
    final int updatedAt,
  }) = _$LocalPokemonImpl;

  factory _LocalPokemon.fromJson(Map<String, dynamic> json) =
      _$LocalPokemonImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get imageURL;
  @override
  bool get isFavorite;
  @override
  int get created;
  @override
  int get updatedAt;

  /// Create a copy of LocalPokemon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalPokemonImplCopyWith<_$LocalPokemonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
