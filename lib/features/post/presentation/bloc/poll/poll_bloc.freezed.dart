// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PollEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pollId) selectPoll,
    required TResult Function(String pollId) deletePoll,
    required TResult Function() updatePercentage,
    required TResult Function() initialEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pollId)? selectPoll,
    TResult? Function(String pollId)? deletePoll,
    TResult? Function()? updatePercentage,
    TResult? Function()? initialEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pollId)? selectPoll,
    TResult Function(String pollId)? deletePoll,
    TResult Function()? updatePercentage,
    TResult Function()? initialEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectPoll value) selectPoll,
    required TResult Function(_DeletePoll value) deletePoll,
    required TResult Function(_UpdatePercentage value) updatePercentage,
    required TResult Function(_InitialEvent value) initialEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SelectPoll value)? selectPoll,
    TResult? Function(_DeletePoll value)? deletePoll,
    TResult? Function(_UpdatePercentage value)? updatePercentage,
    TResult? Function(_InitialEvent value)? initialEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectPoll value)? selectPoll,
    TResult Function(_DeletePoll value)? deletePoll,
    TResult Function(_UpdatePercentage value)? updatePercentage,
    TResult Function(_InitialEvent value)? initialEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollEventCopyWith<$Res> {
  factory $PollEventCopyWith(PollEvent value, $Res Function(PollEvent) then) =
      _$PollEventCopyWithImpl<$Res, PollEvent>;
}

/// @nodoc
class _$PollEventCopyWithImpl<$Res, $Val extends PollEvent>
    implements $PollEventCopyWith<$Res> {
  _$PollEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SelectPollImplCopyWith<$Res> {
  factory _$$SelectPollImplCopyWith(
          _$SelectPollImpl value, $Res Function(_$SelectPollImpl) then) =
      __$$SelectPollImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String pollId});
}

/// @nodoc
class __$$SelectPollImplCopyWithImpl<$Res>
    extends _$PollEventCopyWithImpl<$Res, _$SelectPollImpl>
    implements _$$SelectPollImplCopyWith<$Res> {
  __$$SelectPollImplCopyWithImpl(
      _$SelectPollImpl _value, $Res Function(_$SelectPollImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pollId = null,
  }) {
    return _then(_$SelectPollImpl(
      null == pollId
          ? _value.pollId
          : pollId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SelectPollImpl implements _SelectPoll {
  const _$SelectPollImpl(this.pollId);

  @override
  final String pollId;

  @override
  String toString() {
    return 'PollEvent.selectPoll(pollId: $pollId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectPollImpl &&
            (identical(other.pollId, pollId) || other.pollId == pollId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pollId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectPollImplCopyWith<_$SelectPollImpl> get copyWith =>
      __$$SelectPollImplCopyWithImpl<_$SelectPollImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pollId) selectPoll,
    required TResult Function(String pollId) deletePoll,
    required TResult Function() updatePercentage,
    required TResult Function() initialEvent,
  }) {
    return selectPoll(pollId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pollId)? selectPoll,
    TResult? Function(String pollId)? deletePoll,
    TResult? Function()? updatePercentage,
    TResult? Function()? initialEvent,
  }) {
    return selectPoll?.call(pollId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pollId)? selectPoll,
    TResult Function(String pollId)? deletePoll,
    TResult Function()? updatePercentage,
    TResult Function()? initialEvent,
    required TResult orElse(),
  }) {
    if (selectPoll != null) {
      return selectPoll(pollId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectPoll value) selectPoll,
    required TResult Function(_DeletePoll value) deletePoll,
    required TResult Function(_UpdatePercentage value) updatePercentage,
    required TResult Function(_InitialEvent value) initialEvent,
  }) {
    return selectPoll(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SelectPoll value)? selectPoll,
    TResult? Function(_DeletePoll value)? deletePoll,
    TResult? Function(_UpdatePercentage value)? updatePercentage,
    TResult? Function(_InitialEvent value)? initialEvent,
  }) {
    return selectPoll?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectPoll value)? selectPoll,
    TResult Function(_DeletePoll value)? deletePoll,
    TResult Function(_UpdatePercentage value)? updatePercentage,
    TResult Function(_InitialEvent value)? initialEvent,
    required TResult orElse(),
  }) {
    if (selectPoll != null) {
      return selectPoll(this);
    }
    return orElse();
  }
}

abstract class _SelectPoll implements PollEvent {
  const factory _SelectPoll(final String pollId) = _$SelectPollImpl;

  String get pollId;
  @JsonKey(ignore: true)
  _$$SelectPollImplCopyWith<_$SelectPollImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeletePollImplCopyWith<$Res> {
  factory _$$DeletePollImplCopyWith(
          _$DeletePollImpl value, $Res Function(_$DeletePollImpl) then) =
      __$$DeletePollImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String pollId});
}

/// @nodoc
class __$$DeletePollImplCopyWithImpl<$Res>
    extends _$PollEventCopyWithImpl<$Res, _$DeletePollImpl>
    implements _$$DeletePollImplCopyWith<$Res> {
  __$$DeletePollImplCopyWithImpl(
      _$DeletePollImpl _value, $Res Function(_$DeletePollImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pollId = null,
  }) {
    return _then(_$DeletePollImpl(
      null == pollId
          ? _value.pollId
          : pollId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeletePollImpl implements _DeletePoll {
  const _$DeletePollImpl(this.pollId);

  @override
  final String pollId;

  @override
  String toString() {
    return 'PollEvent.deletePoll(pollId: $pollId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePollImpl &&
            (identical(other.pollId, pollId) || other.pollId == pollId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pollId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletePollImplCopyWith<_$DeletePollImpl> get copyWith =>
      __$$DeletePollImplCopyWithImpl<_$DeletePollImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pollId) selectPoll,
    required TResult Function(String pollId) deletePoll,
    required TResult Function() updatePercentage,
    required TResult Function() initialEvent,
  }) {
    return deletePoll(pollId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pollId)? selectPoll,
    TResult? Function(String pollId)? deletePoll,
    TResult? Function()? updatePercentage,
    TResult? Function()? initialEvent,
  }) {
    return deletePoll?.call(pollId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pollId)? selectPoll,
    TResult Function(String pollId)? deletePoll,
    TResult Function()? updatePercentage,
    TResult Function()? initialEvent,
    required TResult orElse(),
  }) {
    if (deletePoll != null) {
      return deletePoll(pollId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectPoll value) selectPoll,
    required TResult Function(_DeletePoll value) deletePoll,
    required TResult Function(_UpdatePercentage value) updatePercentage,
    required TResult Function(_InitialEvent value) initialEvent,
  }) {
    return deletePoll(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SelectPoll value)? selectPoll,
    TResult? Function(_DeletePoll value)? deletePoll,
    TResult? Function(_UpdatePercentage value)? updatePercentage,
    TResult? Function(_InitialEvent value)? initialEvent,
  }) {
    return deletePoll?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectPoll value)? selectPoll,
    TResult Function(_DeletePoll value)? deletePoll,
    TResult Function(_UpdatePercentage value)? updatePercentage,
    TResult Function(_InitialEvent value)? initialEvent,
    required TResult orElse(),
  }) {
    if (deletePoll != null) {
      return deletePoll(this);
    }
    return orElse();
  }
}

abstract class _DeletePoll implements PollEvent {
  const factory _DeletePoll(final String pollId) = _$DeletePollImpl;

