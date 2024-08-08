// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() searchPostsLoading,
    required TResult Function(String error) searchPostsFailed,
    required TResult Function(String error) searchPostsSuccessState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? searchPostsLoading,
    TResult? Function(String error)? searchPostsFailed,
    TResult? Function(String error)? searchPostsSuccessState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? searchPostsLoading,
    TResult Function(String error)? searchPostsFailed,
    TResult Function(String error)? searchPostsSuccessState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SearchPostLoading value) searchPostsLoading,
    required TResult Function(_SearchPostFailed value) searchPostsFailed,
    required TResult Function(_SearchPostSuccessState value)
        searchPostsSuccessState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SearchPostLoading value)? searchPostsLoading,
    TResult? Function(_SearchPostFailed value)? searchPostsFailed,
    TResult? Function(_SearchPostSuccessState value)? searchPostsSuccessState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SearchPostLoading value)? searchPostsLoading,
    TResult Function(_SearchPostFailed value)? searchPostsFailed,
    TResult Function(_SearchPostSuccessState value)? searchPostsSuccessState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res, SearchState>;
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

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
    extends _$SearchStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'SearchState.initial()';
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
    required TResult Function() searchPostsLoading,
    required TResult Function(String error) searchPostsFailed,
    required TResult Function(String error) searchPostsSuccessState,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? searchPostsLoading,
    TResult? Function(String error)? searchPostsFailed,
    TResult? Function(String error)? searchPostsSuccessState,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? searchPostsLoading,
    TResult Function(String error)? searchPostsFailed,
    TResult Function(String error)? searchPostsSuccessState,
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
    required TResult Function(_SearchPostLoading value) searchPostsLoading,
    required TResult Function(_SearchPostFailed value) searchPostsFailed,
    required TResult Function(_SearchPostSuccessState value)
        searchPostsSuccessState,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SearchPostLoading value)? searchPostsLoading,
    TResult? Function(_SearchPostFailed value)? searchPostsFailed,
    TResult? Function(_SearchPostSuccessState value)? searchPostsSuccessState,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SearchPostLoading value)? searchPostsLoading,
    TResult Function(_SearchPostFailed value)? searchPostsFailed,
    TResult Function(_SearchPostSuccessState value)? searchPostsSuccessState,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SearchState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$SearchPostLoadingImplCopyWith<$Res> {
  factory _$$SearchPostLoadingImplCopyWith(_$SearchPostLoadingImpl value,
          $Res Function(_$SearchPostLoadingImpl) then) =
      __$$SearchPostLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchPostLoadingImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchPostLoadingImpl>
    implements _$$SearchPostLoadingImplCopyWith<$Res> {
  __$$SearchPostLoadingImplCopyWithImpl(_$SearchPostLoadingImpl _value,
      $Res Function(_$SearchPostLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SearchPostLoadingImpl implements _SearchPostLoading {
  const _$SearchPostLoadingImpl();

  @override
  String toString() {
    return 'SearchState.searchPostsLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SearchPostLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() searchPostsLoading,
    required TResult Function(String error) searchPostsFailed,
    required TResult Function(String error) searchPostsSuccessState,
  }) {
    return searchPostsLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? searchPostsLoading,
    TResult? Function(String error)? searchPostsFailed,
    TResult? Function(String error)? searchPostsSuccessState,
  }) {
    return searchPostsLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? searchPostsLoading,
    TResult Function(String error)? searchPostsFailed,
    TResult Function(String error)? searchPostsSuccessState,
    required TResult orElse(),
  }) {
    if (searchPostsLoading != null) {
      return searchPostsLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SearchPostLoading value) searchPostsLoading,
    required TResult Function(_SearchPostFailed value) searchPostsFailed,
    required TResult Function(_SearchPostSuccessState value)
        searchPostsSuccessState,
  }) {
    return searchPostsLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SearchPostLoading value)? searchPostsLoading,
    TResult? Function(_SearchPostFailed value)? searchPostsFailed,
    TResult? Function(_SearchPostSuccessState value)? searchPostsSuccessState,
  }) {
    return searchPostsLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SearchPostLoading value)? searchPostsLoading,
    TResult Function(_SearchPostFailed value)? searchPostsFailed,
    TResult Function(_SearchPostSuccessState value)? searchPostsSuccessState,
    required TResult orElse(),
  }) {
    if (searchPostsLoading != null) {
      return searchPostsLoading(this);
    }
    return orElse();
  }
}

abstract class _SearchPostLoading implements SearchState {
  const factory _SearchPostLoading() = _$SearchPostLoadingImpl;
}

