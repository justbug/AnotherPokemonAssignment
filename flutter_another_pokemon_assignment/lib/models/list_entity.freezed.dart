// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ListEntity _$ListEntityFromJson(Map<String, dynamic> json) {
  return _ListEntity.fromJson(json);
}

/// @nodoc
mixin _$ListEntity {
  String? get next => throw _privateConstructorUsedError;
  List<ResultEntity> get results => throw _privateConstructorUsedError;

  /// Serializes this ListEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListEntityCopyWith<ListEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListEntityCopyWith<$Res> {
  factory $ListEntityCopyWith(
    ListEntity value,
    $Res Function(ListEntity) then,
  ) = _$ListEntityCopyWithImpl<$Res, ListEntity>;
  @useResult
  $Res call({String? next, List<ResultEntity> results});
}

/// @nodoc
class _$ListEntityCopyWithImpl<$Res, $Val extends ListEntity>
    implements $ListEntityCopyWith<$Res> {
  _$ListEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? next = freezed, Object? results = null}) {
    return _then(
      _value.copyWith(
            next: freezed == next
                ? _value.next
                : next // ignore: cast_nullable_to_non_nullable
                      as String?,
            results: null == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as List<ResultEntity>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ListEntityImplCopyWith<$Res>
    implements $ListEntityCopyWith<$Res> {
  factory _$$ListEntityImplCopyWith(
    _$ListEntityImpl value,
    $Res Function(_$ListEntityImpl) then,
  ) = __$$ListEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? next, List<ResultEntity> results});
}

/// @nodoc
class __$$ListEntityImplCopyWithImpl<$Res>
    extends _$ListEntityCopyWithImpl<$Res, _$ListEntityImpl>
    implements _$$ListEntityImplCopyWith<$Res> {
  __$$ListEntityImplCopyWithImpl(
    _$ListEntityImpl _value,
    $Res Function(_$ListEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ListEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? next = freezed, Object? results = null}) {
    return _then(
      _$ListEntityImpl(
        next: freezed == next
            ? _value.next
            : next // ignore: cast_nullable_to_non_nullable
                  as String?,
        results: null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<ResultEntity>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ListEntityImpl implements _ListEntity {
  const _$ListEntityImpl({this.next, required final List<ResultEntity> results})
    : _results = results;

  factory _$ListEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListEntityImplFromJson(json);

  @override
  final String? next;
  final List<ResultEntity> _results;
  @override
  List<ResultEntity> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'ListEntity(next: $next, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListEntityImpl &&
            (identical(other.next, next) || other.next == next) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    next,
    const DeepCollectionEquality().hash(_results),
  );

  /// Create a copy of ListEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListEntityImplCopyWith<_$ListEntityImpl> get copyWith =>
      __$$ListEntityImplCopyWithImpl<_$ListEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListEntityImplToJson(this);
  }
}

abstract class _ListEntity implements ListEntity {
  const factory _ListEntity({
    final String? next,
    required final List<ResultEntity> results,
  }) = _$ListEntityImpl;

  factory _ListEntity.fromJson(Map<String, dynamic> json) =
      _$ListEntityImpl.fromJson;

  @override
  String? get next;
  @override
  List<ResultEntity> get results;

  /// Create a copy of ListEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListEntityImplCopyWith<_$ListEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ResultEntity _$ResultEntityFromJson(Map<String, dynamic> json) {
  return _ResultEntity.fromJson(json);
}

/// @nodoc
mixin _$ResultEntity {
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this ResultEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResultEntityCopyWith<ResultEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultEntityCopyWith<$Res> {
  factory $ResultEntityCopyWith(
    ResultEntity value,
    $Res Function(ResultEntity) then,
  ) = _$ResultEntityCopyWithImpl<$Res, ResultEntity>;
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class _$ResultEntityCopyWithImpl<$Res, $Val extends ResultEntity>
    implements $ResultEntityCopyWith<$Res> {
  _$ResultEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? url = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ResultEntityImplCopyWith<$Res>
    implements $ResultEntityCopyWith<$Res> {
  factory _$$ResultEntityImplCopyWith(
    _$ResultEntityImpl value,
    $Res Function(_$ResultEntityImpl) then,
  ) = __$$ResultEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class __$$ResultEntityImplCopyWithImpl<$Res>
    extends _$ResultEntityCopyWithImpl<$Res, _$ResultEntityImpl>
    implements _$$ResultEntityImplCopyWith<$Res> {
  __$$ResultEntityImplCopyWithImpl(
    _$ResultEntityImpl _value,
    $Res Function(_$ResultEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? url = null}) {
    return _then(
      _$ResultEntityImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ResultEntityImpl implements _ResultEntity {
  const _$ResultEntityImpl({required this.name, required this.url});

  factory _$ResultEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResultEntityImplFromJson(json);

  @override
  final String name;
  @override
  final String url;

  @override
  String toString() {
    return 'ResultEntity(name: $name, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultEntityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, url);

  /// Create a copy of ResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultEntityImplCopyWith<_$ResultEntityImpl> get copyWith =>
      __$$ResultEntityImplCopyWithImpl<_$ResultEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResultEntityImplToJson(this);
  }
}

abstract class _ResultEntity implements ResultEntity {
  const factory _ResultEntity({
    required final String name,
    required final String url,
  }) = _$ResultEntityImpl;

  factory _ResultEntity.fromJson(Map<String, dynamic> json) =
      _$ResultEntityImpl.fromJson;

  @override
  String get name;
  @override
  String get url;

  /// Create a copy of ResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResultEntityImplCopyWith<_$ResultEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