  String get pollId;
  @JsonKey(ignore: true)
  _$$DeletePollImplCopyWith<_$DeletePollImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdatePercentageImplCopyWith<$Res> {
  factory _$$UpdatePercentageImplCopyWith(_$UpdatePercentageImpl value,
          $Res Function(_$UpdatePercentageImpl) then) =
      __$$UpdatePercentageImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdatePercentageImplCopyWithImpl<$Res>
    extends _$PollEventCopyWithImpl<$Res, _$UpdatePercentageImpl>
    implements _$$UpdatePercentageImplCopyWith<$Res> {
  __$$UpdatePercentageImplCopyWithImpl(_$UpdatePercentageImpl _value,
      $Res Function(_$UpdatePercentageImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UpdatePercentageImpl implements _UpdatePercentage {
  const _$UpdatePercentageImpl();

  @override
  String toString() {
    return 'PollEvent.updatePercentage()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UpdatePercentageImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pollId) selectPoll,
    required TResult Function(String pollId) deletePoll,
    required TResult Function() updatePercentage,
    required TResult Function() initialEvent,
  }) {
    return updatePercentage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pollId)? selectPoll,
    TResult? Function(String pollId)? deletePoll,
    TResult? Function()? updatePercentage,
    TResult? Function()? initialEvent,
  }) {
    return updatePercentage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pollId)? selectPoll,
    TResult Function(String pollId)? deletePoll,
    TResult Function()? updatePercentage,
    TResult Function()? initialEvent,
    required TResult orElse(),
  }) {
    if (updatePercentage != null) {
      return updatePercentage();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectPoll value) selectPoll,
    required TResult Function(_DeletePoll value) deletePoll,
    required TResult Function(_UpdatePercentage value) updatePercentage,
    required TResult Function(_InitialEvent value) initialEvent,
  }) {
    return updatePercentage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SelectPoll value)? selectPoll,
    TResult? Function(_DeletePoll value)? deletePoll,
    TResult? Function(_UpdatePercentage value)? updatePercentage,
    TResult? Function(_InitialEvent value)? initialEvent,
  }) {
    return updatePercentage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectPoll value)? selectPoll,
    TResult Function(_DeletePoll value)? deletePoll,
    TResult Function(_UpdatePercentage value)? updatePercentage,
    TResult Function(_InitialEvent value)? initialEvent,
    required TResult orElse(),
  }) {
    if (updatePercentage != null) {
      return updatePercentage(this);
    }
    return orElse();
  }
}

abstract class _UpdatePercentage implements PollEvent {
  const factory _UpdatePercentage() = _$UpdatePercentageImpl;
}

/// @nodoc
abstract class _$$InitialEventImplCopyWith<$Res> {
  factory _$$InitialEventImplCopyWith(
          _$InitialEventImpl value, $Res Function(_$InitialEventImpl) then) =
      __$$InitialEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialEventImplCopyWithImpl<$Res>
    extends _$PollEventCopyWithImpl<$Res, _$InitialEventImpl>
    implements _$$InitialEventImplCopyWith<$Res> {
  __$$InitialEventImplCopyWithImpl(
      _$InitialEventImpl _value, $Res Function(_$InitialEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialEventImpl implements _InitialEvent {
  const _$InitialEventImpl();

  @override
  String toString() {
    return 'PollEvent.initialEvent()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pollId) selectPoll,
    required TResult Function(String pollId) deletePoll,
    required TResult Function() updatePercentage,
    required TResult Function() initialEvent,
  }) {
    return initialEvent();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pollId)? selectPoll,
    TResult? Function(String pollId)? deletePoll,
    TResult? Function()? updatePercentage,
    TResult? Function()? initialEvent,
  }) {
    return initialEvent?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pollId)? selectPoll,
    TResult Function(String pollId)? deletePoll,
    TResult Function()? updatePercentage,
    TResult Function()? initialEvent,
    required TResult orElse(),
  }) {
    if (initialEvent != null) {
      return initialEvent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectPoll value) selectPoll,
    required TResult Function(_DeletePoll value) deletePoll,
    required TResult Function(_UpdatePercentage value) updatePercentage,
    required TResult Function(_InitialEvent value) initialEvent,
  }) {
    return initialEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SelectPoll value)? selectPoll,
    TResult? Function(_DeletePoll value)? deletePoll,
    TResult? Function(_UpdatePercentage value)? updatePercentage,
    TResult? Function(_InitialEvent value)? initialEvent,
  }) {
    return initialEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectPoll value)? selectPoll,
    TResult Function(_DeletePoll value)? deletePoll,
    TResult Function(_UpdatePercentage value)? updatePercentage,
    TResult Function(_InitialEvent value)? initialEvent,
    required TResult orElse(),
  }) {
    if (initialEvent != null) {
      return initialEvent(this);
    }
    return orElse();
  }
}

abstract class _InitialEvent implements PollEvent {
  const factory _InitialEvent() = _$InitialEventImpl;
}

/// @nodoc
mixin _$PollState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchEFundsLoading,
    required TResult Function(dynamic response) fetchEFundsSuccess,
    required TResult Function(String error) fetchEFundsFailure,
    required TResult Function() selectPollLoading,
    required TResult Function(dynamic response) selectPollSuccess,
    required TResult Function(String error) selectPollFailure,
    required TResult Function() deletePollLoading,
    required TResult Function(dynamic response) deletePollSuccess,
    required TResult Function(String error) deletePollFailure,
    required TResult Function() updatePercentageState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchEFundsLoading,
    TResult? Function(dynamic response)? fetchEFundsSuccess,
    TResult? Function(String error)? fetchEFundsFailure,
    TResult? Function()? selectPollLoading,
    TResult? Function(dynamic response)? selectPollSuccess,
    TResult? Function(String error)? selectPollFailure,
    TResult? Function()? deletePollLoading,
    TResult? Function(dynamic response)? deletePollSuccess,
    TResult? Function(String error)? deletePollFailure,
    TResult? Function()? updatePercentageState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchEFundsLoading,
    TResult Function(dynamic response)? fetchEFundsSuccess,
    TResult Function(String error)? fetchEFundsFailure,
    TResult Function()? selectPollLoading,
    TResult Function(dynamic response)? selectPollSuccess,
    TResult Function(String error)? selectPollFailure,
    TResult Function()? deletePollLoading,
    TResult Function(dynamic response)? deletePollSuccess,
    TResult Function(String error)? deletePollFailure,
    TResult Function()? updatePercentageState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchEFundsLoading value) fetchEFundsLoading,
    required TResult Function(_FetchEFundsSuccess value) fetchEFundsSuccess,
    required TResult Function(_FetchEFundsFailure value) fetchEFundsFailure,
    required TResult Function(_SelectPollLoading value) selectPollLoading,
    required TResult Function(_SelectPollSuccess value) selectPollSuccess,
    required TResult Function(_SelectPollFailure value) selectPollFailure,
    required TResult Function(_DeletePollLoading value) deletePollLoading,
    required TResult Function(_DeletePollSuccess value) deletePollSuccess,
    required TResult Function(_DeletePollFailure value) deletePollFailure,
    required TResult Function(_UpdatePercentageState value)
        updatePercentageState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult? Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult? Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult? Function(_SelectPollLoading value)? selectPollLoading,
    TResult? Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult? Function(_SelectPollFailure value)? selectPollFailure,
    TResult? Function(_DeletePollLoading value)? deletePollLoading,
    TResult? Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult? Function(_DeletePollFailure value)? deletePollFailure,
    TResult? Function(_UpdatePercentageState value)? updatePercentageState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult Function(_SelectPollLoading value)? selectPollLoading,
    TResult Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult Function(_SelectPollFailure value)? selectPollFailure,
    TResult Function(_DeletePollLoading value)? deletePollLoading,
    TResult Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult Function(_DeletePollFailure value)? deletePollFailure,
    TResult Function(_UpdatePercentageState value)? updatePercentageState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollStateCopyWith<$Res> {
  factory $PollStateCopyWith(PollState value, $Res Function(PollState) then) =
      _$PollStateCopyWithImpl<$Res, PollState>;
}

