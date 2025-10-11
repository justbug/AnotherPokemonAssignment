// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DetailEntity _$DetailEntityFromJson(Map<String, dynamic> json) {
  return _DetailEntity.fromJson(json);
}

/// @nodoc
mixin _$DetailEntity {
  int get id => throw _privateConstructorUsedError;
  int get weight => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  List<TypesEntity> get types => throw _privateConstructorUsedError;
  SpriteEntity? get sprites => throw _privateConstructorUsedError;

  /// Serializes this DetailEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DetailEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DetailEntityCopyWith<DetailEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailEntityCopyWith<$Res> {
  factory $DetailEntityCopyWith(
    DetailEntity value,
    $Res Function(DetailEntity) then,
  ) = _$DetailEntityCopyWithImpl<$Res, DetailEntity>;
  @useResult
  $Res call({
    int id,
    int weight,
    int height,
    List<TypesEntity> types,
    SpriteEntity? sprites,
  });

  $SpriteEntityCopyWith<$Res>? get sprites;
}

/// @nodoc
class _$DetailEntityCopyWithImpl<$Res, $Val extends DetailEntity>
    implements $DetailEntityCopyWith<$Res> {
  _$DetailEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DetailEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weight = null,
    Object? height = null,
    Object? types = null,
    Object? sprites = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            weight: null == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as int,
            height: null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as int,
            types: null == types
                ? _value.types
                : types // ignore: cast_nullable_to_non_nullable
                      as List<TypesEntity>,
            sprites: freezed == sprites
                ? _value.sprites
                : sprites // ignore: cast_nullable_to_non_nullable
                      as SpriteEntity?,
          )
          as $Val,
    );
  }

  /// Create a copy of DetailEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpriteEntityCopyWith<$Res>? get sprites {
    if (_value.sprites == null) {
      return null;
    }

    return $SpriteEntityCopyWith<$Res>(_value.sprites!, (value) {
      return _then(_value.copyWith(sprites: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DetailEntityImplCopyWith<$Res>
    implements $DetailEntityCopyWith<$Res> {
  factory _$$DetailEntityImplCopyWith(
    _$DetailEntityImpl value,
    $Res Function(_$DetailEntityImpl) then,
  ) = __$$DetailEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int weight,
    int height,
    List<TypesEntity> types,
    SpriteEntity? sprites,
  });

  @override
  $SpriteEntityCopyWith<$Res>? get sprites;
}

/// @nodoc
class __$$DetailEntityImplCopyWithImpl<$Res>
    extends _$DetailEntityCopyWithImpl<$Res, _$DetailEntityImpl>
    implements _$$DetailEntityImplCopyWith<$Res> {
  __$$DetailEntityImplCopyWithImpl(
    _$DetailEntityImpl _value,
    $Res Function(_$DetailEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DetailEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weight = null,
    Object? height = null,
    Object? types = null,
    Object? sprites = freezed,
  }) {
    return _then(
      _$DetailEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        weight: null == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as int,
        height: null == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int,
        types: null == types
            ? _value._types
            : types // ignore: cast_nullable_to_non_nullable
                  as List<TypesEntity>,
        sprites: freezed == sprites
            ? _value.sprites
            : sprites // ignore: cast_nullable_to_non_nullable
                  as SpriteEntity?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DetailEntityImpl implements _DetailEntity {
  const _$DetailEntityImpl({
    required this.id,
    required this.weight,
    required this.height,
    required final List<TypesEntity> types,
    this.sprites,
  }) : _types = types;

  factory _$DetailEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetailEntityImplFromJson(json);

  @override
  final int id;
  @override
  final int weight;
  @override
  final int height;
  final List<TypesEntity> _types;
  @override
  List<TypesEntity> get types {
    if (_types is EqualUnmodifiableListView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_types);
  }

  @override
  final SpriteEntity? sprites;

  @override
  String toString() {
    return 'DetailEntity(id: $id, weight: $weight, height: $height, types: $types, sprites: $sprites)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.height, height) || other.height == height) &&
            const DeepCollectionEquality().equals(other._types, _types) &&
            (identical(other.sprites, sprites) || other.sprites == sprites));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    weight,
    height,
    const DeepCollectionEquality().hash(_types),
    sprites,
  );

  /// Create a copy of DetailEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailEntityImplCopyWith<_$DetailEntityImpl> get copyWith =>
      __$$DetailEntityImplCopyWithImpl<_$DetailEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DetailEntityImplToJson(this);
  }
}

abstract class _DetailEntity implements DetailEntity {
  const factory _DetailEntity({
    required final int id,
    required final int weight,
    required final int height,
    required final List<TypesEntity> types,
    final SpriteEntity? sprites,
  }) = _$DetailEntityImpl;

  factory _DetailEntity.fromJson(Map<String, dynamic> json) =
      _$DetailEntityImpl.fromJson;

  @override
  int get id;
  @override
  int get weight;
  @override
  int get height;
  @override
  List<TypesEntity> get types;
  @override
  SpriteEntity? get sprites;

  /// Create a copy of DetailEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetailEntityImplCopyWith<_$DetailEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TypesEntity _$TypesEntityFromJson(Map<String, dynamic> json) {
  return _TypesEntity.fromJson(json);
}

/// @nodoc
mixin _$TypesEntity {
  TypeEntity get type => throw _privateConstructorUsedError;

  /// Serializes this TypesEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TypesEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TypesEntityCopyWith<TypesEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypesEntityCopyWith<$Res> {
  factory $TypesEntityCopyWith(
    TypesEntity value,
    $Res Function(TypesEntity) then,
  ) = _$TypesEntityCopyWithImpl<$Res, TypesEntity>;
  @useResult
  $Res call({TypeEntity type});

  $TypeEntityCopyWith<$Res> get type;
}

/// @nodoc
class _$TypesEntityCopyWithImpl<$Res, $Val extends TypesEntity>
    implements $TypesEntityCopyWith<$Res> {
  _$TypesEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TypesEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null}) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as TypeEntity,
          )
          as $Val,
    );
  }

  /// Create a copy of TypesEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TypeEntityCopyWith<$Res> get type {
    return $TypeEntityCopyWith<$Res>(_value.type, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TypesEntityImplCopyWith<$Res>
    implements $TypesEntityCopyWith<$Res> {
  factory _$$TypesEntityImplCopyWith(
    _$TypesEntityImpl value,
    $Res Function(_$TypesEntityImpl) then,
  ) = __$$TypesEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TypeEntity type});

  @override
  $TypeEntityCopyWith<$Res> get type;
}

