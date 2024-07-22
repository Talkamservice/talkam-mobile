// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_post_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecentPostState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getRecentPostsLoading,
    required TResult Function(GetPostsResponse response) getRecentPostsSuccess,
    required TResult Function(String error) getRecentPostsFailed,
    required TResult Function() loadingMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getRecentPostsLoading,
    TResult? Function(GetPostsResponse response)? getRecentPostsSuccess,
    TResult? Function(String error)? getRecentPostsFailed,
    TResult? Function()? loadingMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getRecentPostsLoading,
    TResult Function(GetPostsResponse response)? getRecentPostsSuccess,
    TResult Function(String error)? getRecentPostsFailed,
    TResult Function()? loadingMore,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GetRecentPostsLoading value)
        getRecentPostsLoading,
    required TResult Function(_GetRecentPostsSuccess value)
        getRecentPostsSuccess,
    required TResult Function(_GetRecentPostsFailed value) getRecentPostsFailed,
    required TResult Function(_LoadingMore value) loadingMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GetRecentPostsLoading value)? getRecentPostsLoading,
    TResult? Function(_GetRecentPostsSuccess value)? getRecentPostsSuccess,
    TResult? Function(_GetRecentPostsFailed value)? getRecentPostsFailed,
    TResult? Function(_LoadingMore value)? loadingMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GetRecentPostsLoading value)? getRecentPostsLoading,
    TResult Function(_GetRecentPostsSuccess value)? getRecentPostsSuccess,
    TResult Function(_GetRecentPostsFailed value)? getRecentPostsFailed,
    TResult Function(_LoadingMore value)? loadingMore,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentPostStateCopyWith<$Res> {
  factory $RecentPostStateCopyWith(
          RecentPostState value, $Res Function(RecentPostState) then) =
      _$RecentPostStateCopyWithImpl<$Res, RecentPostState>;
}