/// @nodoc
class _$PollStateCopyWithImpl<$Res, $Val extends PollState>
    implements $PollStateCopyWith<$Res> {
  _$PollStateCopyWithImpl(this._value, this._then);

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
    extends _$PollStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'PollState.initial()';
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
    required TResult Function() fetchEFundsLoading,
    required TResult Function(dynamic response) fetchEFundsSuccess,
    required TResult Function(String error) fetchEFundsFailure,
    required TResult Function() selectPollLoading,
    required TResult Function(dynamic response) selectPollSuccess,
    required TResult Function(String error) selectPollFailure,
    required TResult Function() deletePollLoading,
    required TResult Function(dynamic response) deletePollSuccess,
    required TResult Function(String error) deletePollFailure,
    required TResult Function() updatePercentageState,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchEFundsLoading,
    TResult? Function(dynamic response)? fetchEFundsSuccess,
    TResult? Function(String error)? fetchEFundsFailure,
    TResult? Function()? selectPollLoading,
    TResult? Function(dynamic response)? selectPollSuccess,
    TResult? Function(String error)? selectPollFailure,
    TResult? Function()? deletePollLoading,
    TResult? Function(dynamic response)? deletePollSuccess,
    TResult? Function(String error)? deletePollFailure,
    TResult? Function()? updatePercentageState,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchEFundsLoading,
    TResult Function(dynamic response)? fetchEFundsSuccess,
    TResult Function(String error)? fetchEFundsFailure,
    TResult Function()? selectPollLoading,
    TResult Function(dynamic response)? selectPollSuccess,
    TResult Function(String error)? selectPollFailure,
    TResult Function()? deletePollLoading,
    TResult Function(dynamic response)? deletePollSuccess,
    TResult Function(String error)? deletePollFailure,
    TResult Function()? updatePercentageState,
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
    required TResult Function(_FetchEFundsLoading value) fetchEFundsLoading,
    required TResult Function(_FetchEFundsSuccess value) fetchEFundsSuccess,
    required TResult Function(_FetchEFundsFailure value) fetchEFundsFailure,
    required TResult Function(_SelectPollLoading value) selectPollLoading,
    required TResult Function(_SelectPollSuccess value) selectPollSuccess,
    required TResult Function(_SelectPollFailure value) selectPollFailure,
    required TResult Function(_DeletePollLoading value) deletePollLoading,
    required TResult Function(_DeletePollSuccess value) deletePollSuccess,
    required TResult Function(_DeletePollFailure value) deletePollFailure,
    required TResult Function(_UpdatePercentageState value)
        updatePercentageState,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult? Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult? Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult? Function(_SelectPollLoading value)? selectPollLoading,
    TResult? Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult? Function(_SelectPollFailure value)? selectPollFailure,
    TResult? Function(_DeletePollLoading value)? deletePollLoading,
    TResult? Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult? Function(_DeletePollFailure value)? deletePollFailure,
    TResult? Function(_UpdatePercentageState value)? updatePercentageState,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult Function(_SelectPollLoading value)? selectPollLoading,
    TResult Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult Function(_SelectPollFailure value)? selectPollFailure,
    TResult Function(_DeletePollLoading value)? deletePollLoading,
    TResult Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult Function(_DeletePollFailure value)? deletePollFailure,
    TResult Function(_UpdatePercentageState value)? updatePercentageState,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements PollState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$FetchEFundsLoadingImplCopyWith<$Res> {
  factory _$$FetchEFundsLoadingImplCopyWith(_$FetchEFundsLoadingImpl value,
          $Res Function(_$FetchEFundsLoadingImpl) then) =
      __$$FetchEFundsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchEFundsLoadingImplCopyWithImpl<$Res>
    extends _$PollStateCopyWithImpl<$Res, _$FetchEFundsLoadingImpl>
    implements _$$FetchEFundsLoadingImplCopyWith<$Res> {
  __$$FetchEFundsLoadingImplCopyWithImpl(_$FetchEFundsLoadingImpl _value,
      $Res Function(_$FetchEFundsLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FetchEFundsLoadingImpl implements _FetchEFundsLoading {
  const _$FetchEFundsLoadingImpl();

  @override
  String toString() {
    return 'PollState.fetchEFundsLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FetchEFundsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchEFundsLoading,
    required TResult Function(dynamic response) fetchEFundsSuccess,
    required TResult Function(String error) fetchEFundsFailure,
    required TResult Function() selectPollLoading,
    required TResult Function(dynamic response) selectPollSuccess,
    required TResult Function(String error) selectPollFailure,
    required TResult Function() deletePollLoading,
    required TResult Function(dynamic response) deletePollSuccess,
    required TResult Function(String error) deletePollFailure,
    required TResult Function() updatePercentageState,
  }) {
    return fetchEFundsLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchEFundsLoading,
    TResult? Function(dynamic response)? fetchEFundsSuccess,
    TResult? Function(String error)? fetchEFundsFailure,
    TResult? Function()? selectPollLoading,
    TResult? Function(dynamic response)? selectPollSuccess,
    TResult? Function(String error)? selectPollFailure,
    TResult? Function()? deletePollLoading,
    TResult? Function(dynamic response)? deletePollSuccess,
    TResult? Function(String error)? deletePollFailure,
    TResult? Function()? updatePercentageState,
  }) {
    return fetchEFundsLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchEFundsLoading,
    TResult Function(dynamic response)? fetchEFundsSuccess,
    TResult Function(String error)? fetchEFundsFailure,
    TResult Function()? selectPollLoading,
    TResult Function(dynamic response)? selectPollSuccess,
    TResult Function(String error)? selectPollFailure,
    TResult Function()? deletePollLoading,
    TResult Function(dynamic response)? deletePollSuccess,
    TResult Function(String error)? deletePollFailure,
    TResult Function()? updatePercentageState,
    required TResult orElse(),
  }) {
    if (fetchEFundsLoading != null) {
      return fetchEFundsLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchEFundsLoading value) fetchEFundsLoading,
    required TResult Function(_FetchEFundsSuccess value) fetchEFundsSuccess,
    required TResult Function(_FetchEFundsFailure value) fetchEFundsFailure,
    required TResult Function(_SelectPollLoading value) selectPollLoading,
    required TResult Function(_SelectPollSuccess value) selectPollSuccess,
    required TResult Function(_SelectPollFailure value) selectPollFailure,
    required TResult Function(_DeletePollLoading value) deletePollLoading,
    required TResult Function(_DeletePollSuccess value) deletePollSuccess,
    required TResult Function(_DeletePollFailure value) deletePollFailure,
    required TResult Function(_UpdatePercentageState value)
        updatePercentageState,
  }) {
    return fetchEFundsLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult? Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult? Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult? Function(_SelectPollLoading value)? selectPollLoading,
    TResult? Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult? Function(_SelectPollFailure value)? selectPollFailure,
    TResult? Function(_DeletePollLoading value)? deletePollLoading,
    TResult? Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult? Function(_DeletePollFailure value)? deletePollFailure,
    TResult? Function(_UpdatePercentageState value)? updatePercentageState,
  }) {
    return fetchEFundsLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult Function(_SelectPollLoading value)? selectPollLoading,
    TResult Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult Function(_SelectPollFailure value)? selectPollFailure,
    TResult Function(_DeletePollLoading value)? deletePollLoading,
    TResult Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult Function(_DeletePollFailure value)? deletePollFailure,
    TResult Function(_UpdatePercentageState value)? updatePercentageState,
    required TResult orElse(),
  }) {
    if (fetchEFundsLoading != null) {
      return fetchEFundsLoading(this);
    }
    return orElse();
  }
}

abstract class _FetchEFundsLoading implements PollState {
  const factory _FetchEFundsLoading() = _$FetchEFundsLoadingImpl;
}

/// @nodoc
abstract class _$$FetchEFundsSuccessImplCopyWith<$Res> {
  factory _$$FetchEFundsSuccessImplCopyWith(_$FetchEFundsSuccessImpl value,
          $Res Function(_$FetchEFundsSuccessImpl) then) =
      __$$FetchEFundsSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic response});
}

