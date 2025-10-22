// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PokemonQuizEntry _$PokemonQuizEntryFromJson(Map<String, dynamic> json) {
  return _PokemonQuizEntry.fromJson(json);
}

/// @nodoc
mixin _$PokemonQuizEntry {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this PokemonQuizEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PokemonQuizEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PokemonQuizEntryCopyWith<PokemonQuizEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PokemonQuizEntryCopyWith<$Res> {
  factory $PokemonQuizEntryCopyWith(
    PokemonQuizEntry value,
    $Res Function(PokemonQuizEntry) then,
  ) = _$PokemonQuizEntryCopyWithImpl<$Res, PokemonQuizEntry>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$PokemonQuizEntryCopyWithImpl<$Res, $Val extends PokemonQuizEntry>
    implements $PokemonQuizEntryCopyWith<$Res> {
  _$PokemonQuizEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PokemonQuizEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$PokemonQuizEntryImplCopyWith<$Res>
    implements $PokemonQuizEntryCopyWith<$Res> {
  factory _$$PokemonQuizEntryImplCopyWith(
    _$PokemonQuizEntryImpl value,
    $Res Function(_$PokemonQuizEntryImpl) then,
  ) = __$$PokemonQuizEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$PokemonQuizEntryImplCopyWithImpl<$Res>
    extends _$PokemonQuizEntryCopyWithImpl<$Res, _$PokemonQuizEntryImpl>
    implements _$$PokemonQuizEntryImplCopyWith<$Res> {
  __$$PokemonQuizEntryImplCopyWithImpl(
    _$PokemonQuizEntryImpl _value,
    $Res Function(_$PokemonQuizEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PokemonQuizEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$PokemonQuizEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$PokemonQuizEntryImpl implements _PokemonQuizEntry {
  const _$PokemonQuizEntryImpl({required this.id, required this.name});

  factory _$PokemonQuizEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PokemonQuizEntryImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'PokemonQuizEntry(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PokemonQuizEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of PokemonQuizEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PokemonQuizEntryImplCopyWith<_$PokemonQuizEntryImpl> get copyWith =>
      __$$PokemonQuizEntryImplCopyWithImpl<_$PokemonQuizEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PokemonQuizEntryImplToJson(this);
  }
}

abstract class _PokemonQuizEntry implements PokemonQuizEntry {
  const factory _PokemonQuizEntry({
    required final int id,
    required final String name,
  }) = _$PokemonQuizEntryImpl;

  factory _PokemonQuizEntry.fromJson(Map<String, dynamic> json) =
      _$PokemonQuizEntryImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of PokemonQuizEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PokemonQuizEntryImplCopyWith<_$PokemonQuizEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PokemonQuizDetail _$PokemonQuizDetailFromJson(Map<String, dynamic> json) {
  return _PokemonQuizDetail.fromJson(json);
}

/// @nodoc
mixin _$PokemonQuizDetail {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'silhouette_url')
  Uri get silhouetteUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'official_url')
  Uri get officialUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PokemonQuizDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PokemonQuizDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PokemonQuizDetailCopyWith<PokemonQuizDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PokemonQuizDetailCopyWith<$Res> {
  factory $PokemonQuizDetailCopyWith(
    PokemonQuizDetail value,
    $Res Function(PokemonQuizDetail) then,
  ) = _$PokemonQuizDetailCopyWithImpl<$Res, PokemonQuizDetail>;
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'silhouette_url') Uri silhouetteUrl,
    @JsonKey(name: 'official_url') Uri officialUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$PokemonQuizDetailCopyWithImpl<$Res, $Val extends PokemonQuizDetail>
    implements $PokemonQuizDetailCopyWith<$Res> {
  _$PokemonQuizDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PokemonQuizDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? silhouetteUrl = null,
    Object? officialUrl = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            silhouetteUrl: null == silhouetteUrl
                ? _value.silhouetteUrl
                : silhouetteUrl // ignore: cast_nullable_to_non_nullable
                      as Uri,
            officialUrl: null == officialUrl
                ? _value.officialUrl
                : officialUrl // ignore: cast_nullable_to_non_nullable
                      as Uri,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PokemonQuizDetailImplCopyWith<$Res>
    implements $PokemonQuizDetailCopyWith<$Res> {
  factory _$$PokemonQuizDetailImplCopyWith(
    _$PokemonQuizDetailImpl value,
    $Res Function(_$PokemonQuizDetailImpl) then,
  ) = __$$PokemonQuizDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'silhouette_url') Uri silhouetteUrl,
    @JsonKey(name: 'official_url') Uri officialUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$PokemonQuizDetailImplCopyWithImpl<$Res>
    extends _$PokemonQuizDetailCopyWithImpl<$Res, _$PokemonQuizDetailImpl>
    implements _$$PokemonQuizDetailImplCopyWith<$Res> {
  __$$PokemonQuizDetailImplCopyWithImpl(
    _$PokemonQuizDetailImpl _value,
    $Res Function(_$PokemonQuizDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PokemonQuizDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? silhouetteUrl = null,
    Object? officialUrl = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$PokemonQuizDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        silhouetteUrl: null == silhouetteUrl
            ? _value.silhouetteUrl
            : silhouetteUrl // ignore: cast_nullable_to_non_nullable
                  as Uri,
        officialUrl: null == officialUrl
            ? _value.officialUrl
            : officialUrl // ignore: cast_nullable_to_non_nullable
                  as Uri,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PokemonQuizDetailImpl implements _PokemonQuizDetail {
  const _$PokemonQuizDetailImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'silhouette_url') required this.silhouetteUrl,
    @JsonKey(name: 'official_url') required this.officialUrl,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$PokemonQuizDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$PokemonQuizDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'silhouette_url')
  final Uri silhouetteUrl;
  @override
  @JsonKey(name: 'official_url')
  final Uri officialUrl;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'PokemonQuizDetail(id: $id, name: $name, silhouetteUrl: $silhouetteUrl, officialUrl: $officialUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PokemonQuizDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.silhouetteUrl, silhouetteUrl) ||
                other.silhouetteUrl == silhouetteUrl) &&
            (identical(other.officialUrl, officialUrl) ||
                other.officialUrl == officialUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, silhouetteUrl, officialUrl, createdAt);

  /// Create a copy of PokemonQuizDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PokemonQuizDetailImplCopyWith<_$PokemonQuizDetailImpl> get copyWith =>
      __$$PokemonQuizDetailImplCopyWithImpl<_$PokemonQuizDetailImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PokemonQuizDetailImplToJson(this);
  }
}

abstract class _PokemonQuizDetail implements PokemonQuizDetail {
  const factory _PokemonQuizDetail({
    required final int id,
    required final String name,
    @JsonKey(name: 'silhouette_url') required final Uri silhouetteUrl,
    @JsonKey(name: 'official_url') required final Uri officialUrl,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$PokemonQuizDetailImpl;

  factory _PokemonQuizDetail.fromJson(Map<String, dynamic> json) =
      _$PokemonQuizDetailImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'silhouette_url')
  Uri get silhouetteUrl;
  @override
  @JsonKey(name: 'official_url')
  Uri get officialUrl;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of PokemonQuizDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PokemonQuizDetailImplCopyWith<_$PokemonQuizDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PokemonQuizOption {
  int get id => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  bool get isSelected => throw _privateConstructorUsedError;

  /// Create a copy of PokemonQuizOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PokemonQuizOptionCopyWith<PokemonQuizOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PokemonQuizOptionCopyWith<$Res> {
  factory $PokemonQuizOptionCopyWith(
    PokemonQuizOption value,
    $Res Function(PokemonQuizOption) then,
  ) = _$PokemonQuizOptionCopyWithImpl<$Res, PokemonQuizOption>;
  @useResult
  $Res call({int id, String displayName, bool isCorrect, bool isSelected});
}

/// @nodoc
class _$PokemonQuizOptionCopyWithImpl<$Res, $Val extends PokemonQuizOption>
    implements $PokemonQuizOptionCopyWith<$Res> {
  _$PokemonQuizOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PokemonQuizOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? isCorrect = null,
    Object? isSelected = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            isCorrect: null == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSelected: null == isSelected
                ? _value.isSelected
                : isSelected // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PokemonQuizOptionImplCopyWith<$Res>
    implements $PokemonQuizOptionCopyWith<$Res> {
  factory _$$PokemonQuizOptionImplCopyWith(
    _$PokemonQuizOptionImpl value,
    $Res Function(_$PokemonQuizOptionImpl) then,
  ) = __$$PokemonQuizOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String displayName, bool isCorrect, bool isSelected});
}

/// @nodoc
class __$$PokemonQuizOptionImplCopyWithImpl<$Res>
    extends _$PokemonQuizOptionCopyWithImpl<$Res, _$PokemonQuizOptionImpl>
    implements _$$PokemonQuizOptionImplCopyWith<$Res> {
  __$$PokemonQuizOptionImplCopyWithImpl(
    _$PokemonQuizOptionImpl _value,
    $Res Function(_$PokemonQuizOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PokemonQuizOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? isCorrect = null,
    Object? isSelected = null,
  }) {
    return _then(
      _$PokemonQuizOptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        isCorrect: null == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSelected: null == isSelected
            ? _value.isSelected
            : isSelected // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$PokemonQuizOptionImpl implements _PokemonQuizOption {
  const _$PokemonQuizOptionImpl({
    required this.id,
    required this.displayName,
    required this.isCorrect,
    required this.isSelected,
  });

  @override
  final int id;
  @override
  final String displayName;
  @override
  final bool isCorrect;
  @override
  final bool isSelected;

  @override
  String toString() {
    return 'PokemonQuizOption(id: $id, displayName: $displayName, isCorrect: $isCorrect, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PokemonQuizOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, displayName, isCorrect, isSelected);

  /// Create a copy of PokemonQuizOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PokemonQuizOptionImplCopyWith<_$PokemonQuizOptionImpl> get copyWith =>
      __$$PokemonQuizOptionImplCopyWithImpl<_$PokemonQuizOptionImpl>(
        this,
        _$identity,
      );
}

abstract class _PokemonQuizOption implements PokemonQuizOption {
  const factory _PokemonQuizOption({
    required final int id,
    required final String displayName,
    required final bool isCorrect,
    required final bool isSelected,
  }) = _$PokemonQuizOptionImpl;

  @override
  int get id;
  @override
  String get displayName;
  @override
  bool get isCorrect;
  @override
  bool get isSelected;

  /// Create a copy of PokemonQuizOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PokemonQuizOptionImplCopyWith<_$PokemonQuizOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QuizRound {
  PokemonQuizDetail get correct => throw _privateConstructorUsedError;
  List<PokemonQuizOption> get options => throw _privateConstructorUsedError;
  QuizRoundStatus get status => throw _privateConstructorUsedError;
  int? get countdownRemaining => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of QuizRound
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizRoundCopyWith<QuizRound> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizRoundCopyWith<$Res> {
  factory $QuizRoundCopyWith(QuizRound value, $Res Function(QuizRound) then) =
      _$QuizRoundCopyWithImpl<$Res, QuizRound>;
  @useResult
  $Res call({
    PokemonQuizDetail correct,
    List<PokemonQuizOption> options,
    QuizRoundStatus status,
    int? countdownRemaining,
    String? errorMessage,
  });

  $PokemonQuizDetailCopyWith<$Res> get correct;
}

/// @nodoc
class _$QuizRoundCopyWithImpl<$Res, $Val extends QuizRound>
    implements $QuizRoundCopyWith<$Res> {
  _$QuizRoundCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizRound
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? correct = null,
    Object? options = null,
    Object? status = null,
    Object? countdownRemaining = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            correct: null == correct
                ? _value.correct
                : correct // ignore: cast_nullable_to_non_nullable
                      as PokemonQuizDetail,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<PokemonQuizOption>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as QuizRoundStatus,
            countdownRemaining: freezed == countdownRemaining
                ? _value.countdownRemaining
                : countdownRemaining // ignore: cast_nullable_to_non_nullable
                      as int?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of QuizRound
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PokemonQuizDetailCopyWith<$Res> get correct {
    return $PokemonQuizDetailCopyWith<$Res>(_value.correct, (value) {
      return _then(_value.copyWith(correct: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuizRoundImplCopyWith<$Res>
    implements $QuizRoundCopyWith<$Res> {
  factory _$$QuizRoundImplCopyWith(
    _$QuizRoundImpl value,
    $Res Function(_$QuizRoundImpl) then,
  ) = __$$QuizRoundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PokemonQuizDetail correct,
    List<PokemonQuizOption> options,
    QuizRoundStatus status,
    int? countdownRemaining,
    String? errorMessage,
  });

  @override
  $PokemonQuizDetailCopyWith<$Res> get correct;
}

/// @nodoc
class __$$QuizRoundImplCopyWithImpl<$Res>
    extends _$QuizRoundCopyWithImpl<$Res, _$QuizRoundImpl>
    implements _$$QuizRoundImplCopyWith<$Res> {
  __$$QuizRoundImplCopyWithImpl(
    _$QuizRoundImpl _value,
    $Res Function(_$QuizRoundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizRound
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? correct = null,
    Object? options = null,
    Object? status = null,
    Object? countdownRemaining = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$QuizRoundImpl(
        correct: null == correct
            ? _value.correct
            : correct // ignore: cast_nullable_to_non_nullable
                  as PokemonQuizDetail,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<PokemonQuizOption>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as QuizRoundStatus,
        countdownRemaining: freezed == countdownRemaining
            ? _value.countdownRemaining
            : countdownRemaining // ignore: cast_nullable_to_non_nullable
                  as int?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$QuizRoundImpl implements _QuizRound {
  const _$QuizRoundImpl({
    required this.correct,
    required final List<PokemonQuizOption> options,
    required this.status,
    this.countdownRemaining,
    this.errorMessage,
  }) : _options = options;

  @override
  final PokemonQuizDetail correct;
  final List<PokemonQuizOption> _options;
  @override
  List<PokemonQuizOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final QuizRoundStatus status;
  @override
  final int? countdownRemaining;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'QuizRound(correct: $correct, options: $options, status: $status, countdownRemaining: $countdownRemaining, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizRoundImpl &&
            (identical(other.correct, correct) || other.correct == correct) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.countdownRemaining, countdownRemaining) ||
                other.countdownRemaining == countdownRemaining) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    correct,
    const DeepCollectionEquality().hash(_options),
    status,
    countdownRemaining,
    errorMessage,
  );

  /// Create a copy of QuizRound
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizRoundImplCopyWith<_$QuizRoundImpl> get copyWith =>
      __$$QuizRoundImplCopyWithImpl<_$QuizRoundImpl>(this, _$identity);
}

abstract class _QuizRound implements QuizRound {
  const factory _QuizRound({
    required final PokemonQuizDetail correct,
    required final List<PokemonQuizOption> options,
    required final QuizRoundStatus status,
    final int? countdownRemaining,
    final String? errorMessage,
  }) = _$QuizRoundImpl;

  @override
  PokemonQuizDetail get correct;
  @override
  List<PokemonQuizOption> get options;
  @override
  QuizRoundStatus get status;
  @override
  int? get countdownRemaining;
  @override
  String? get errorMessage;

  /// Create a copy of QuizRound
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizRoundImplCopyWith<_$QuizRoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
