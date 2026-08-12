// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connections_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ConnectionsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PostCreator> users) success,
    required TResult Function(String error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PostCreator> users)? success,
    TResult? Function(String error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PostCreator> users)? success,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionsInitial value) initial,
    required TResult Function(ConnectionsLoading value) loading,
    required TResult Function(ConnectionsSuccess value) success,
    required TResult Function(ConnectionsFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionsInitial value)? initial,
    TResult? Function(ConnectionsLoading value)? loading,
    TResult? Function(ConnectionsSuccess value)? success,
    TResult? Function(ConnectionsFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionsInitial value)? initial,
    TResult Function(ConnectionsLoading value)? loading,
    TResult Function(ConnectionsSuccess value)? success,
    TResult Function(ConnectionsFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionsStateCopyWith<$Res> {
  factory $ConnectionsStateCopyWith(
          ConnectionsState value, $Res Function(ConnectionsState) then) =
      _$ConnectionsStateCopyWithImpl<$Res, ConnectionsState>;
}

/// @nodoc
class _$ConnectionsStateCopyWithImpl<$Res, $Val extends ConnectionsState>
    implements $ConnectionsStateCopyWith<$Res> {
  _$ConnectionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ConnectionsInitialImplCopyWith<$Res> {
  factory _$$ConnectionsInitialImplCopyWith(_$ConnectionsInitialImpl value,
          $Res Function(_$ConnectionsInitialImpl) then) =
      __$$ConnectionsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectionsInitialImplCopyWithImpl<$Res>
    extends _$ConnectionsStateCopyWithImpl<$Res, _$ConnectionsInitialImpl>
    implements _$$ConnectionsInitialImplCopyWith<$Res> {
  __$$ConnectionsInitialImplCopyWithImpl(_$ConnectionsInitialImpl _value,
      $Res Function(_$ConnectionsInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ConnectionsInitialImpl implements _ConnectionsInitial {
  const _$ConnectionsInitialImpl();

  @override
  String toString() {
    return 'ConnectionsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectionsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PostCreator> users) success,
    required TResult Function(String error) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PostCreator> users)? success,
    TResult? Function(String error)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PostCreator> users)? success,
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
    required TResult Function(_ConnectionsInitial value) initial,
    required TResult Function(ConnectionsLoading value) loading,
    required TResult Function(ConnectionsSuccess value) success,
    required TResult Function(ConnectionsFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionsInitial value)? initial,
    TResult? Function(ConnectionsLoading value)? loading,
    TResult? Function(ConnectionsSuccess value)? success,
    TResult? Function(ConnectionsFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionsInitial value)? initial,
    TResult Function(ConnectionsLoading value)? loading,
    TResult Function(ConnectionsSuccess value)? success,
    TResult Function(ConnectionsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _ConnectionsInitial implements ConnectionsState {
  const factory _ConnectionsInitial() = _$ConnectionsInitialImpl;
}

/// @nodoc
abstract class _$$ConnectionsLoadingImplCopyWith<$Res> {
  factory _$$ConnectionsLoadingImplCopyWith(_$ConnectionsLoadingImpl value,
          $Res Function(_$ConnectionsLoadingImpl) then) =
      __$$ConnectionsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectionsLoadingImplCopyWithImpl<$Res>
    extends _$ConnectionsStateCopyWithImpl<$Res, _$ConnectionsLoadingImpl>
    implements _$$ConnectionsLoadingImplCopyWith<$Res> {
  __$$ConnectionsLoadingImplCopyWithImpl(_$ConnectionsLoadingImpl _value,
      $Res Function(_$ConnectionsLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ConnectionsLoadingImpl implements ConnectionsLoading {
  const _$ConnectionsLoadingImpl();

  @override
  String toString() {
    return 'ConnectionsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectionsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PostCreator> users) success,
    required TResult Function(String error) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PostCreator> users)? success,
    TResult? Function(String error)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PostCreator> users)? success,
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
    required TResult Function(_ConnectionsInitial value) initial,
    required TResult Function(ConnectionsLoading value) loading,
    required TResult Function(ConnectionsSuccess value) success,
    required TResult Function(ConnectionsFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionsInitial value)? initial,
    TResult? Function(ConnectionsLoading value)? loading,
    TResult? Function(ConnectionsSuccess value)? success,
    TResult? Function(ConnectionsFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionsInitial value)? initial,
    TResult Function(ConnectionsLoading value)? loading,
    TResult Function(ConnectionsSuccess value)? success,
    TResult Function(ConnectionsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ConnectionsLoading implements ConnectionsState {
  const factory ConnectionsLoading() = _$ConnectionsLoadingImpl;
}

/// @nodoc
abstract class _$$ConnectionsSuccessImplCopyWith<$Res> {
  factory _$$ConnectionsSuccessImplCopyWith(_$ConnectionsSuccessImpl value,
          $Res Function(_$ConnectionsSuccessImpl) then) =
      __$$ConnectionsSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PostCreator> users});
}

/// @nodoc
class __$$ConnectionsSuccessImplCopyWithImpl<$Res>
    extends _$ConnectionsStateCopyWithImpl<$Res, _$ConnectionsSuccessImpl>
    implements _$$ConnectionsSuccessImplCopyWith<$Res> {
  __$$ConnectionsSuccessImplCopyWithImpl(_$ConnectionsSuccessImpl _value,
      $Res Function(_$ConnectionsSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
  }) {
    return _then(_$ConnectionsSuccessImpl(
      null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<PostCreator>,
    ));
  }
}

/// @nodoc

class _$ConnectionsSuccessImpl implements ConnectionsSuccess {
  const _$ConnectionsSuccessImpl(final List<PostCreator> users)
      : _users = users;

  final List<PostCreator> _users;
  @override
  List<PostCreator> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  String toString() {
    return 'ConnectionsState.success(users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionsSuccessImpl &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_users));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionsSuccessImplCopyWith<_$ConnectionsSuccessImpl> get copyWith =>
      __$$ConnectionsSuccessImplCopyWithImpl<_$ConnectionsSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PostCreator> users) success,
    required TResult Function(String error) failure,
  }) {
    return success(users);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PostCreator> users)? success,
    TResult? Function(String error)? failure,
  }) {
    return success?.call(users);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PostCreator> users)? success,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(users);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionsInitial value) initial,
    required TResult Function(ConnectionsLoading value) loading,
    required TResult Function(ConnectionsSuccess value) success,
    required TResult Function(ConnectionsFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionsInitial value)? initial,
    TResult? Function(ConnectionsLoading value)? loading,
    TResult? Function(ConnectionsSuccess value)? success,
    TResult? Function(ConnectionsFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionsInitial value)? initial,
    TResult Function(ConnectionsLoading value)? loading,
    TResult Function(ConnectionsSuccess value)? success,
    TResult Function(ConnectionsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ConnectionsSuccess implements ConnectionsState {
  const factory ConnectionsSuccess(final List<PostCreator> users) =
      _$ConnectionsSuccessImpl;

  List<PostCreator> get users;
  @JsonKey(ignore: true)
  _$$ConnectionsSuccessImplCopyWith<_$ConnectionsSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionsFailureImplCopyWith<$Res> {
  factory _$$ConnectionsFailureImplCopyWith(_$ConnectionsFailureImpl value,
          $Res Function(_$ConnectionsFailureImpl) then) =
      __$$ConnectionsFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ConnectionsFailureImplCopyWithImpl<$Res>
    extends _$ConnectionsStateCopyWithImpl<$Res, _$ConnectionsFailureImpl>
    implements _$$ConnectionsFailureImplCopyWith<$Res> {
  __$$ConnectionsFailureImplCopyWithImpl(_$ConnectionsFailureImpl _value,
      $Res Function(_$ConnectionsFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ConnectionsFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConnectionsFailureImpl implements ConnectionsFailure {
  const _$ConnectionsFailureImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'ConnectionsState.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionsFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionsFailureImplCopyWith<_$ConnectionsFailureImpl> get copyWith =>
      __$$ConnectionsFailureImplCopyWithImpl<_$ConnectionsFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PostCreator> users) success,
    required TResult Function(String error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PostCreator> users)? success,
    TResult? Function(String error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PostCreator> users)? success,
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
    required TResult Function(_ConnectionsInitial value) initial,
    required TResult Function(ConnectionsLoading value) loading,
    required TResult Function(ConnectionsSuccess value) success,
    required TResult Function(ConnectionsFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionsInitial value)? initial,
    TResult? Function(ConnectionsLoading value)? loading,
    TResult? Function(ConnectionsSuccess value)? success,
    TResult? Function(ConnectionsFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionsInitial value)? initial,
    TResult Function(ConnectionsLoading value)? loading,
    TResult Function(ConnectionsSuccess value)? success,
    TResult Function(ConnectionsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class ConnectionsFailure implements ConnectionsState {
  const factory ConnectionsFailure(final String error) =
      _$ConnectionsFailureImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$ConnectionsFailureImplCopyWith<_$ConnectionsFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