/// @nodoc
class __$$FetchEFundsSuccessImplCopyWithImpl<$Res>
    extends _$PollStateCopyWithImpl<$Res, _$FetchEFundsSuccessImpl>
    implements _$$FetchEFundsSuccessImplCopyWith<$Res> {
  __$$FetchEFundsSuccessImplCopyWithImpl(_$FetchEFundsSuccessImpl _value,
      $Res Function(_$FetchEFundsSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_$FetchEFundsSuccessImpl(
      freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$FetchEFundsSuccessImpl implements _FetchEFundsSuccess {
  const _$FetchEFundsSuccessImpl(this.response);

  @override
  final dynamic response;

  @override
  String toString() {
    return 'PollState.fetchEFundsSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchEFundsSuccessImpl &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(response));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchEFundsSuccessImplCopyWith<_$FetchEFundsSuccessImpl> get copyWith =>
      __$$FetchEFundsSuccessImplCopyWithImpl<_$FetchEFundsSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchEFundsLoading,
    required TResult Function(dynamic response) fetchEFundsSuccess,
    required TResult Function(String error) fetchEFundsFailure,
    required TResult Function() selectPollLoading,
    required TResult Function(dynamic response) selectPollSuccess,
    required TResult Function(String error) selectPollFailure,
    required TResult Function() deletePollLoading,
    required TResult Function(dynamic response) deletePollSuccess,
    required TResult Function(String error) deletePollFailure,
    required TResult Function() updatePercentageState,
  }) {
    return fetchEFundsSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchEFundsLoading,
    TResult? Function(dynamic response)? fetchEFundsSuccess,
    TResult? Function(String error)? fetchEFundsFailure,
    TResult? Function()? selectPollLoading,
    TResult? Function(dynamic response)? selectPollSuccess,
    TResult? Function(String error)? selectPollFailure,
    TResult? Function()? deletePollLoading,
    TResult? Function(dynamic response)? deletePollSuccess,
    TResult? Function(String error)? deletePollFailure,
    TResult? Function()? updatePercentageState,
  }) {
    return fetchEFundsSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchEFundsLoading,
    TResult Function(dynamic response)? fetchEFundsSuccess,
    TResult Function(String error)? fetchEFundsFailure,
    TResult Function()? selectPollLoading,
    TResult Function(dynamic response)? selectPollSuccess,
    TResult Function(String error)? selectPollFailure,
    TResult Function()? deletePollLoading,
    TResult Function(dynamic response)? deletePollSuccess,
    TResult Function(String error)? deletePollFailure,
    TResult Function()? updatePercentageState,
    required TResult orElse(),
  }) {
    if (fetchEFundsSuccess != null) {
      return fetchEFundsSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchEFundsLoading value) fetchEFundsLoading,
    required TResult Function(_FetchEFundsSuccess value) fetchEFundsSuccess,
    required TResult Function(_FetchEFundsFailure value) fetchEFundsFailure,
    required TResult Function(_SelectPollLoading value) selectPollLoading,
    required TResult Function(_SelectPollSuccess value) selectPollSuccess,
    required TResult Function(_SelectPollFailure value) selectPollFailure,
    required TResult Function(_DeletePollLoading value) deletePollLoading,
    required TResult Function(_DeletePollSuccess value) deletePollSuccess,
    required TResult Function(_DeletePollFailure value) deletePollFailure,
    required TResult Function(_UpdatePercentageState value)
        updatePercentageState,
  }) {
    return fetchEFundsSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult? Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult? Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult? Function(_SelectPollLoading value)? selectPollLoading,
    TResult? Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult? Function(_SelectPollFailure value)? selectPollFailure,
    TResult? Function(_DeletePollLoading value)? deletePollLoading,
    TResult? Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult? Function(_DeletePollFailure value)? deletePollFailure,
    TResult? Function(_UpdatePercentageState value)? updatePercentageState,
  }) {
    return fetchEFundsSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult Function(_SelectPollLoading value)? selectPollLoading,
    TResult Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult Function(_SelectPollFailure value)? selectPollFailure,
    TResult Function(_DeletePollLoading value)? deletePollLoading,
    TResult Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult Function(_DeletePollFailure value)? deletePollFailure,
    TResult Function(_UpdatePercentageState value)? updatePercentageState,
    required TResult orElse(),
  }) {
    if (fetchEFundsSuccess != null) {
      return fetchEFundsSuccess(this);
    }
    return orElse();
  }
}

abstract class _FetchEFundsSuccess implements PollState {
  const factory _FetchEFundsSuccess(final dynamic response) =
      _$FetchEFundsSuccessImpl;

  dynamic get response;
  @JsonKey(ignore: true)
  _$$FetchEFundsSuccessImplCopyWith<_$FetchEFundsSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchEFundsFailureImplCopyWith<$Res> {
  factory _$$FetchEFundsFailureImplCopyWith(_$FetchEFundsFailureImpl value,
          $Res Function(_$FetchEFundsFailureImpl) then) =
      __$$FetchEFundsFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$FetchEFundsFailureImplCopyWithImpl<$Res>
    extends _$PollStateCopyWithImpl<$Res, _$FetchEFundsFailureImpl>
    implements _$$FetchEFundsFailureImplCopyWith<$Res> {
  __$$FetchEFundsFailureImplCopyWithImpl(_$FetchEFundsFailureImpl _value,
      $Res Function(_$FetchEFundsFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$FetchEFundsFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchEFundsFailureImpl implements _FetchEFundsFailure {
  const _$FetchEFundsFailureImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PollState.fetchEFundsFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchEFundsFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchEFundsFailureImplCopyWith<_$FetchEFundsFailureImpl> get copyWith =>
      __$$FetchEFundsFailureImplCopyWithImpl<_$FetchEFundsFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchEFundsLoading,
    required TResult Function(dynamic response) fetchEFundsSuccess,
    required TResult Function(String error) fetchEFundsFailure,
    required TResult Function() selectPollLoading,
    required TResult Function(dynamic response) selectPollSuccess,
    required TResult Function(String error) selectPollFailure,
    required TResult Function() deletePollLoading,
    required TResult Function(dynamic response) deletePollSuccess,
    required TResult Function(String error) deletePollFailure,
    required TResult Function() updatePercentageState,
  }) {
    return fetchEFundsFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchEFundsLoading,
    TResult? Function(dynamic response)? fetchEFundsSuccess,
    TResult? Function(String error)? fetchEFundsFailure,
    TResult? Function()? selectPollLoading,
    TResult? Function(dynamic response)? selectPollSuccess,
    TResult? Function(String error)? selectPollFailure,
    TResult? Function()? deletePollLoading,
    TResult? Function(dynamic response)? deletePollSuccess,
    TResult? Function(String error)? deletePollFailure,
    TResult? Function()? updatePercentageState,
  }) {
    return fetchEFundsFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchEFundsLoading,
    TResult Function(dynamic response)? fetchEFundsSuccess,
    TResult Function(String error)? fetchEFundsFailure,
    TResult Function()? selectPollLoading,
    TResult Function(dynamic response)? selectPollSuccess,
    TResult Function(String error)? selectPollFailure,
    TResult Function()? deletePollLoading,
    TResult Function(dynamic response)? deletePollSuccess,
    TResult Function(String error)? deletePollFailure,
    TResult Function()? updatePercentageState,
    required TResult orElse(),
  }) {
    if (fetchEFundsFailure != null) {
      return fetchEFundsFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchEFundsLoading value) fetchEFundsLoading,
    required TResult Function(_FetchEFundsSuccess value) fetchEFundsSuccess,
    required TResult Function(_FetchEFundsFailure value) fetchEFundsFailure,
    required TResult Function(_SelectPollLoading value) selectPollLoading,
    required TResult Function(_SelectPollSuccess value) selectPollSuccess,
    required TResult Function(_SelectPollFailure value) selectPollFailure,
    required TResult Function(_DeletePollLoading value) deletePollLoading,
    required TResult Function(_DeletePollSuccess value) deletePollSuccess,
    required TResult Function(_DeletePollFailure value) deletePollFailure,
    required TResult Function(_UpdatePercentageState value)
        updatePercentageState,
  }) {
    return fetchEFundsFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult? Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult? Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult? Function(_SelectPollLoading value)? selectPollLoading,
    TResult? Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult? Function(_SelectPollFailure value)? selectPollFailure,
    TResult? Function(_DeletePollLoading value)? deletePollLoading,
    TResult? Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult? Function(_DeletePollFailure value)? deletePollFailure,
    TResult? Function(_UpdatePercentageState value)? updatePercentageState,
  }) {
    return fetchEFundsFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult Function(_SelectPollLoading value)? selectPollLoading,
    TResult Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult Function(_SelectPollFailure value)? selectPollFailure,
    TResult Function(_DeletePollLoading value)? deletePollLoading,
    TResult Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult Function(_DeletePollFailure value)? deletePollFailure,
    TResult Function(_UpdatePercentageState value)? updatePercentageState,
    required TResult orElse(),
  }) {
    if (fetchEFundsFailure != null) {
      return fetchEFundsFailure(this);
    }
    return orElse();
  }
}