/// @nodoc
class _$RecentPostStateCopyWithImpl<$Res, $Val extends RecentPostState>
    implements $RecentPostStateCopyWith<$Res> {
  _$RecentPostStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$RecentPostStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'RecentPostState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getRecentPostsLoading,
    required TResult Function(GetPostsResponse response) getRecentPostsSuccess,
    required TResult Function(String error) getRecentPostsFailed,
    required TResult Function() loadingMore,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getRecentPostsLoading,
    TResult? Function(GetPostsResponse response)? getRecentPostsSuccess,
    TResult? Function(String error)? getRecentPostsFailed,
    TResult? Function()? loadingMore,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getRecentPostsLoading,
    TResult Function(GetPostsResponse response)? getRecentPostsSuccess,
    TResult Function(String error)? getRecentPostsFailed,
    TResult Function()? loadingMore,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_GetRecentPostsLoading value)
        getRecentPostsLoading,
    required TResult Function(_GetRecentPostsSuccess value)
        getRecentPostsSuccess,
    required TResult Function(_GetRecentPostsFailed value) getRecentPostsFailed,
    required TResult Function(_LoadingMore value) loadingMore,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GetRecentPostsLoading value)? getRecentPostsLoading,
    TResult? Function(_GetRecentPostsSuccess value)? getRecentPostsSuccess,
    TResult? Function(_GetRecentPostsFailed value)? getRecentPostsFailed,
    TResult? Function(_LoadingMore value)? loadingMore,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GetRecentPostsLoading value)? getRecentPostsLoading,
    TResult Function(_GetRecentPostsSuccess value)? getRecentPostsSuccess,
    TResult Function(_GetRecentPostsFailed value)? getRecentPostsFailed,
    TResult Function(_LoadingMore value)? loadingMore,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements RecentPostState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$GetRecentPostsLoadingImplCopyWith<$Res> {
  factory _$$GetRecentPostsLoadingImplCopyWith(
          _$GetRecentPostsLoadingImpl value,
          $Res Function(_$GetRecentPostsLoadingImpl) then) =
      __$$GetRecentPostsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetRecentPostsLoadingImplCopyWithImpl<$Res>
    extends _$RecentPostStateCopyWithImpl<$Res, _$GetRecentPostsLoadingImpl>
    implements _$$GetRecentPostsLoadingImplCopyWith<$Res> {
  __$$GetRecentPostsLoadingImplCopyWithImpl(_$GetRecentPostsLoadingImpl _value,
      $Res Function(_$GetRecentPostsLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetRecentPostsLoadingImpl implements _GetRecentPostsLoading {
  const _$GetRecentPostsLoadingImpl();

  @override
  String toString() {
    return 'RecentPostState.getRecentPostsLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetRecentPostsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getRecentPostsLoading,
    required TResult Function(GetPostsResponse response) getRecentPostsSuccess,
    required TResult Function(String error) getRecentPostsFailed,
    required TResult Function() loadingMore,
  }) {
    return getRecentPostsLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getRecentPostsLoading,
    TResult? Function(GetPostsResponse response)? getRecentPostsSuccess,
    TResult? Function(String error)? getRecentPostsFailed,
    TResult? Function()? loadingMore,
  }) {
    return getRecentPostsLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getRecentPostsLoading,
    TResult Function(GetPostsResponse response)? getRecentPostsSuccess,
    TResult Function(String error)? getRecentPostsFailed,
    TResult Function()? loadingMore,
    required TResult orElse(),
  }) {
    if (getRecentPostsLoading != null) {
      return getRecentPostsLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GetRecentPostsLoading value)
        getRecentPostsLoading,
    required TResult Function(_GetRecentPostsSuccess value)
        getRecentPostsSuccess,
    required TResult Function(_GetRecentPostsFailed value) getRecentPostsFailed,
    required TResult Function(_LoadingMore value) loadingMore,
  }) {
    return getRecentPostsLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GetRecentPostsLoading value)? getRecentPostsLoading,
    TResult? Function(_GetRecentPostsSuccess value)? getRecentPostsSuccess,
    TResult? Function(_GetRecentPostsFailed value)? getRecentPostsFailed,
    TResult? Function(_LoadingMore value)? loadingMore,
  }) {
    return getRecentPostsLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GetRecentPostsLoading value)? getRecentPostsLoading,
    TResult Function(_GetRecentPostsSuccess value)? getRecentPostsSuccess,
    TResult Function(_GetRecentPostsFailed value)? getRecentPostsFailed,
    TResult Function(_LoadingMore value)? loadingMore,
    required TResult orElse(),
  }) {
    if (getRecentPostsLoading != null) {
      return getRecentPostsLoading(this);
    }
    return orElse();
  }
}

abstract class _GetRecentPostsLoading implements RecentPostState {
  const factory _GetRecentPostsLoading() = _$GetRecentPostsLoadingImpl;
}

/// @nodoc
abstract class _$$GetRecentPostsSuccessImplCopyWith<$Res> {
  factory _$$GetRecentPostsSuccessImplCopyWith(
          _$GetRecentPostsSuccessImpl value,
          $Res Function(_$GetRecentPostsSuccessImpl) then) =
      __$$GetRecentPostsSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GetPostsResponse response});
}

/// @nodoc
class __$$GetRecentPostsSuccessImplCopyWithImpl<$Res>
    extends _$RecentPostStateCopyWithImpl<$Res, _$GetRecentPostsSuccessImpl>
    implements _$$GetRecentPostsSuccessImplCopyWith<$Res> {
  __$$GetRecentPostsSuccessImplCopyWithImpl(_$GetRecentPostsSuccessImpl _value,
      $Res Function(_$GetRecentPostsSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$GetRecentPostsSuccessImpl(
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as GetPostsResponse,
    ));
  }
}

/// @nodoc

class _$GetRecentPostsSuccessImpl implements _GetRecentPostsSuccess {
  const _$GetRecentPostsSuccessImpl(this.response);

  @override
  final GetPostsResponse response;