/// @nodoc
class __$$TypesEntityImplCopyWithImpl<$Res>
    extends _$TypesEntityCopyWithImpl<$Res, _$TypesEntityImpl>
    implements _$$TypesEntityImplCopyWith<$Res> {
  __$$TypesEntityImplCopyWithImpl(
    _$TypesEntityImpl _value,
    $Res Function(_$TypesEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TypesEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null}) {
    return _then(
      _$TypesEntityImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as TypeEntity,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TypesEntityImpl implements _TypesEntity {
  const _$TypesEntityImpl({required this.type});

  factory _$TypesEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$TypesEntityImplFromJson(json);

  @override
  final TypeEntity type;

  @override
  String toString() {
    return 'TypesEntity(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypesEntityImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type);

  /// Create a copy of TypesEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TypesEntityImplCopyWith<_$TypesEntityImpl> get copyWith =>
      __$$TypesEntityImplCopyWithImpl<_$TypesEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TypesEntityImplToJson(this);
  }
}

abstract class _TypesEntity implements TypesEntity {
  const factory _TypesEntity({required final TypeEntity type}) =
      _$TypesEntityImpl;

  factory _TypesEntity.fromJson(Map<String, dynamic> json) =
      _$TypesEntityImpl.fromJson;

  @override
  TypeEntity get type;

  /// Create a copy of TypesEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TypesEntityImplCopyWith<_$TypesEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TypeEntity _$TypeEntityFromJson(Map<String, dynamic> json) {
  return _TypeEntity.fromJson(json);
}

/// @nodoc
mixin _$TypeEntity {
  String get name => throw _privateConstructorUsedError;

  /// Serializes this TypeEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TypeEntityCopyWith<TypeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeEntityCopyWith<$Res> {
  factory $TypeEntityCopyWith(
    TypeEntity value,
    $Res Function(TypeEntity) then,
  ) = _$TypeEntityCopyWithImpl<$Res, TypeEntity>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$TypeEntityCopyWithImpl<$Res, $Val extends TypeEntity>
    implements $TypeEntityCopyWith<$Res> {
  _$TypeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TypeEntityImplCopyWith<$Res>
    implements $TypeEntityCopyWith<$Res> {
  factory _$$TypeEntityImplCopyWith(
    _$TypeEntityImpl value,
    $Res Function(_$TypeEntityImpl) then,
  ) = __$$TypeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$TypeEntityImplCopyWithImpl<$Res>
    extends _$TypeEntityCopyWithImpl<$Res, _$TypeEntityImpl>
    implements _$$TypeEntityImplCopyWith<$Res> {
  __$$TypeEntityImplCopyWithImpl(
    _$TypeEntityImpl _value,
    $Res Function(_$TypeEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _$TypeEntityImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TypeEntityImpl implements _TypeEntity {
  const _$TypeEntityImpl({required this.name});

  factory _$TypeEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$TypeEntityImplFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'TypeEntity(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypeEntityImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of TypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TypeEntityImplCopyWith<_$TypeEntityImpl> get copyWith =>
      __$$TypeEntityImplCopyWithImpl<_$TypeEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TypeEntityImplToJson(this);
  }
}

abstract class _TypeEntity implements TypeEntity {
  const factory _TypeEntity({required final String name}) = _$TypeEntityImpl;

  factory _TypeEntity.fromJson(Map<String, dynamic> json) =
      _$TypeEntityImpl.fromJson;

  @override
  String get name;

  /// Create a copy of TypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TypeEntityImplCopyWith<_$TypeEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SpriteEntity _$SpriteEntityFromJson(Map<String, dynamic> json) {
  return _SpriteEntity.fromJson(json);
}

/// @nodoc
mixin _$SpriteEntity {
  String? get frontDefault => throw _privateConstructorUsedError;

  /// Serializes this SpriteEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpriteEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpriteEntityCopyWith<SpriteEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpriteEntityCopyWith<$Res> {
  factory $SpriteEntityCopyWith(
    SpriteEntity value,
    $Res Function(SpriteEntity) then,
  ) = _$SpriteEntityCopyWithImpl<$Res, SpriteEntity>;
  @useResult
  $Res call({String? frontDefault});
}

/// @nodoc
class _$SpriteEntityCopyWithImpl<$Res, $Val extends SpriteEntity>
    implements $SpriteEntityCopyWith<$Res> {
  _$SpriteEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpriteEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? frontDefault = freezed}) {
    return _then(
      _value.copyWith(
            frontDefault: freezed == frontDefault
                ? _value.frontDefault
                : frontDefault // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SpriteEntityImplCopyWith<$Res>
    implements $SpriteEntityCopyWith<$Res> {
  factory _$$SpriteEntityImplCopyWith(
    _$SpriteEntityImpl value,
    $Res Function(_$SpriteEntityImpl) then,
  ) = __$$SpriteEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? frontDefault});
}

/// @nodoc
class __$$SpriteEntityImplCopyWithImpl<$Res>
    extends _$SpriteEntityCopyWithImpl<$Res, _$SpriteEntityImpl>
    implements _$$SpriteEntityImplCopyWith<$Res> {
  __$$SpriteEntityImplCopyWithImpl(
    _$SpriteEntityImpl _value,
    $Res Function(_$SpriteEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SpriteEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? frontDefault = freezed}) {
    return _then(
      _$SpriteEntityImpl(
        frontDefault: freezed == frontDefault
            ? _value.frontDefault
            : frontDefault // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SpriteEntityImpl implements _SpriteEntity {
  const _$SpriteEntityImpl({this.frontDefault});

  factory _$SpriteEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpriteEntityImplFromJson(json);

  @override
  final String? frontDefault;

  @override
  String toString() {
    return 'SpriteEntity(frontDefault: $frontDefault)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpriteEntityImpl &&
            (identical(other.frontDefault, frontDefault) ||
                other.frontDefault == frontDefault));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, frontDefault);

  /// Create a copy of SpriteEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpriteEntityImplCopyWith<_$SpriteEntityImpl> get copyWith =>
      __$$SpriteEntityImplCopyWithImpl<_$SpriteEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpriteEntityImplToJson(this);
  }
}

abstract class _SpriteEntity implements SpriteEntity {
  const factory _SpriteEntity({final String? frontDefault}) =
      _$SpriteEntityImpl;

  factory _SpriteEntity.fromJson(Map<String, dynamic> json) =
      _$SpriteEntityImpl.fromJson;

  @override
  String? get frontDefault;

  /// Create a copy of SpriteEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpriteEntityImplCopyWith<_$SpriteEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