abstract class _FetchEFundsFailure implements PollState {
  const factory _FetchEFundsFailure(final String error) =
      _$FetchEFundsFailureImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$FetchEFundsFailureImplCopyWith<_$FetchEFundsFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectPollLoadingImplCopyWith<$Res> {
  factory _$$SelectPollLoadingImplCopyWith(_$SelectPollLoadingImpl value,
          $Res Function(_$SelectPollLoadingImpl) then) =
      __$$SelectPollLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SelectPollLoadingImplCopyWithImpl<$Res>
    extends _$PollStateCopyWithImpl<$Res, _$SelectPollLoadingImpl>
    implements _$$SelectPollLoadingImplCopyWith<$Res> {
  __$$SelectPollLoadingImplCopyWithImpl(_$SelectPollLoadingImpl _value,
      $Res Function(_$SelectPollLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SelectPollLoadingImpl implements _SelectPollLoading {
  const _$SelectPollLoadingImpl();

  @override
  String toString() {
    return 'PollState.selectPollLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SelectPollLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchEFundsLoading,
    required TResult Function(dynamic response) fetchEFundsSuccess,
    required TResult Function(String error) fetchEFundsFailure,
    required TResult Function() selectPollLoading,
    required TResult Function(dynamic response) selectPollSuccess,
    required TResult Function(String error) selectPollFailure,
    required TResult Function() deletePollLoading,
    required TResult Function(dynamic response) deletePollSuccess,
    required TResult Function(String error) deletePollFailure,
    required TResult Function() updatePercentageState,
  }) {
    return selectPollLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchEFundsLoading,
    TResult? Function(dynamic response)? fetchEFundsSuccess,
    TResult? Function(String error)? fetchEFundsFailure,
    TResult? Function()? selectPollLoading,
    TResult? Function(dynamic response)? selectPollSuccess,
    TResult? Function(String error)? selectPollFailure,
    TResult? Function()? deletePollLoading,
    TResult? Function(dynamic response)? deletePollSuccess,
    TResult? Function(String error)? deletePollFailure,
    TResult? Function()? updatePercentageState,
  }) {
    return selectPollLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchEFundsLoading,
    TResult Function(dynamic response)? fetchEFundsSuccess,
    TResult Function(String error)? fetchEFundsFailure,
    TResult Function()? selectPollLoading,
    TResult Function(dynamic response)? selectPollSuccess,
    TResult Function(String error)? selectPollFailure,
    TResult Function()? deletePollLoading,
    TResult Function(dynamic response)? deletePollSuccess,
    TResult Function(String error)? deletePollFailure,
    TResult Function()? updatePercentageState,
    required TResult orElse(),
  }) {
    if (selectPollLoading != null) {
      return selectPollLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchEFundsLoading value) fetchEFundsLoading,
    required TResult Function(_FetchEFundsSuccess value) fetchEFundsSuccess,
    required TResult Function(_FetchEFundsFailure value) fetchEFundsFailure,
    required TResult Function(_SelectPollLoading value) selectPollLoading,
    required TResult Function(_SelectPollSuccess value) selectPollSuccess,
    required TResult Function(_SelectPollFailure value) selectPollFailure,
    required TResult Function(_DeletePollLoading value) deletePollLoading,
    required TResult Function(_DeletePollSuccess value) deletePollSuccess,
    required TResult Function(_DeletePollFailure value) deletePollFailure,
    required TResult Function(_UpdatePercentageState value)
        updatePercentageState,
  }) {
    return selectPollLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult? Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult? Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult? Function(_SelectPollLoading value)? selectPollLoading,
    TResult? Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult? Function(_SelectPollFailure value)? selectPollFailure,
    TResult? Function(_DeletePollLoading value)? deletePollLoading,
    TResult? Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult? Function(_DeletePollFailure value)? deletePollFailure,
    TResult? Function(_UpdatePercentageState value)? updatePercentageState,
  }) {
    return selectPollLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult Function(_SelectPollLoading value)? selectPollLoading,
    TResult Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult Function(_SelectPollFailure value)? selectPollFailure,
    TResult Function(_DeletePollLoading value)? deletePollLoading,
    TResult Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult Function(_DeletePollFailure value)? deletePollFailure,
    TResult Function(_UpdatePercentageState value)? updatePercentageState,
    required TResult orElse(),
  }) {
    if (selectPollLoading != null) {
      return selectPollLoading(this);
    }
    return orElse();
  }
}

abstract class _SelectPollLoading implements PollState {
  const factory _SelectPollLoading() = _$SelectPollLoadingImpl;
}

/// @nodoc
abstract class _$$SelectPollSuccessImplCopyWith<$Res> {
  factory _$$SelectPollSuccessImplCopyWith(_$SelectPollSuccessImpl value,
          $Res Function(_$SelectPollSuccessImpl) then) =
      __$$SelectPollSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic response});
}

/// @nodoc
class __$$SelectPollSuccessImplCopyWithImpl<$Res>
    extends _$PollStateCopyWithImpl<$Res, _$SelectPollSuccessImpl>
    implements _$$SelectPollSuccessImplCopyWith<$Res> {
  __$$SelectPollSuccessImplCopyWithImpl(_$SelectPollSuccessImpl _value,
      $Res Function(_$SelectPollSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_$SelectPollSuccessImpl(
      freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$SelectPollSuccessImpl implements _SelectPollSuccess {
  const _$SelectPollSuccessImpl(this.response);

  @override
  final dynamic response;

  @override
  String toString() {
    return 'PollState.selectPollSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectPollSuccessImpl &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(response));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectPollSuccessImplCopyWith<_$SelectPollSuccessImpl> get copyWith =>
      __$$SelectPollSuccessImplCopyWithImpl<_$SelectPollSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchEFundsLoading,
    required TResult Function(dynamic response) fetchEFundsSuccess,
    required TResult Function(String error) fetchEFundsFailure,
    required TResult Function() selectPollLoading,
    required TResult Function(dynamic response) selectPollSuccess,
    required TResult Function(String error) selectPollFailure,
    required TResult Function() deletePollLoading,
    required TResult Function(dynamic response) deletePollSuccess,
    required TResult Function(String error) deletePollFailure,
    required TResult Function() updatePercentageState,
  }) {
    return selectPollSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchEFundsLoading,
    TResult? Function(dynamic response)? fetchEFundsSuccess,
    TResult? Function(String error)? fetchEFundsFailure,
    TResult? Function()? selectPollLoading,
    TResult? Function(dynamic response)? selectPollSuccess,
    TResult? Function(String error)? selectPollFailure,
    TResult? Function()? deletePollLoading,
    TResult? Function(dynamic response)? deletePollSuccess,
    TResult? Function(String error)? deletePollFailure,
    TResult? Function()? updatePercentageState,
  }) {
    return selectPollSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchEFundsLoading,
    TResult Function(dynamic response)? fetchEFundsSuccess,
    TResult Function(String error)? fetchEFundsFailure,
    TResult Function()? selectPollLoading,
    TResult Function(dynamic response)? selectPollSuccess,
    TResult Function(String error)? selectPollFailure,
    TResult Function()? deletePollLoading,
    TResult Function(dynamic response)? deletePollSuccess,
    TResult Function(String error)? deletePollFailure,
    TResult Function()? updatePercentageState,
    required TResult orElse(),
  }) {
    if (selectPollSuccess != null) {
      return selectPollSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchEFundsLoading value) fetchEFundsLoading,
    required TResult Function(_FetchEFundsSuccess value) fetchEFundsSuccess,
    required TResult Function(_FetchEFundsFailure value) fetchEFundsFailure,
    required TResult Function(_SelectPollLoading value) selectPollLoading,
    required TResult Function(_SelectPollSuccess value) selectPollSuccess,
    required TResult Function(_SelectPollFailure value) selectPollFailure,
    required TResult Function(_DeletePollLoading value) deletePollLoading,
    required TResult Function(_DeletePollSuccess value) deletePollSuccess,
    required TResult Function(_DeletePollFailure value) deletePollFailure,
    required TResult Function(_UpdatePercentageState value)
        updatePercentageState,
  }) {
    return selectPollSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult? Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult? Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult? Function(_SelectPollLoading value)? selectPollLoading,
    TResult? Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult? Function(_SelectPollFailure value)? selectPollFailure,
    TResult? Function(_DeletePollLoading value)? deletePollLoading,
    TResult? Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult? Function(_DeletePollFailure value)? deletePollFailure,
    TResult? Function(_UpdatePercentageState value)? updatePercentageState,
  }) {
    return selectPollSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult Function(_SelectPollLoading value)? selectPollLoading,
    TResult Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult Function(_SelectPollFailure value)? selectPollFailure,
    TResult Function(_DeletePollLoading value)? deletePollLoading,
    TResult Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult Function(_DeletePollFailure value)? deletePollFailure,
    TResult Function(_UpdatePercentageState value)? updatePercentageState,
    required TResult orElse(),
  }) {
    if (selectPollSuccess != null) {
      return selectPollSuccess(this);
    }
    return orElse();
  }
}

