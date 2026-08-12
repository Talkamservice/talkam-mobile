// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_follow_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GroupFollowState {
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
    required TResult Function(_GroupFollowInitial value) initial,
    required TResult Function(GroupFollowLoading value) loading,
    required TResult Function(GroupFollowSuccess value) success,
    required TResult Function(GroupFollowFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GroupFollowInitial value)? initial,
    TResult? Function(GroupFollowLoading value)? loading,
    TResult? Function(GroupFollowSuccess value)? success,
    TResult? Function(GroupFollowFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GroupFollowInitial value)? initial,
    TResult Function(GroupFollowLoading value)? loading,
    TResult Function(GroupFollowSuccess value)? success,
    TResult Function(GroupFollowFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupFollowStateCopyWith<$Res> {
  factory $GroupFollowStateCopyWith(
          GroupFollowState value, $Res Function(GroupFollowState) then) =
      _$GroupFollowStateCopyWithImpl<$Res, GroupFollowState>;
}

/// @nodoc
class _$GroupFollowStateCopyWithImpl<$Res, $Val extends GroupFollowState>
    implements $GroupFollowStateCopyWith<$Res> {
  _$GroupFollowStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GroupFollowInitialImplCopyWith<$Res> {
  factory _$$GroupFollowInitialImplCopyWith(_$GroupFollowInitialImpl value,
          $Res Function(_$GroupFollowInitialImpl) then) =
      __$$GroupFollowInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GroupFollowInitialImplCopyWithImpl<$Res>
    extends _$GroupFollowStateCopyWithImpl<$Res, _$GroupFollowInitialImpl>
    implements _$$GroupFollowInitialImplCopyWith<$Res> {
  __$$GroupFollowInitialImplCopyWithImpl(_$GroupFollowInitialImpl _value,
      $Res Function(_$GroupFollowInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GroupFollowInitialImpl implements _GroupFollowInitial {
  const _$GroupFollowInitialImpl();

  @override
  String toString() {
    return 'GroupFollowState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GroupFollowInitialImpl);
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
    required TResult Function(_GroupFollowInitial value) initial,
    required TResult Function(GroupFollowLoading value) loading,
    required TResult Function(GroupFollowSuccess value) success,
    required TResult Function(GroupFollowFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GroupFollowInitial value)? initial,
    TResult? Function(GroupFollowLoading value)? loading,
    TResult? Function(GroupFollowSuccess value)? success,
    TResult? Function(GroupFollowFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GroupFollowInitial value)? initial,
    TResult Function(GroupFollowLoading value)? loading,
    TResult Function(GroupFollowSuccess value)? success,
    TResult Function(GroupFollowFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _GroupFollowInitial implements GroupFollowState {
  const factory _GroupFollowInitial() = _$GroupFollowInitialImpl;
}

/// @nodoc
abstract class _$$GroupFollowLoadingImplCopyWith<$Res> {
  factory _$$GroupFollowLoadingImplCopyWith(_$GroupFollowLoadingImpl value,
          $Res Function(_$GroupFollowLoadingImpl) then) =
      __$$GroupFollowLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GroupFollowLoadingImplCopyWithImpl<$Res>
    extends _$GroupFollowStateCopyWithImpl<$Res, _$GroupFollowLoadingImpl>
    implements _$$GroupFollowLoadingImplCopyWith<$Res> {
  __$$GroupFollowLoadingImplCopyWithImpl(_$GroupFollowLoadingImpl _value,
      $Res Function(_$GroupFollowLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GroupFollowLoadingImpl implements GroupFollowLoading {
  const _$GroupFollowLoadingImpl();

  @override
  String toString() {
    return 'GroupFollowState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GroupFollowLoadingImpl);
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
    required TResult Function(_GroupFollowInitial value) initial,
    required TResult Function(GroupFollowLoading value) loading,
    required TResult Function(GroupFollowSuccess value) success,
    required TResult Function(GroupFollowFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GroupFollowInitial value)? initial,
    TResult? Function(GroupFollowLoading value)? loading,
    TResult? Function(GroupFollowSuccess value)? success,
    TResult? Function(GroupFollowFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GroupFollowInitial value)? initial,
    TResult Function(GroupFollowLoading value)? loading,
    TResult Function(GroupFollowSuccess value)? success,
    TResult Function(GroupFollowFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class GroupFollowLoading implements GroupFollowState {
  const factory GroupFollowLoading() = _$GroupFollowLoadingImpl;
}

/// @nodoc
abstract class _$$GroupFollowSuccessImplCopyWith<$Res> {
  factory _$$GroupFollowSuccessImplCopyWith(_$GroupFollowSuccessImpl value,
          $Res Function(_$GroupFollowSuccessImpl) then) =
      __$$GroupFollowSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool following});
}

/// @nodoc
class __$$GroupFollowSuccessImplCopyWithImpl<$Res>
    extends _$GroupFollowStateCopyWithImpl<$Res, _$GroupFollowSuccessImpl>
    implements _$$GroupFollowSuccessImplCopyWith<$Res> {
  __$$GroupFollowSuccessImplCopyWithImpl(_$GroupFollowSuccessImpl _value,
      $Res Function(_$GroupFollowSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? following = null,
  }) {
    return _then(_$GroupFollowSuccessImpl(
      null == following
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GroupFollowSuccessImpl implements GroupFollowSuccess {
  const _$GroupFollowSuccessImpl(this.following);

  @override
  final bool following;

  @override
  String toString() {
    return 'GroupFollowState.success(following: $following)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupFollowSuccessImpl &&
            (identical(other.following, following) ||
                other.following == following));
  }

  @override
  int get hashCode => Object.hash(runtimeType, following);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupFollowSuccessImplCopyWith<_$GroupFollowSuccessImpl> get copyWith =>
      __$$GroupFollowSuccessImplCopyWithImpl<_$GroupFollowSuccessImpl>(
          this, _$identity);

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
    required TResult Function(_GroupFollowInitial value) initial,
    required TResult Function(GroupFollowLoading value) loading,
    required TResult Function(GroupFollowSuccess value) success,
    required TResult Function(GroupFollowFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GroupFollowInitial value)? initial,
    TResult? Function(GroupFollowLoading value)? loading,
    TResult? Function(GroupFollowSuccess value)? success,
    TResult? Function(GroupFollowFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GroupFollowInitial value)? initial,
    TResult Function(GroupFollowLoading value)? loading,
    TResult Function(GroupFollowSuccess value)? success,
    TResult Function(GroupFollowFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class GroupFollowSuccess implements GroupFollowState {
  const factory GroupFollowSuccess(final bool following) =
      _$GroupFollowSuccessImpl;

  bool get following;
  @JsonKey(ignore: true)
  _$$GroupFollowSuccessImplCopyWith<_$GroupFollowSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupFollowFailureImplCopyWith<$Res> {
  factory _$$GroupFollowFailureImplCopyWith(_$GroupFollowFailureImpl value,
          $Res Function(_$GroupFollowFailureImpl) then) =
      __$$GroupFollowFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$GroupFollowFailureImplCopyWithImpl<$Res>
    extends _$GroupFollowStateCopyWithImpl<$Res, _$GroupFollowFailureImpl>
    implements _$$GroupFollowFailureImplCopyWith<$Res> {
  __$$GroupFollowFailureImplCopyWithImpl(_$GroupFollowFailureImpl _value,
      $Res Function(_$GroupFollowFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$GroupFollowFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GroupFollowFailureImpl implements GroupFollowFailure {
  const _$GroupFollowFailureImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'GroupFollowState.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupFollowFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupFollowFailureImplCopyWith<_$GroupFollowFailureImpl> get copyWith =>
      __$$GroupFollowFailureImplCopyWithImpl<_$GroupFollowFailureImpl>(
          this, _$identity);

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
    required TResult Function(_GroupFollowInitial value) initial,
    required TResult Function(GroupFollowLoading value) loading,
    required TResult Function(GroupFollowSuccess value) success,
    required TResult Function(GroupFollowFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GroupFollowInitial value)? initial,
    TResult? Function(GroupFollowLoading value)? loading,
    TResult? Function(GroupFollowSuccess value)? success,
    TResult? Function(GroupFollowFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GroupFollowInitial value)? initial,
    TResult Function(GroupFollowLoading value)? loading,
    TResult Function(GroupFollowSuccess value)? success,
    TResult Function(GroupFollowFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class GroupFollowFailure implements GroupFollowState {
  const factory GroupFollowFailure(final String error) =
      _$GroupFollowFailureImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$GroupFollowFailureImplCopyWith<_$GroupFollowFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