  @override
  String toString() {
    return 'RecentPostState.getRecentPostsSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetRecentPostsSuccessImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetRecentPostsSuccessImplCopyWith<_$GetRecentPostsSuccessImpl>
      get copyWith => __$$GetRecentPostsSuccessImplCopyWithImpl<
          _$GetRecentPostsSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getRecentPostsLoading,
    required TResult Function(GetPostsResponse response) getRecentPostsSuccess,
    required TResult Function(String error) getRecentPostsFailed,
    required TResult Function() loadingMore,
  }) {
    return getRecentPostsSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getRecentPostsLoading,
    TResult? Function(GetPostsResponse response)? getRecentPostsSuccess,
    TResult? Function(String error)? getRecentPostsFailed,
    TResult? Function()? loadingMore,
  }) {
    return getRecentPostsSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getRecentPostsLoading,
    TResult Function(GetPostsResponse response)? getRecentPostsSuccess,
    TResult Function(String error)? getRecentPostsFailed,
    TResult Function()? loadingMore,
    required TResult orElse(),
  }) {
    if (getRecentPostsSuccess != null) {
      return getRecentPostsSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GetRecentPostsLoading value)
        getRecentPostsLoading,
    required TResult Function(_GetRecentPostsSuccess value)
        getRecentPostsSuccess,
    required TResult Function(_GetRecentPostsFailed value) getRecentPostsFailed,
    required TResult Function(_LoadingMore value) loadingMore,
  }) {
    return getRecentPostsSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GetRecentPostsLoading value)? getRecentPostsLoading,
    TResult? Function(_GetRecentPostsSuccess value)? getRecentPostsSuccess,
    TResult? Function(_GetRecentPostsFailed value)? getRecentPostsFailed,
    TResult? Function(_LoadingMore value)? loadingMore,
  }) {
    return getRecentPostsSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GetRecentPostsLoading value)? getRecentPostsLoading,
    TResult Function(_GetRecentPostsSuccess value)? getRecentPostsSuccess,
    TResult Function(_GetRecentPostsFailed value)? getRecentPostsFailed,
    TResult Function(_LoadingMore value)? loadingMore,
    required TResult orElse(),
  }) {
    if (getRecentPostsSuccess != null) {
      return getRecentPostsSuccess(this);
    }
    return orElse();
  }
}

abstract class _GetRecentPostsSuccess implements RecentPostState {
  const factory _GetRecentPostsSuccess(final GetPostsResponse response) =
      _$GetRecentPostsSuccessImpl;

  GetPostsResponse get response;
  @JsonKey(ignore: true)
  _$$GetRecentPostsSuccessImplCopyWith<_$GetRecentPostsSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetRecentPostsFailedImplCopyWith<$Res> {
  factory _$$GetRecentPostsFailedImplCopyWith(_$GetRecentPostsFailedImpl value,
          $Res Function(_$GetRecentPostsFailedImpl) then) =
      __$$GetRecentPostsFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$GetRecentPostsFailedImplCopyWithImpl<$Res>
    extends _$RecentPostStateCopyWithImpl<$Res, _$GetRecentPostsFailedImpl>
    implements _$$GetRecentPostsFailedImplCopyWith<$Res> {
  __$$GetRecentPostsFailedImplCopyWithImpl(_$GetRecentPostsFailedImpl _value,
      $Res Function(_$GetRecentPostsFailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$GetRecentPostsFailedImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetRecentPostsFailedImpl implements _GetRecentPostsFailed {
  const _$GetRecentPostsFailedImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'RecentPostState.getRecentPostsFailed(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetRecentPostsFailedImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetRecentPostsFailedImplCopyWith<_$GetRecentPostsFailedImpl>
      get copyWith =>
          __$$GetRecentPostsFailedImplCopyWithImpl<_$GetRecentPostsFailedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getRecentPostsLoading,
    required TResult Function(GetPostsResponse response) getRecentPostsSuccess,
    required TResult Function(String error) getRecentPostsFailed,
    required TResult Function() loadingMore,
  }) {
    return getRecentPostsFailed(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getRecentPostsLoading,
    TResult? Function(GetPostsResponse response)? getRecentPostsSuccess,
    TResult? Function(String error)? getRecentPostsFailed,
    TResult? Function()? loadingMore,
  }) {
    return getRecentPostsFailed?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getRecentPostsLoading,
    TResult Function(GetPostsResponse response)? getRecentPostsSuccess,
    TResult Function(String error)? getRecentPostsFailed,
    TResult Function()? loadingMore,
    required TResult orElse(),
  }) {
    if (getRecentPostsFailed != null) {
      return getRecentPostsFailed(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GetRecentPostsLoading value)
        getRecentPostsLoading,
    required TResult Function(_GetRecentPostsSuccess value)
        getRecentPostsSuccess,
    required TResult Function(_GetRecentPostsFailed value) getRecentPostsFailed,
    required TResult Function(_LoadingMore value) loadingMore,
  }) {
    return getRecentPostsFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GetRecentPostsLoading value)? getRecentPostsLoading,
    TResult? Function(_GetRecentPostsSuccess value)? getRecentPostsSuccess,
    TResult? Function(_GetRecentPostsFailed value)? getRecentPostsFailed,
    TResult? Function(_LoadingMore value)? loadingMore,
  }) {
    return getRecentPostsFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GetRecentPostsLoading value)? getRecentPostsLoading,
    TResult Function(_GetRecentPostsSuccess value)? getRecentPostsSuccess,
    TResult Function(_GetRecentPostsFailed value)? getRecentPostsFailed,
    TResult Function(_LoadingMore value)? loadingMore,
    required TResult orElse(),
  }) {
    if (getRecentPostsFailed != null) {
      return getRecentPostsFailed(this);
    }
    return orElse();
  }
}