abstract class _SelectPollSuccess implements PollState {
  const factory _SelectPollSuccess(final dynamic response) =
      _$SelectPollSuccessImpl;

  dynamic get response;
  @JsonKey(ignore: true)
  _$$SelectPollSuccessImplCopyWith<_$SelectPollSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectPollFailureImplCopyWith<$Res> {
  factory _$$SelectPollFailureImplCopyWith(_$SelectPollFailureImpl value,
          $Res Function(_$SelectPollFailureImpl) then) =
      __$$SelectPollFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$SelectPollFailureImplCopyWithImpl<$Res>
    extends _$PollStateCopyWithImpl<$Res, _$SelectPollFailureImpl>
    implements _$$SelectPollFailureImplCopyWith<$Res> {
  __$$SelectPollFailureImplCopyWithImpl(_$SelectPollFailureImpl _value,
      $Res Function(_$SelectPollFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$SelectPollFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SelectPollFailureImpl implements _SelectPollFailure {
  const _$SelectPollFailureImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PollState.selectPollFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectPollFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectPollFailureImplCopyWith<_$SelectPollFailureImpl> get copyWith =>
      __$$SelectPollFailureImplCopyWithImpl<_$SelectPollFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchEFundsLoading,
    required TResult Function(dynamic response) fetchEFundsSuccess,
    required TResult Function(String error) fetchEFundsFailure,
    required TResult Function() selectPollLoading,
    required TResult Function(dynamic response) selectPollSuccess,
    required TResult Function(String error) selectPollFailure,
    required TResult Function() deletePollLoading,
    required TResult Function(dynamic response) deletePollSuccess,
    required TResult Function(String error) deletePollFailure,
    required TResult Function() updatePercentageState,
  }) {
    return selectPollFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchEFundsLoading,
    TResult? Function(dynamic response)? fetchEFundsSuccess,
    TResult? Function(String error)? fetchEFundsFailure,
    TResult? Function()? selectPollLoading,
    TResult? Function(dynamic response)? selectPollSuccess,
    TResult? Function(String error)? selectPollFailure,
    TResult? Function()? deletePollLoading,
    TResult? Function(dynamic response)? deletePollSuccess,
    TResult? Function(String error)? deletePollFailure,
    TResult? Function()? updatePercentageState,
  }) {
    return selectPollFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchEFundsLoading,
    TResult Function(dynamic response)? fetchEFundsSuccess,
    TResult Function(String error)? fetchEFundsFailure,
    TResult Function()? selectPollLoading,
    TResult Function(dynamic response)? selectPollSuccess,
    TResult Function(String error)? selectPollFailure,
    TResult Function()? deletePollLoading,
    TResult Function(dynamic response)? deletePollSuccess,
    TResult Function(String error)? deletePollFailure,
    TResult Function()? updatePercentageState,
    required TResult orElse(),
  }) {
    if (selectPollFailure != null) {
      return selectPollFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchEFundsLoading value) fetchEFundsLoading,
    required TResult Function(_FetchEFundsSuccess value) fetchEFundsSuccess,
    required TResult Function(_FetchEFundsFailure value) fetchEFundsFailure,
    required TResult Function(_SelectPollLoading value) selectPollLoading,
    required TResult Function(_SelectPollSuccess value) selectPollSuccess,
    required TResult Function(_SelectPollFailure value) selectPollFailure,
    required TResult Function(_DeletePollLoading value) deletePollLoading,
    required TResult Function(_DeletePollSuccess value) deletePollSuccess,
    required TResult Function(_DeletePollFailure value) deletePollFailure,
    required TResult Function(_UpdatePercentageState value)
        updatePercentageState,
  }) {
    return selectPollFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult? Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult? Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult? Function(_SelectPollLoading value)? selectPollLoading,
    TResult? Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult? Function(_SelectPollFailure value)? selectPollFailure,
    TResult? Function(_DeletePollLoading value)? deletePollLoading,
    TResult? Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult? Function(_DeletePollFailure value)? deletePollFailure,
    TResult? Function(_UpdatePercentageState value)? updatePercentageState,
  }) {
    return selectPollFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult Function(_SelectPollLoading value)? selectPollLoading,
    TResult Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult Function(_SelectPollFailure value)? selectPollFailure,
    TResult Function(_DeletePollLoading value)? deletePollLoading,
    TResult Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult Function(_DeletePollFailure value)? deletePollFailure,
    TResult Function(_UpdatePercentageState value)? updatePercentageState,
    required TResult orElse(),
  }) {
    if (selectPollFailure != null) {
      return selectPollFailure(this);
    }
    return orElse();
  }
}

abstract class _SelectPollFailure implements PollState {
  const factory _SelectPollFailure(final String error) =
      _$SelectPollFailureImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$SelectPollFailureImplCopyWith<_$SelectPollFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeletePollLoadingImplCopyWith<$Res> {
  factory _$$DeletePollLoadingImplCopyWith(_$DeletePollLoadingImpl value,
          $Res Function(_$DeletePollLoadingImpl) then) =
      __$$DeletePollLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeletePollLoadingImplCopyWithImpl<$Res>
    extends _$PollStateCopyWithImpl<$Res, _$DeletePollLoadingImpl>
    implements _$$DeletePollLoadingImplCopyWith<$Res> {
  __$$DeletePollLoadingImplCopyWithImpl(_$DeletePollLoadingImpl _value,
      $Res Function(_$DeletePollLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DeletePollLoadingImpl implements _DeletePollLoading {
  const _$DeletePollLoadingImpl();

  @override
  String toString() {
    return 'PollState.deletePollLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeletePollLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchEFundsLoading,
    required TResult Function(dynamic response) fetchEFundsSuccess,
    required TResult Function(String error) fetchEFundsFailure,
    required TResult Function() selectPollLoading,
    required TResult Function(dynamic response) selectPollSuccess,
    required TResult Function(String error) selectPollFailure,
    required TResult Function() deletePollLoading,
    required TResult Function(dynamic response) deletePollSuccess,
    required TResult Function(String error) deletePollFailure,
    required TResult Function() updatePercentageState,
  }) {
    return deletePollLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchEFundsLoading,
    TResult? Function(dynamic response)? fetchEFundsSuccess,
    TResult? Function(String error)? fetchEFundsFailure,
    TResult? Function()? selectPollLoading,
    TResult? Function(dynamic response)? selectPollSuccess,
    TResult? Function(String error)? selectPollFailure,
    TResult? Function()? deletePollLoading,
    TResult? Function(dynamic response)? deletePollSuccess,
    TResult? Function(String error)? deletePollFailure,
    TResult? Function()? updatePercentageState,
  }) {
    return deletePollLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchEFundsLoading,
    TResult Function(dynamic response)? fetchEFundsSuccess,
    TResult Function(String error)? fetchEFundsFailure,
    TResult Function()? selectPollLoading,
    TResult Function(dynamic response)? selectPollSuccess,
    TResult Function(String error)? selectPollFailure,
    TResult Function()? deletePollLoading,
    TResult Function(dynamic response)? deletePollSuccess,
    TResult Function(String error)? deletePollFailure,
    TResult Function()? updatePercentageState,
    required TResult orElse(),
  }) {
    if (deletePollLoading != null) {
      return deletePollLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchEFundsLoading value) fetchEFundsLoading,
    required TResult Function(_FetchEFundsSuccess value) fetchEFundsSuccess,
    required TResult Function(_FetchEFundsFailure value) fetchEFundsFailure,
    required TResult Function(_SelectPollLoading value) selectPollLoading,
    required TResult Function(_SelectPollSuccess value) selectPollSuccess,
    required TResult Function(_SelectPollFailure value) selectPollFailure,
    required TResult Function(_DeletePollLoading value) deletePollLoading,
    required TResult Function(_DeletePollSuccess value) deletePollSuccess,
    required TResult Function(_DeletePollFailure value) deletePollFailure,
    required TResult Function(_UpdatePercentageState value)
        updatePercentageState,
  }) {
    return deletePollLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult? Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult? Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult? Function(_SelectPollLoading value)? selectPollLoading,
    TResult? Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult? Function(_SelectPollFailure value)? selectPollFailure,
    TResult? Function(_DeletePollLoading value)? deletePollLoading,
    TResult? Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult? Function(_DeletePollFailure value)? deletePollFailure,
    TResult? Function(_UpdatePercentageState value)? updatePercentageState,
  }) {
    return deletePollLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult Function(_SelectPollLoading value)? selectPollLoading,
    TResult Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult Function(_SelectPollFailure value)? selectPollFailure,
    TResult Function(_DeletePollLoading value)? deletePollLoading,
    TResult Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult Function(_DeletePollFailure value)? deletePollFailure,
    TResult Function(_UpdatePercentageState value)? updatePercentageState,
    required TResult orElse(),
  }) {
    if (deletePollLoading != null) {
      return deletePollLoading(this);
    }
    return orElse();
  }
}

