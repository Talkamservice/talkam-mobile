// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_serach_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MediaSearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)
        mediaSearchLoaded,
    required TResult Function() initial,
    required TResult Function() getMediaSearchLoading,
    required TResult Function(String error) getMediaSearchFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)?
        mediaSearchLoaded,
    TResult? Function()? initial,
    TResult? Function()? getMediaSearchLoading,
    TResult? Function(String error)? getMediaSearchFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)?
        mediaSearchLoaded,
    TResult Function()? initial,
    TResult Function()? getMediaSearchLoading,
    TResult Function(String error)? getMediaSearchFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MediaSearcLoaded value) mediaSearchLoaded,
    required TResult Function(_MediaInitialState value) initial,
    required TResult Function(_MediaSearchLoading value) getMediaSearchLoading,
    required TResult Function(_MediaSearchFailed value) getMediaSearchFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MediaSearcLoaded value)? mediaSearchLoaded,
    TResult? Function(_MediaInitialState value)? initial,
    TResult? Function(_MediaSearchLoading value)? getMediaSearchLoading,
    TResult? Function(_MediaSearchFailed value)? getMediaSearchFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MediaSearcLoaded value)? mediaSearchLoaded,
    TResult Function(_MediaInitialState value)? initial,
    TResult Function(_MediaSearchLoading value)? getMediaSearchLoading,
    TResult Function(_MediaSearchFailed value)? getMediaSearchFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaSearchStateCopyWith<$Res> {
  factory $MediaSearchStateCopyWith(
          MediaSearchState value, $Res Function(MediaSearchState) then) =
      _$MediaSearchStateCopyWithImpl<$Res, MediaSearchState>;
}

/// @nodoc
class _$MediaSearchStateCopyWithImpl<$Res, $Val extends MediaSearchState>
    implements $MediaSearchStateCopyWith<$Res> {
  _$MediaSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MediaSearcLoadedImplCopyWith<$Res> {
  factory _$$MediaSearcLoadedImplCopyWith(_$MediaSearcLoadedImpl value,
          $Res Function(_$MediaSearcLoadedImpl) then) =
      __$$MediaSearcLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TalkamPost> postResults, PostsPaginationData paginationData});
}

/// @nodoc
class __$$MediaSearcLoadedImplCopyWithImpl<$Res>
    extends _$MediaSearchStateCopyWithImpl<$Res, _$MediaSearcLoadedImpl>
    implements _$$MediaSearcLoadedImplCopyWith<$Res> {
  __$$MediaSearcLoadedImplCopyWithImpl(_$MediaSearcLoadedImpl _value,
      $Res Function(_$MediaSearcLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postResults = null,
    Object? paginationData = null,
  }) {
    return _then(_$MediaSearcLoadedImpl(
      postResults: null == postResults
          ? _value._postResults
          : postResults // ignore: cast_nullable_to_non_nullable
              as List<TalkamPost>,
      paginationData: null == paginationData
          ? _value.paginationData
          : paginationData // ignore: cast_nullable_to_non_nullable
              as PostsPaginationData,
    ));
  }
}

/// @nodoc

class _$MediaSearcLoadedImpl implements _MediaSearcLoaded {
  const _$MediaSearcLoadedImpl(
      {required final List<TalkamPost> postResults,
      required this.paginationData})
      : _postResults = postResults;

  final List<TalkamPost> _postResults;
  @override
  List<TalkamPost> get postResults {
    if (_postResults is EqualUnmodifiableListView) return _postResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_postResults);
  }

  @override
  final PostsPaginationData paginationData;

  @override
  String toString() {
    return 'MediaSearchState.mediaSearchLoaded(postResults: $postResults, paginationData: $paginationData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaSearcLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._postResults, _postResults) &&
            (identical(other.paginationData, paginationData) ||
                other.paginationData == paginationData));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_postResults), paginationData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaSearcLoadedImplCopyWith<_$MediaSearcLoadedImpl> get copyWith =>
      __$$MediaSearcLoadedImplCopyWithImpl<_$MediaSearcLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)
        mediaSearchLoaded,
    required TResult Function() initial,
    required TResult Function() getMediaSearchLoading,
    required TResult Function(String error) getMediaSearchFailed,
  }) {
    return mediaSearchLoaded(postResults, paginationData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)?
        mediaSearchLoaded,
    TResult? Function()? initial,
    TResult? Function()? getMediaSearchLoading,
    TResult? Function(String error)? getMediaSearchFailed,
  }) {
    return mediaSearchLoaded?.call(postResults, paginationData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)?
        mediaSearchLoaded,
    TResult Function()? initial,
    TResult Function()? getMediaSearchLoading,
    TResult Function(String error)? getMediaSearchFailed,
    required TResult orElse(),
  }) {
    if (mediaSearchLoaded != null) {
      return mediaSearchLoaded(postResults, paginationData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MediaSearcLoaded value) mediaSearchLoaded,
    required TResult Function(_MediaInitialState value) initial,
    required TResult Function(_MediaSearchLoading value) getMediaSearchLoading,
    required TResult Function(_MediaSearchFailed value) getMediaSearchFailed,
  }) {
    return mediaSearchLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MediaSearcLoaded value)? mediaSearchLoaded,
    TResult? Function(_MediaInitialState value)? initial,
    TResult? Function(_MediaSearchLoading value)? getMediaSearchLoading,
    TResult? Function(_MediaSearchFailed value)? getMediaSearchFailed,
  }) {
    return mediaSearchLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MediaSearcLoaded value)? mediaSearchLoaded,
    TResult Function(_MediaInitialState value)? initial,
    TResult Function(_MediaSearchLoading value)? getMediaSearchLoading,
    TResult Function(_MediaSearchFailed value)? getMediaSearchFailed,
    required TResult orElse(),
  }) {
    if (mediaSearchLoaded != null) {
      return mediaSearchLoaded(this);
    }
    return orElse();
  }
}