abstract class _GetRecentPostsFailed implements RecentPostState {
  const factory _GetRecentPostsFailed(final String error) =
      _$GetRecentPostsFailedImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$GetRecentPostsFailedImplCopyWith<_$GetRecentPostsFailedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingMoreImplCopyWith<$Res> {
  factory _$$LoadingMoreImplCopyWith(
          _$LoadingMoreImpl value, $Res Function(_$LoadingMoreImpl) then) =
      __$$LoadingMoreImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingMoreImplCopyWithImpl<$Res>
    extends _$RecentPostStateCopyWithImpl<$Res, _$LoadingMoreImpl>
    implements _$$LoadingMoreImplCopyWith<$Res> {
  __$$LoadingMoreImplCopyWithImpl(
      _$LoadingMoreImpl _value, $Res Function(_$LoadingMoreImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingMoreImpl implements _LoadingMore {
  const _$LoadingMoreImpl();

  @override
  String toString() {
    return 'RecentPostState.loadingMore()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingMoreImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getRecentPostsLoading,
    required TResult Function(GetPostsResponse response) getRecentPostsSuccess,
    required TResult Function(String error) getRecentPostsFailed,
    required TResult Function() loadingMore,
  }) {
    return loadingMore();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getRecentPostsLoading,
    TResult? Function(GetPostsResponse response)? getRecentPostsSuccess,
    TResult? Function(String error)? getRecentPostsFailed,
    TResult? Function()? loadingMore,
  }) {
    return loadingMore?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getRecentPostsLoading,
    TResult Function(GetPostsResponse response)? getRecentPostsSuccess,
    TResult Function(String error)? getRecentPostsFailed,
    TResult Function()? loadingMore,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GetRecentPostsLoading value)
        getRecentPostsLoading,
    required TResult Function(_GetRecentPostsSuccess value)
        getRecentPostsSuccess,
    required TResult Function(_GetRecentPostsFailed value) getRecentPostsFailed,
    required TResult Function(_LoadingMore value) loadingMore,
  }) {
    return loadingMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GetRecentPostsLoading value)? getRecentPostsLoading,
    TResult? Function(_GetRecentPostsSuccess value)? getRecentPostsSuccess,
    TResult? Function(_GetRecentPostsFailed value)? getRecentPostsFailed,
    TResult? Function(_LoadingMore value)? loadingMore,
  }) {
    return loadingMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GetRecentPostsLoading value)? getRecentPostsLoading,
    TResult Function(_GetRecentPostsSuccess value)? getRecentPostsSuccess,
    TResult Function(_GetRecentPostsFailed value)? getRecentPostsFailed,
    TResult Function(_LoadingMore value)? loadingMore,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore(this);
    }
    return orElse();
  }
}

abstract class _LoadingMore implements RecentPostState {
  const factory _LoadingMore() = _$LoadingMoreImpl;
}