abstract class _DeletePollLoading implements PollState {
  const factory _DeletePollLoading() = _$DeletePollLoadingImpl;
}

/// @nodoc
abstract class _$$DeletePollSuccessImplCopyWith<$Res> {
  factory _$$DeletePollSuccessImplCopyWith(_$DeletePollSuccessImpl value,
          $Res Function(_$DeletePollSuccessImpl) then) =
      __$$DeletePollSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic response});
}

/// @nodoc
class __$$DeletePollSuccessImplCopyWithImpl<$Res>
    extends _$PollStateCopyWithImpl<$Res, _$DeletePollSuccessImpl>
    implements _$$DeletePollSuccessImplCopyWith<$Res> {
  __$$DeletePollSuccessImplCopyWithImpl(_$DeletePollSuccessImpl _value,
      $Res Function(_$DeletePollSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_$DeletePollSuccessImpl(
      freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$DeletePollSuccessImpl implements _DeletePollSuccess {
  const _$DeletePollSuccessImpl(this.response);

  @override
  final dynamic response;

  @override
  String toString() {
    return 'PollState.deletePollSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePollSuccessImpl &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(response));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletePollSuccessImplCopyWith<_$DeletePollSuccessImpl> get copyWith =>
      __$$DeletePollSuccessImplCopyWithImpl<_$DeletePollSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchEFundsLoading,
    required TResult Function(dynamic response) fetchEFundsSuccess,
    required TResult Function(String error) fetchEFundsFailure,
    required TResult Function() selectPollLoading,
    required TResult Function(dynamic response) selectPollSuccess,
    required TResult Function(String error) selectPollFailure,
    required TResult Function() deletePollLoading,
    required TResult Function(dynamic response) deletePollSuccess,
    required TResult Function(String error) deletePollFailure,
    required TResult Function() updatePercentageState,
  }) {
    return deletePollSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchEFundsLoading,
    TResult? Function(dynamic response)? fetchEFundsSuccess,
    TResult? Function(String error)? fetchEFundsFailure,
    TResult? Function()? selectPollLoading,
    TResult? Function(dynamic response)? selectPollSuccess,
    TResult? Function(String error)? selectPollFailure,
    TResult? Function()? deletePollLoading,
    TResult? Function(dynamic response)? deletePollSuccess,
    TResult? Function(String error)? deletePollFailure,
    TResult? Function()? updatePercentageState,
  }) {
    return deletePollSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchEFundsLoading,
    TResult Function(dynamic response)? fetchEFundsSuccess,
    TResult Function(String error)? fetchEFundsFailure,
    TResult Function()? selectPollLoading,
    TResult Function(dynamic response)? selectPollSuccess,
    TResult Function(String error)? selectPollFailure,
    TResult Function()? deletePollLoading,
    TResult Function(dynamic response)? deletePollSuccess,
    TResult Function(String error)? deletePollFailure,
    TResult Function()? updatePercentageState,
    required TResult orElse(),
  }) {
    if (deletePollSuccess != null) {
      return deletePollSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchEFundsLoading value) fetchEFundsLoading,
    required TResult Function(_FetchEFundsSuccess value) fetchEFundsSuccess,
    required TResult Function(_FetchEFundsFailure value) fetchEFundsFailure,
    required TResult Function(_SelectPollLoading value) selectPollLoading,
    required TResult Function(_SelectPollSuccess value) selectPollSuccess,
    required TResult Function(_SelectPollFailure value) selectPollFailure,
    required TResult Function(_DeletePollLoading value) deletePollLoading,
    required TResult Function(_DeletePollSuccess value) deletePollSuccess,
    required TResult Function(_DeletePollFailure value) deletePollFailure,
    required TResult Function(_UpdatePercentageState value)
        updatePercentageState,
  }) {
    return deletePollSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult? Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult? Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult? Function(_SelectPollLoading value)? selectPollLoading,
    TResult? Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult? Function(_SelectPollFailure value)? selectPollFailure,
    TResult? Function(_DeletePollLoading value)? deletePollLoading,
    TResult? Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult? Function(_DeletePollFailure value)? deletePollFailure,
    TResult? Function(_UpdatePercentageState value)? updatePercentageState,
  }) {
    return deletePollSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult Function(_SelectPollLoading value)? selectPollLoading,
    TResult Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult Function(_SelectPollFailure value)? selectPollFailure,
    TResult Function(_DeletePollLoading value)? deletePollLoading,
    TResult Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult Function(_DeletePollFailure value)? deletePollFailure,
    TResult Function(_UpdatePercentageState value)? updatePercentageState,
    required TResult orElse(),
  }) {
    if (deletePollSuccess != null) {
      return deletePollSuccess(this);
    }
    return orElse();
  }
}

abstract class _DeletePollSuccess implements PollState {
  const factory _DeletePollSuccess(final dynamic response) =
      _$DeletePollSuccessImpl;