abstract class _MediaSearcLoaded implements MediaSearchState {
  const factory _MediaSearcLoaded(
          {required final List<TalkamPost> postResults,
          required final PostsPaginationData paginationData}) =
      _$MediaSearcLoadedImpl;

  List<TalkamPost> get postResults;
  PostsPaginationData get paginationData;
  @JsonKey(ignore: true)
  _$$MediaSearcLoadedImplCopyWith<_$MediaSearcLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MediaInitialStateImplCopyWith<$Res> {
  factory _$$MediaInitialStateImplCopyWith(_$MediaInitialStateImpl value,
          $Res Function(_$MediaInitialStateImpl) then) =
      __$$MediaInitialStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MediaInitialStateImplCopyWithImpl<$Res>
    extends _$MediaSearchStateCopyWithImpl<$Res, _$MediaInitialStateImpl>
    implements _$$MediaInitialStateImplCopyWith<$Res> {
  __$$MediaInitialStateImplCopyWithImpl(_$MediaInitialStateImpl _value,
      $Res Function(_$MediaInitialStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MediaInitialStateImpl implements _MediaInitialState {
  const _$MediaInitialStateImpl();

  @override
  String toString() {
    return 'MediaSearchState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MediaInitialStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)
        mediaSearchLoaded,
    required TResult Function() initial,
    required TResult Function() getMediaSearchLoading,
    required TResult Function(String error) getMediaSearchFailed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)?
        mediaSearchLoaded,
    TResult? Function()? initial,
    TResult? Function()? getMediaSearchLoading,
    TResult? Function(String error)? getMediaSearchFailed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)?
        mediaSearchLoaded,
    TResult Function()? initial,
    TResult Function()? getMediaSearchLoading,
    TResult Function(String error)? getMediaSearchFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MediaSearcLoaded value) mediaSearchLoaded,
    required TResult Function(_MediaInitialState value) initial,
    required TResult Function(_MediaSearchLoading value) getMediaSearchLoading,
    required TResult Function(_MediaSearchFailed value) getMediaSearchFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MediaSearcLoaded value)? mediaSearchLoaded,
    TResult? Function(_MediaInitialState value)? initial,
    TResult? Function(_MediaSearchLoading value)? getMediaSearchLoading,
    TResult? Function(_MediaSearchFailed value)? getMediaSearchFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MediaSearcLoaded value)? mediaSearchLoaded,
    TResult Function(_MediaInitialState value)? initial,
    TResult Function(_MediaSearchLoading value)? getMediaSearchLoading,
    TResult Function(_MediaSearchFailed value)? getMediaSearchFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _MediaInitialState implements MediaSearchState {
  const factory _MediaInitialState() = _$MediaInitialStateImpl;
}

/// @nodoc
abstract class _$$MediaSearchLoadingImplCopyWith<$Res> {
  factory _$$MediaSearchLoadingImplCopyWith(_$MediaSearchLoadingImpl value,
          $Res Function(_$MediaSearchLoadingImpl) then) =
      __$$MediaSearchLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MediaSearchLoadingImplCopyWithImpl<$Res>
    extends _$MediaSearchStateCopyWithImpl<$Res, _$MediaSearchLoadingImpl>
    implements _$$MediaSearchLoadingImplCopyWith<$Res> {
  __$$MediaSearchLoadingImplCopyWithImpl(_$MediaSearchLoadingImpl _value,
      $Res Function(_$MediaSearchLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MediaSearchLoadingImpl implements _MediaSearchLoading {
  const _$MediaSearchLoadingImpl();

  @override
  String toString() {
    return 'MediaSearchState.getMediaSearchLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MediaSearchLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)
        mediaSearchLoaded,
    required TResult Function() initial,
    required TResult Function() getMediaSearchLoading,
    required TResult Function(String error) getMediaSearchFailed,
  }) {
    return getMediaSearchLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)?
        mediaSearchLoaded,
    TResult? Function()? initial,
    TResult? Function()? getMediaSearchLoading,
    TResult? Function(String error)? getMediaSearchFailed,
  }) {
    return getMediaSearchLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)?
        mediaSearchLoaded,
    TResult Function()? initial,
    TResult Function()? getMediaSearchLoading,
    TResult Function(String error)? getMediaSearchFailed,
    required TResult orElse(),
  }) {
    if (getMediaSearchLoading != null) {
      return getMediaSearchLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MediaSearcLoaded value) mediaSearchLoaded,
    required TResult Function(_MediaInitialState value) initial,
    required TResult Function(_MediaSearchLoading value) getMediaSearchLoading,
    required TResult Function(_MediaSearchFailed value) getMediaSearchFailed,
  }) {
    return getMediaSearchLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MediaSearcLoaded value)? mediaSearchLoaded,
    TResult? Function(_MediaInitialState value)? initial,
    TResult? Function(_MediaSearchLoading value)? getMediaSearchLoading,
    TResult? Function(_MediaSearchFailed value)? getMediaSearchFailed,
  }) {
    return getMediaSearchLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MediaSearcLoaded value)? mediaSearchLoaded,
    TResult Function(_MediaInitialState value)? initial,
    TResult Function(_MediaSearchLoading value)? getMediaSearchLoading,
    TResult Function(_MediaSearchFailed value)? getMediaSearchFailed,
    required TResult orElse(),
  }) {
    if (getMediaSearchLoading != null) {
      return getMediaSearchLoading(this);
    }
    return orElse();
  }
}

