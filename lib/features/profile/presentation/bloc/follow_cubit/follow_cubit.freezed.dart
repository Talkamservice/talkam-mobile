// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'follow_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FollowState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool following) success,
    required TResult Function(String error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool following)? success,
    TResult? Function(String error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool following)? success,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FollowInitial value) initial,
    required TResult Function(FollowLoading value) loading,
    required TResult Function(FollowSuccess value) success,
    required TResult Function(FollowFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FollowInitial value)? initial,
    TResult? Function(FollowLoading value)? loading,
    TResult? Function(FollowSuccess value)? success,
    TResult? Function(FollowFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FollowInitial value)? initial,
    TResult Function(FollowLoading value)? loading,
    TResult Function(FollowSuccess value)? success,
    TResult Function(FollowFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FollowStateCopyWith<$Res> {
  factory $FollowStateCopyWith(
          FollowState value, $Res Function(FollowState) then) =
      _$FollowStateCopyWithImpl<$Res, FollowState>;
}

/// @nodoc
class _$FollowStateCopyWithImpl<$Res, $Val extends FollowState>
    implements $FollowStateCopyWith<$Res> {
  _$FollowStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FollowInitialImplCopyWith<$Res> {
  factory _$$FollowInitialImplCopyWith(
          _$FollowInitialImpl value, $Res Function(_$FollowInitialImpl) then) =
      __$$FollowInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FollowInitialImplCopyWithImpl<$Res>
    extends _$FollowStateCopyWithImpl<$Res, _$FollowInitialImpl>
    implements _$$FollowInitialImplCopyWith<$Res> {
  __$$FollowInitialImplCopyWithImpl(
      _$FollowInitialImpl _value, $Res Function(_$FollowInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FollowInitialImpl implements _FollowInitial {
  const _$FollowInitialImpl();

  @override
  String toString() {
    return 'FollowState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FollowInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool following) success,
    required TResult Function(String error) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool following)? success,
    TResult? Function(String error)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool following)? success,
    TResult Function(String error)? failure,
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
    required TResult Function(_FollowInitial value) initial,
    required TResult Function(FollowLoading value) loading,
    required TResult Function(FollowSuccess value) success,
    required TResult Function(FollowFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FollowInitial value)? initial,
    TResult? Function(FollowLoading value)? loading,
    TResult? Function(FollowSuccess value)? success,
    TResult? Function(FollowFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FollowInitial value)? initial,
    TResult Function(FollowLoading value)? loading,
    TResult Function(FollowSuccess value)? success,
    TResult Function(FollowFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _FollowInitial implements FollowState {
  const factory _FollowInitial() = _$FollowInitialImpl;
}

/// @nodoc
abstract class _$$FollowLoadingImplCopyWith<$Res> {
  factory _$$FollowLoadingImplCopyWith(
          _$FollowLoadingImpl value, $Res Function(_$FollowLoadingImpl) then) =
      __$$FollowLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FollowLoadingImplCopyWithImpl<$Res>
    extends _$FollowStateCopyWithImpl<$Res, _$FollowLoadingImpl>
    implements _$$FollowLoadingImplCopyWith<$Res> {
  __$$FollowLoadingImplCopyWithImpl(
      _$FollowLoadingImpl _value, $Res Function(_$FollowLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FollowLoadingImpl implements FollowLoading {
  const _$FollowLoadingImpl();

  @override
  String toString() {
    return 'FollowState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FollowLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool following) success,
    required TResult Function(String error) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool following)? success,
    TResult? Function(String error)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool following)? success,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FollowInitial value) initial,
    required TResult Function(FollowLoading value) loading,
    required TResult Function(FollowSuccess value) success,
    required TResult Function(FollowFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FollowInitial value)? initial,
    TResult? Function(FollowLoading value)? loading,
    TResult? Function(FollowSuccess value)? success,
    TResult? Function(FollowFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FollowInitial value)? initial,
    TResult Function(FollowLoading value)? loading,
    TResult Function(FollowSuccess value)? success,
    TResult Function(FollowFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class FollowLoading implements FollowState {
  const factory FollowLoading() = _$FollowLoadingImpl;
}

/// @nodoc
abstract class _$$FollowSuccessImplCopyWith<$Res> {
  factory _$$FollowSuccessImplCopyWith(
          _$FollowSuccessImpl value, $Res Function(_$FollowSuccessImpl) then) =
      __$$FollowSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool following});
}

/// @nodoc
class __$$FollowSuccessImplCopyWithImpl<$Res>
    extends _$FollowStateCopyWithImpl<$Res, _$FollowSuccessImpl>
    implements _$$FollowSuccessImplCopyWith<$Res> {
  __$$FollowSuccessImplCopyWithImpl(
      _$FollowSuccessImpl _value, $Res Function(_$FollowSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? following = null,
  }) {
    return _then(_$FollowSuccessImpl(
      null == following
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FollowSuccessImpl implements FollowSuccess {
  const _$FollowSuccessImpl(this.following);

  @override
  final bool following;

  @override
  String toString() {
    return 'FollowState.success(following: $following)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FollowSuccessImpl &&
            (identical(other.following, following) ||
                other.following == following));
  }

  @override
  int get hashCode => Object.hash(runtimeType, following);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FollowSuccessImplCopyWith<_$FollowSuccessImpl> get copyWith =>
      __$$FollowSuccessImplCopyWithImpl<_$FollowSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool following) success,
    required TResult Function(String error) failure,
  }) {
    return success(following);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool following)? success,
    TResult? Function(String error)? failure,
  }) {
    return success?.call(following);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool following)? success,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(following);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FollowInitial value) initial,
    required TResult Function(FollowLoading value) loading,
    required TResult Function(FollowSuccess value) success,
    required TResult Function(FollowFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FollowInitial value)? initial,
    TResult? Function(FollowLoading value)? loading,
    TResult? Function(FollowSuccess value)? success,
    TResult? Function(FollowFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FollowInitial value)? initial,
    TResult Function(FollowLoading value)? loading,
    TResult Function(FollowSuccess value)? success,
    TResult Function(FollowFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class FollowSuccess implements FollowState {
  const factory FollowSuccess(final bool following) = _$FollowSuccessImpl;

  bool get following;
  @JsonKey(ignore: true)
  _$$FollowSuccessImplCopyWith<_$FollowSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FollowFailureImplCopyWith<$Res> {
  factory _$$FollowFailureImplCopyWith(
          _$FollowFailureImpl value, $Res Function(_$FollowFailureImpl) then) =
      __$$FollowFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$FollowFailureImplCopyWithImpl<$Res>
    extends _$FollowStateCopyWithImpl<$Res, _$FollowFailureImpl>
    implements _$$FollowFailureImplCopyWith<$Res> {
  __$$FollowFailureImplCopyWithImpl(
      _$FollowFailureImpl _value, $Res Function(_$FollowFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$FollowFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FollowFailureImpl implements FollowFailure {
  const _$FollowFailureImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'FollowState.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FollowFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FollowFailureImplCopyWith<_$FollowFailureImpl> get copyWith =>
      __$$FollowFailureImplCopyWithImpl<_$FollowFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool following) success,
    required TResult Function(String error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool following)? success,
    TResult? Function(String error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool following)? success,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FollowInitial value) initial,
    required TResult Function(FollowLoading value) loading,
    required TResult Function(FollowSuccess value) success,
    required TResult Function(FollowFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FollowInitial value)? initial,
    TResult? Function(FollowLoading value)? loading,
    TResult? Function(FollowSuccess value)? success,
    TResult? Function(FollowFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FollowInitial value)? initial,
    TResult Function(FollowLoading value)? loading,
    TResult Function(FollowSuccess value)? success,
    TResult Function(FollowFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class FollowFailure implements FollowState {
  const factory FollowFailure(final String error) = _$FollowFailureImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$FollowFailureImplCopyWith<_$FollowFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