  dynamic get response;
  @JsonKey(ignore: true)
  _$$DeletePollSuccessImplCopyWith<_$DeletePollSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeletePollFailureImplCopyWith<$Res> {
  factory _$$DeletePollFailureImplCopyWith(_$DeletePollFailureImpl value,
          $Res Function(_$DeletePollFailureImpl) then) =
      __$$DeletePollFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$DeletePollFailureImplCopyWithImpl<$Res>
    extends _$PollStateCopyWithImpl<$Res, _$DeletePollFailureImpl>
    implements _$$DeletePollFailureImplCopyWith<$Res> {
  __$$DeletePollFailureImplCopyWithImpl(_$DeletePollFailureImpl _value,
      $Res Function(_$DeletePollFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$DeletePollFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeletePollFailureImpl implements _DeletePollFailure {
  const _$DeletePollFailureImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PollState.deletePollFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePollFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletePollFailureImplCopyWith<_$DeletePollFailureImpl> get copyWith =>
      __$$DeletePollFailureImplCopyWithImpl<_$DeletePollFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchEFundsLoading,
    required TResult Function(dynamic response) fetchEFundsSuccess,
    required TResult Function(String error) fetchEFundsFailure,
    required TResult Function() selectPollLoading,
    required TResult Function(dynamic response) selectPollSuccess,
    required TResult Function(String error) selectPollFailure,
    required TResult Function() deletePollLoading,
    required TResult Function(dynamic response) deletePollSuccess,
    required TResult Function(String error) deletePollFailure,
    required TResult Function() updatePercentageState,
  }) {
    return deletePollFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchEFundsLoading,
    TResult? Function(dynamic response)? fetchEFundsSuccess,
    TResult? Function(String error)? fetchEFundsFailure,
    TResult? Function()? selectPollLoading,
    TResult? Function(dynamic response)? selectPollSuccess,
    TResult? Function(String error)? selectPollFailure,
    TResult? Function()? deletePollLoading,
    TResult? Function(dynamic response)? deletePollSuccess,
    TResult? Function(String error)? deletePollFailure,
    TResult? Function()? updatePercentageState,
  }) {
    return deletePollFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchEFundsLoading,
    TResult Function(dynamic response)? fetchEFundsSuccess,
    TResult Function(String error)? fetchEFundsFailure,
    TResult Function()? selectPollLoading,
    TResult Function(dynamic response)? selectPollSuccess,
    TResult Function(String error)? selectPollFailure,
    TResult Function()? deletePollLoading,
    TResult Function(dynamic response)? deletePollSuccess,
    TResult Function(String error)? deletePollFailure,
    TResult Function()? updatePercentageState,
    required TResult orElse(),
  }) {
    if (deletePollFailure != null) {
      return deletePollFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchEFundsLoading value) fetchEFundsLoading,
    required TResult Function(_FetchEFundsSuccess value) fetchEFundsSuccess,
    required TResult Function(_FetchEFundsFailure value) fetchEFundsFailure,
    required TResult Function(_SelectPollLoading value) selectPollLoading,
    required TResult Function(_SelectPollSuccess value) selectPollSuccess,
    required TResult Function(_SelectPollFailure value) selectPollFailure,
    required TResult Function(_DeletePollLoading value) deletePollLoading,
    required TResult Function(_DeletePollSuccess value) deletePollSuccess,
    required TResult Function(_DeletePollFailure value) deletePollFailure,
    required TResult Function(_UpdatePercentageState value)
        updatePercentageState,
  }) {
    return deletePollFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult? Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult? Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult? Function(_SelectPollLoading value)? selectPollLoading,
    TResult? Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult? Function(_SelectPollFailure value)? selectPollFailure,
    TResult? Function(_DeletePollLoading value)? deletePollLoading,
    TResult? Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult? Function(_DeletePollFailure value)? deletePollFailure,
    TResult? Function(_UpdatePercentageState value)? updatePercentageState,
  }) {
    return deletePollFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult Function(_SelectPollLoading value)? selectPollLoading,
    TResult Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult Function(_SelectPollFailure value)? selectPollFailure,
    TResult Function(_DeletePollLoading value)? deletePollLoading,
    TResult Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult Function(_DeletePollFailure value)? deletePollFailure,
    TResult Function(_UpdatePercentageState value)? updatePercentageState,
    required TResult orElse(),
  }) {
    if (deletePollFailure != null) {
      return deletePollFailure(this);
    }
    return orElse();
  }
}

abstract class _DeletePollFailure implements PollState {
  const factory _DeletePollFailure(final String error) =
      _$DeletePollFailureImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$DeletePollFailureImplCopyWith<_$DeletePollFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdatePercentageStateImplCopyWith<$Res> {
  factory _$$UpdatePercentageStateImplCopyWith(
          _$UpdatePercentageStateImpl value,
          $Res Function(_$UpdatePercentageStateImpl) then) =
      __$$UpdatePercentageStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdatePercentageStateImplCopyWithImpl<$Res>
    extends _$PollStateCopyWithImpl<$Res, _$UpdatePercentageStateImpl>
    implements _$$UpdatePercentageStateImplCopyWith<$Res> {
  __$$UpdatePercentageStateImplCopyWithImpl(_$UpdatePercentageStateImpl _value,
      $Res Function(_$UpdatePercentageStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UpdatePercentageStateImpl implements _UpdatePercentageState {
  const _$UpdatePercentageStateImpl();

  @override
  String toString() {
    return 'PollState.updatePercentageState()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePercentageStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchEFundsLoading,
    required TResult Function(dynamic response) fetchEFundsSuccess,
    required TResult Function(String error) fetchEFundsFailure,
    required TResult Function() selectPollLoading,
    required TResult Function(dynamic response) selectPollSuccess,
    required TResult Function(String error) selectPollFailure,
    required TResult Function() deletePollLoading,
    required TResult Function(dynamic response) deletePollSuccess,
    required TResult Function(String error) deletePollFailure,
    required TResult Function() updatePercentageState,
  }) {
    return updatePercentageState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchEFundsLoading,
    TResult? Function(dynamic response)? fetchEFundsSuccess,
    TResult? Function(String error)? fetchEFundsFailure,
    TResult? Function()? selectPollLoading,
    TResult? Function(dynamic response)? selectPollSuccess,
    TResult? Function(String error)? selectPollFailure,
    TResult? Function()? deletePollLoading,
    TResult? Function(dynamic response)? deletePollSuccess,
    TResult? Function(String error)? deletePollFailure,
    TResult? Function()? updatePercentageState,
  }) {
    return updatePercentageState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchEFundsLoading,
    TResult Function(dynamic response)? fetchEFundsSuccess,
    TResult Function(String error)? fetchEFundsFailure,
    TResult Function()? selectPollLoading,
    TResult Function(dynamic response)? selectPollSuccess,
    TResult Function(String error)? selectPollFailure,
    TResult Function()? deletePollLoading,
    TResult Function(dynamic response)? deletePollSuccess,
    TResult Function(String error)? deletePollFailure,
    TResult Function()? updatePercentageState,
    required TResult orElse(),
  }) {
    if (updatePercentageState != null) {
      return updatePercentageState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchEFundsLoading value) fetchEFundsLoading,
    required TResult Function(_FetchEFundsSuccess value) fetchEFundsSuccess,
    required TResult Function(_FetchEFundsFailure value) fetchEFundsFailure,
    required TResult Function(_SelectPollLoading value) selectPollLoading,
    required TResult Function(_SelectPollSuccess value) selectPollSuccess,
    required TResult Function(_SelectPollFailure value) selectPollFailure,
    required TResult Function(_DeletePollLoading value) deletePollLoading,
    required TResult Function(_DeletePollSuccess value) deletePollSuccess,
    required TResult Function(_DeletePollFailure value) deletePollFailure,
    required TResult Function(_UpdatePercentageState value)
        updatePercentageState,
  }) {
    return updatePercentageState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult? Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult? Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult? Function(_SelectPollLoading value)? selectPollLoading,
    TResult? Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult? Function(_SelectPollFailure value)? selectPollFailure,
    TResult? Function(_DeletePollLoading value)? deletePollLoading,
    TResult? Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult? Function(_DeletePollFailure value)? deletePollFailure,
    TResult? Function(_UpdatePercentageState value)? updatePercentageState,
  }) {
    return updatePercentageState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchEFundsLoading value)? fetchEFundsLoading,
    TResult Function(_FetchEFundsSuccess value)? fetchEFundsSuccess,
    TResult Function(_FetchEFundsFailure value)? fetchEFundsFailure,
    TResult Function(_SelectPollLoading value)? selectPollLoading,
    TResult Function(_SelectPollSuccess value)? selectPollSuccess,
    TResult Function(_SelectPollFailure value)? selectPollFailure,
    TResult Function(_DeletePollLoading value)? deletePollLoading,
    TResult Function(_DeletePollSuccess value)? deletePollSuccess,
    TResult Function(_DeletePollFailure value)? deletePollFailure,
    TResult Function(_UpdatePercentageState value)? updatePercentageState,
    required TResult orElse(),
  }) {
    if (updatePercentageState != null) {
      return updatePercentageState(this);
    }
    return orElse();
  }
}

abstract class _UpdatePercentageState implements PollState {
  const factory _UpdatePercentageState() = _$UpdatePercentageStateImpl;
}