/// @nodoc
abstract class _$$SearchPostFailedImplCopyWith<$Res> {
  factory _$$SearchPostFailedImplCopyWith(_$SearchPostFailedImpl value,
          $Res Function(_$SearchPostFailedImpl) then) =
      __$$SearchPostFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$SearchPostFailedImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchPostFailedImpl>
    implements _$$SearchPostFailedImplCopyWith<$Res> {
  __$$SearchPostFailedImplCopyWithImpl(_$SearchPostFailedImpl _value,
      $Res Function(_$SearchPostFailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$SearchPostFailedImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchPostFailedImpl implements _SearchPostFailed {
  const _$SearchPostFailedImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'SearchState.searchPostsFailed(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchPostFailedImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchPostFailedImplCopyWith<_$SearchPostFailedImpl> get copyWith =>
      __$$SearchPostFailedImplCopyWithImpl<_$SearchPostFailedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() searchPostsLoading,
    required TResult Function(String error) searchPostsFailed,
    required TResult Function(String error) searchPostsSuccessState,
  }) {
    return searchPostsFailed(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? searchPostsLoading,
    TResult? Function(String error)? searchPostsFailed,
    TResult? Function(String error)? searchPostsSuccessState,
  }) {
    return searchPostsFailed?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? searchPostsLoading,
    TResult Function(String error)? searchPostsFailed,
    TResult Function(String error)? searchPostsSuccessState,
    required TResult orElse(),
  }) {
    if (searchPostsFailed != null) {
      return searchPostsFailed(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SearchPostLoading value) searchPostsLoading,
    required TResult Function(_SearchPostFailed value) searchPostsFailed,
    required TResult Function(_SearchPostSuccessState value)
        searchPostsSuccessState,
  }) {
    return searchPostsFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SearchPostLoading value)? searchPostsLoading,
    TResult? Function(_SearchPostFailed value)? searchPostsFailed,
    TResult? Function(_SearchPostSuccessState value)? searchPostsSuccessState,
  }) {
    return searchPostsFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SearchPostLoading value)? searchPostsLoading,
    TResult Function(_SearchPostFailed value)? searchPostsFailed,
    TResult Function(_SearchPostSuccessState value)? searchPostsSuccessState,
    required TResult orElse(),
  }) {
    if (searchPostsFailed != null) {
      return searchPostsFailed(this);
    }
    return orElse();
  }
}

abstract class _SearchPostFailed implements SearchState {
  const factory _SearchPostFailed(final String error) = _$SearchPostFailedImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$SearchPostFailedImplCopyWith<_$SearchPostFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchPostSuccessStateImplCopyWith<$Res> {
  factory _$$SearchPostSuccessStateImplCopyWith(
          _$SearchPostSuccessStateImpl value,
          $Res Function(_$SearchPostSuccessStateImpl) then) =
      __$$SearchPostSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$SearchPostSuccessStateImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchPostSuccessStateImpl>
    implements _$$SearchPostSuccessStateImplCopyWith<$Res> {
  __$$SearchPostSuccessStateImplCopyWithImpl(
      _$SearchPostSuccessStateImpl _value,
      $Res Function(_$SearchPostSuccessStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$SearchPostSuccessStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchPostSuccessStateImpl implements _SearchPostSuccessState {
  const _$SearchPostSuccessStateImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'SearchState.searchPostsSuccessState(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchPostSuccessStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchPostSuccessStateImplCopyWith<_$SearchPostSuccessStateImpl>
      get copyWith => __$$SearchPostSuccessStateImplCopyWithImpl<
          _$SearchPostSuccessStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() searchPostsLoading,
    required TResult Function(String error) searchPostsFailed,
    required TResult Function(String error) searchPostsSuccessState,
  }) {
    return searchPostsSuccessState(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? searchPostsLoading,
    TResult? Function(String error)? searchPostsFailed,
    TResult? Function(String error)? searchPostsSuccessState,
  }) {
    return searchPostsSuccessState?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? searchPostsLoading,
    TResult Function(String error)? searchPostsFailed,
    TResult Function(String error)? searchPostsSuccessState,
    required TResult orElse(),
  }) {
    if (searchPostsSuccessState != null) {
      return searchPostsSuccessState(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SearchPostLoading value) searchPostsLoading,
    required TResult Function(_SearchPostFailed value) searchPostsFailed,
    required TResult Function(_SearchPostSuccessState value)
        searchPostsSuccessState,
  }) {
    return searchPostsSuccessState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SearchPostLoading value)? searchPostsLoading,
    TResult? Function(_SearchPostFailed value)? searchPostsFailed,
    TResult? Function(_SearchPostSuccessState value)? searchPostsSuccessState,
  }) {
    return searchPostsSuccessState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SearchPostLoading value)? searchPostsLoading,
    TResult Function(_SearchPostFailed value)? searchPostsFailed,
    TResult Function(_SearchPostSuccessState value)? searchPostsSuccessState,
    required TResult orElse(),
  }) {
    if (searchPostsSuccessState != null) {
      return searchPostsSuccessState(this);
    }
    return orElse();
  }
}

abstract class _SearchPostSuccessState implements SearchState {
  const factory _SearchPostSuccessState(final String error) =
      _$SearchPostSuccessStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$SearchPostSuccessStateImplCopyWith<_$SearchPostSuccessStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