abstract class _MediaSearchLoading implements MediaSearchState {
  const factory _MediaSearchLoading() = _$MediaSearchLoadingImpl;
}

/// @nodoc
abstract class _$$MediaSearchFailedImplCopyWith<$Res> {
  factory _$$MediaSearchFailedImplCopyWith(_$MediaSearchFailedImpl value,
          $Res Function(_$MediaSearchFailedImpl) then) =
      __$$MediaSearchFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$MediaSearchFailedImplCopyWithImpl<$Res>
    extends _$MediaSearchStateCopyWithImpl<$Res, _$MediaSearchFailedImpl>
    implements _$$MediaSearchFailedImplCopyWith<$Res> {
  __$$MediaSearchFailedImplCopyWithImpl(_$MediaSearchFailedImpl _value,
      $Res Function(_$MediaSearchFailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$MediaSearchFailedImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MediaSearchFailedImpl implements _MediaSearchFailed {
  const _$MediaSearchFailedImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'MediaSearchState.getMediaSearchFailed(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaSearchFailedImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaSearchFailedImplCopyWith<_$MediaSearchFailedImpl> get copyWith =>
      __$$MediaSearchFailedImplCopyWithImpl<_$MediaSearchFailedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)
        mediaSearchLoaded,
    required TResult Function() initial,
    required TResult Function() getMediaSearchLoading,
    required TResult Function(String error) getMediaSearchFailed,
  }) {
    return getMediaSearchFailed(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)?
        mediaSearchLoaded,
    TResult? Function()? initial,
    TResult? Function()? getMediaSearchLoading,
    TResult? Function(String error)? getMediaSearchFailed,
  }) {
    return getMediaSearchFailed?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<TalkamPost> postResults, PostsPaginationData paginationData)?
        mediaSearchLoaded,
    TResult Function()? initial,
    TResult Function()? getMediaSearchLoading,
    TResult Function(String error)? getMediaSearchFailed,
    required TResult orElse(),
  }) {
    if (getMediaSearchFailed != null) {
      return getMediaSearchFailed(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MediaSearcLoaded value) mediaSearchLoaded,
    required TResult Function(_MediaInitialState value) initial,
    required TResult Function(_MediaSearchLoading value) getMediaSearchLoading,
    required TResult Function(_MediaSearchFailed value) getMediaSearchFailed,
  }) {
    return getMediaSearchFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MediaSearcLoaded value)? mediaSearchLoaded,
    TResult? Function(_MediaInitialState value)? initial,
    TResult? Function(_MediaSearchLoading value)? getMediaSearchLoading,
    TResult? Function(_MediaSearchFailed value)? getMediaSearchFailed,
  }) {
    return getMediaSearchFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MediaSearcLoaded value)? mediaSearchLoaded,
    TResult Function(_MediaInitialState value)? initial,
    TResult Function(_MediaSearchLoading value)? getMediaSearchLoading,
    TResult Function(_MediaSearchFailed value)? getMediaSearchFailed,
    required TResult orElse(),
  }) {
    if (getMediaSearchFailed != null) {
      return getMediaSearchFailed(this);
    }
    return orElse();
  }
}

abstract class _MediaSearchFailed implements MediaSearchState {
  const factory _MediaSearchFailed(final String error) =
      _$MediaSearchFailedImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$MediaSearchFailedImplCopyWith<_$MediaSearchFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
