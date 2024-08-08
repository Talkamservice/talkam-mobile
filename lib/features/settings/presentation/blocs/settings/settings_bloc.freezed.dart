// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SettingsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool? refresh) fetchNotificationPreferences,
    required TResult Function(UpdateSettingsPayload preferences)
        saveNotificationPreferences,
    required TResult Function() fetchBlockedUsers,
    required TResult Function(String provider) linkSocialAccount,
    required TResult Function(String accountId) unlinkSocialAccount,
    required TResult Function(String? reason) deleteAccount,
    required TResult Function(String userId) blockUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool? refresh)? fetchNotificationPreferences,
    TResult? Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult? Function()? fetchBlockedUsers,
    TResult? Function(String provider)? linkSocialAccount,
    TResult? Function(String accountId)? unlinkSocialAccount,
    TResult? Function(String? reason)? deleteAccount,
    TResult? Function(String userId)? blockUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool? refresh)? fetchNotificationPreferences,
    TResult Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult Function()? fetchBlockedUsers,
    TResult Function(String provider)? linkSocialAccount,
    TResult Function(String accountId)? unlinkSocialAccount,
    TResult Function(String? reason)? deleteAccount,
    TResult Function(String userId)? blockUser,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchNotificationPreferences value)
        fetchNotificationPreferences,
    required TResult Function(_SaveNotificationPreferences value)
        saveNotificationPreferences,
    required TResult Function(_FetchBlockedUsers value) fetchBlockedUsers,
    required TResult Function(_LinkSocialAccount value) linkSocialAccount,
    required TResult Function(_UnlinkSocialAccount value) unlinkSocialAccount,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_BlockUser value) blockUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult? Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult? Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult? Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult? Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_BlockUser value)? blockUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_BlockUser value)? blockUser,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsEventCopyWith<$Res> {
  factory $SettingsEventCopyWith(
          SettingsEvent value, $Res Function(SettingsEvent) then) =
      _$SettingsEventCopyWithImpl<$Res, SettingsEvent>;
}

/// @nodoc
class _$SettingsEventCopyWithImpl<$Res, $Val extends SettingsEvent>
    implements $SettingsEventCopyWith<$Res> {
  _$SettingsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'SettingsEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool? refresh) fetchNotificationPreferences,
    required TResult Function(UpdateSettingsPayload preferences)
        saveNotificationPreferences,
    required TResult Function() fetchBlockedUsers,
    required TResult Function(String provider) linkSocialAccount,
    required TResult Function(String accountId) unlinkSocialAccount,
    required TResult Function(String? reason) deleteAccount,
    required TResult Function(String userId) blockUser,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool? refresh)? fetchNotificationPreferences,
    TResult? Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult? Function()? fetchBlockedUsers,
    TResult? Function(String provider)? linkSocialAccount,
    TResult? Function(String accountId)? unlinkSocialAccount,
    TResult? Function(String? reason)? deleteAccount,
    TResult? Function(String userId)? blockUser,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool? refresh)? fetchNotificationPreferences,
    TResult Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult Function()? fetchBlockedUsers,
    TResult Function(String provider)? linkSocialAccount,
    TResult Function(String accountId)? unlinkSocialAccount,
    TResult Function(String? reason)? deleteAccount,
    TResult Function(String userId)? blockUser,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchNotificationPreferences value)
        fetchNotificationPreferences,
    required TResult Function(_SaveNotificationPreferences value)
        saveNotificationPreferences,
    required TResult Function(_FetchBlockedUsers value) fetchBlockedUsers,
    required TResult Function(_LinkSocialAccount value) linkSocialAccount,
    required TResult Function(_UnlinkSocialAccount value) unlinkSocialAccount,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_BlockUser value) blockUser,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult? Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult? Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult? Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult? Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_BlockUser value)? blockUser,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_BlockUser value)? blockUser,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements SettingsEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$FetchNotificationPreferencesImplCopyWith<$Res> {
  factory _$$FetchNotificationPreferencesImplCopyWith(
          _$FetchNotificationPreferencesImpl value,
          $Res Function(_$FetchNotificationPreferencesImpl) then) =
      __$$FetchNotificationPreferencesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool? refresh});
}

/// @nodoc
class __$$FetchNotificationPreferencesImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res,
        _$FetchNotificationPreferencesImpl>
    implements _$$FetchNotificationPreferencesImplCopyWith<$Res> {
  __$$FetchNotificationPreferencesImplCopyWithImpl(
      _$FetchNotificationPreferencesImpl _value,
      $Res Function(_$FetchNotificationPreferencesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refresh = freezed,
  }) {
    return _then(_$FetchNotificationPreferencesImpl(
      refresh: freezed == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$FetchNotificationPreferencesImpl
    implements _FetchNotificationPreferences {
  const _$FetchNotificationPreferencesImpl({this.refresh});

  @override
  final bool? refresh;

  @override
  String toString() {
    return 'SettingsEvent.fetchNotificationPreferences(refresh: $refresh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchNotificationPreferencesImpl &&
            (identical(other.refresh, refresh) || other.refresh == refresh));
  }

  @override
  int get hashCode => Object.hash(runtimeType, refresh);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchNotificationPreferencesImplCopyWith<
          _$FetchNotificationPreferencesImpl>
      get copyWith => __$$FetchNotificationPreferencesImplCopyWithImpl<
          _$FetchNotificationPreferencesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool? refresh) fetchNotificationPreferences,
    required TResult Function(UpdateSettingsPayload preferences)
        saveNotificationPreferences,
    required TResult Function() fetchBlockedUsers,
    required TResult Function(String provider) linkSocialAccount,
    required TResult Function(String accountId) unlinkSocialAccount,
    required TResult Function(String? reason) deleteAccount,
    required TResult Function(String userId) blockUser,
  }) {
    return fetchNotificationPreferences(refresh);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool? refresh)? fetchNotificationPreferences,
    TResult? Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult? Function()? fetchBlockedUsers,
    TResult? Function(String provider)? linkSocialAccount,
    TResult? Function(String accountId)? unlinkSocialAccount,
    TResult? Function(String? reason)? deleteAccount,
    TResult? Function(String userId)? blockUser,
  }) {
    return fetchNotificationPreferences?.call(refresh);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool? refresh)? fetchNotificationPreferences,
    TResult Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult Function()? fetchBlockedUsers,
    TResult Function(String provider)? linkSocialAccount,
    TResult Function(String accountId)? unlinkSocialAccount,
    TResult Function(String? reason)? deleteAccount,
    TResult Function(String userId)? blockUser,
    required TResult orElse(),
  }) {
    if (fetchNotificationPreferences != null) {
      return fetchNotificationPreferences(refresh);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchNotificationPreferences value)
        fetchNotificationPreferences,
    required TResult Function(_SaveNotificationPreferences value)
        saveNotificationPreferences,
    required TResult Function(_FetchBlockedUsers value) fetchBlockedUsers,
    required TResult Function(_LinkSocialAccount value) linkSocialAccount,
    required TResult Function(_UnlinkSocialAccount value) unlinkSocialAccount,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_BlockUser value) blockUser,
  }) {
    return fetchNotificationPreferences(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult? Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult? Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult? Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult? Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_BlockUser value)? blockUser,
  }) {
    return fetchNotificationPreferences?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_BlockUser value)? blockUser,
    required TResult orElse(),
  }) {
    if (fetchNotificationPreferences != null) {
      return fetchNotificationPreferences(this);
    }
    return orElse();
  }
}

abstract class _FetchNotificationPreferences implements SettingsEvent {
  const factory _FetchNotificationPreferences({final bool? refresh}) =
      _$FetchNotificationPreferencesImpl;

  bool? get refresh;
  @JsonKey(ignore: true)
  _$$FetchNotificationPreferencesImplCopyWith<
          _$FetchNotificationPreferencesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveNotificationPreferencesImplCopyWith<$Res> {
  factory _$$SaveNotificationPreferencesImplCopyWith(
          _$SaveNotificationPreferencesImpl value,
          $Res Function(_$SaveNotificationPreferencesImpl) then) =
      __$$SaveNotificationPreferencesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UpdateSettingsPayload preferences});
}

/// @nodoc
class __$$SaveNotificationPreferencesImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$SaveNotificationPreferencesImpl>
    implements _$$SaveNotificationPreferencesImplCopyWith<$Res> {
  __$$SaveNotificationPreferencesImplCopyWithImpl(
      _$SaveNotificationPreferencesImpl _value,
      $Res Function(_$SaveNotificationPreferencesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferences = null,
  }) {
    return _then(_$SaveNotificationPreferencesImpl(
      null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as UpdateSettingsPayload,
    ));
  }
}

/// @nodoc

class _$SaveNotificationPreferencesImpl
    implements _SaveNotificationPreferences {
  const _$SaveNotificationPreferencesImpl(this.preferences);

  @override
  final UpdateSettingsPayload preferences;

  @override
  String toString() {
    return 'SettingsEvent.saveNotificationPreferences(preferences: $preferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveNotificationPreferencesImpl &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences));
  }

  @override
  int get hashCode => Object.hash(runtimeType, preferences);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveNotificationPreferencesImplCopyWith<_$SaveNotificationPreferencesImpl>
      get copyWith => __$$SaveNotificationPreferencesImplCopyWithImpl<
          _$SaveNotificationPreferencesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool? refresh) fetchNotificationPreferences,
    required TResult Function(UpdateSettingsPayload preferences)
        saveNotificationPreferences,
    required TResult Function() fetchBlockedUsers,
    required TResult Function(String provider) linkSocialAccount,
    required TResult Function(String accountId) unlinkSocialAccount,
    required TResult Function(String? reason) deleteAccount,
    required TResult Function(String userId) blockUser,
  }) {
    return saveNotificationPreferences(preferences);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool? refresh)? fetchNotificationPreferences,
    TResult? Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult? Function()? fetchBlockedUsers,
    TResult? Function(String provider)? linkSocialAccount,
    TResult? Function(String accountId)? unlinkSocialAccount,
    TResult? Function(String? reason)? deleteAccount,
    TResult? Function(String userId)? blockUser,
  }) {
    return saveNotificationPreferences?.call(preferences);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool? refresh)? fetchNotificationPreferences,
    TResult Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult Function()? fetchBlockedUsers,
    TResult Function(String provider)? linkSocialAccount,
    TResult Function(String accountId)? unlinkSocialAccount,
    TResult Function(String? reason)? deleteAccount,
    TResult Function(String userId)? blockUser,
    required TResult orElse(),
  }) {
    if (saveNotificationPreferences != null) {
      return saveNotificationPreferences(preferences);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchNotificationPreferences value)
        fetchNotificationPreferences,
    required TResult Function(_SaveNotificationPreferences value)
        saveNotificationPreferences,
    required TResult Function(_FetchBlockedUsers value) fetchBlockedUsers,
    required TResult Function(_LinkSocialAccount value) linkSocialAccount,
    required TResult Function(_UnlinkSocialAccount value) unlinkSocialAccount,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_BlockUser value) blockUser,
  }) {
    return saveNotificationPreferences(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult? Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult? Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult? Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult? Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_BlockUser value)? blockUser,
  }) {
    return saveNotificationPreferences?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_BlockUser value)? blockUser,
    required TResult orElse(),
  }) {
    if (saveNotificationPreferences != null) {
      return saveNotificationPreferences(this);
    }
    return orElse();
  }
}

abstract class _SaveNotificationPreferences implements SettingsEvent {
  const factory _SaveNotificationPreferences(
          final UpdateSettingsPayload preferences) =
      _$SaveNotificationPreferencesImpl;

  UpdateSettingsPayload get preferences;
  @JsonKey(ignore: true)
  _$$SaveNotificationPreferencesImplCopyWith<_$SaveNotificationPreferencesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchBlockedUsersImplCopyWith<$Res> {
  factory _$$FetchBlockedUsersImplCopyWith(_$FetchBlockedUsersImpl value,
          $Res Function(_$FetchBlockedUsersImpl) then) =
      __$$FetchBlockedUsersImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchBlockedUsersImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$FetchBlockedUsersImpl>
    implements _$$FetchBlockedUsersImplCopyWith<$Res> {
  __$$FetchBlockedUsersImplCopyWithImpl(_$FetchBlockedUsersImpl _value,
      $Res Function(_$FetchBlockedUsersImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FetchBlockedUsersImpl implements _FetchBlockedUsers {
  const _$FetchBlockedUsersImpl();

  @override
  String toString() {
    return 'SettingsEvent.fetchBlockedUsers()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FetchBlockedUsersImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool? refresh) fetchNotificationPreferences,
    required TResult Function(UpdateSettingsPayload preferences)
        saveNotificationPreferences,
    required TResult Function() fetchBlockedUsers,
    required TResult Function(String provider) linkSocialAccount,
    required TResult Function(String accountId) unlinkSocialAccount,
    required TResult Function(String? reason) deleteAccount,
    required TResult Function(String userId) blockUser,
  }) {
    return fetchBlockedUsers();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool? refresh)? fetchNotificationPreferences,
    TResult? Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult? Function()? fetchBlockedUsers,
    TResult? Function(String provider)? linkSocialAccount,
    TResult? Function(String accountId)? unlinkSocialAccount,
    TResult? Function(String? reason)? deleteAccount,
    TResult? Function(String userId)? blockUser,
  }) {
    return fetchBlockedUsers?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool? refresh)? fetchNotificationPreferences,
    TResult Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult Function()? fetchBlockedUsers,
    TResult Function(String provider)? linkSocialAccount,
    TResult Function(String accountId)? unlinkSocialAccount,
    TResult Function(String? reason)? deleteAccount,
    TResult Function(String userId)? blockUser,
    required TResult orElse(),
  }) {
    if (fetchBlockedUsers != null) {
      return fetchBlockedUsers();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchNotificationPreferences value)
        fetchNotificationPreferences,
    required TResult Function(_SaveNotificationPreferences value)
        saveNotificationPreferences,
    required TResult Function(_FetchBlockedUsers value) fetchBlockedUsers,
    required TResult Function(_LinkSocialAccount value) linkSocialAccount,
    required TResult Function(_UnlinkSocialAccount value) unlinkSocialAccount,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_BlockUser value) blockUser,
  }) {
    return fetchBlockedUsers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult? Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult? Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult? Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult? Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_BlockUser value)? blockUser,
  }) {
    return fetchBlockedUsers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_BlockUser value)? blockUser,
    required TResult orElse(),
  }) {
    if (fetchBlockedUsers != null) {
      return fetchBlockedUsers(this);
    }
    return orElse();
  }
}

abstract class _FetchBlockedUsers implements SettingsEvent {
  const factory _FetchBlockedUsers() = _$FetchBlockedUsersImpl;
}

/// @nodoc
abstract class _$$LinkSocialAccountImplCopyWith<$Res> {
  factory _$$LinkSocialAccountImplCopyWith(_$LinkSocialAccountImpl value,
          $Res Function(_$LinkSocialAccountImpl) then) =
      __$$LinkSocialAccountImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String provider});
}

/// @nodoc
class __$$LinkSocialAccountImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$LinkSocialAccountImpl>
    implements _$$LinkSocialAccountImplCopyWith<$Res> {
  __$$LinkSocialAccountImplCopyWithImpl(_$LinkSocialAccountImpl _value,
      $Res Function(_$LinkSocialAccountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
  }) {
    return _then(_$LinkSocialAccountImpl(
      null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LinkSocialAccountImpl implements _LinkSocialAccount {
  const _$LinkSocialAccountImpl(this.provider);

  @override
  final String provider;

  @override
  String toString() {
    return 'SettingsEvent.linkSocialAccount(provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkSocialAccountImpl &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @override
  int get hashCode => Object.hash(runtimeType, provider);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkSocialAccountImplCopyWith<_$LinkSocialAccountImpl> get copyWith =>
      __$$LinkSocialAccountImplCopyWithImpl<_$LinkSocialAccountImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool? refresh) fetchNotificationPreferences,
    required TResult Function(UpdateSettingsPayload preferences)
        saveNotificationPreferences,
    required TResult Function() fetchBlockedUsers,
    required TResult Function(String provider) linkSocialAccount,
    required TResult Function(String accountId) unlinkSocialAccount,
    required TResult Function(String? reason) deleteAccount,
    required TResult Function(String userId) blockUser,
  }) {
    return linkSocialAccount(provider);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool? refresh)? fetchNotificationPreferences,
    TResult? Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult? Function()? fetchBlockedUsers,
    TResult? Function(String provider)? linkSocialAccount,
    TResult? Function(String accountId)? unlinkSocialAccount,
    TResult? Function(String? reason)? deleteAccount,
    TResult? Function(String userId)? blockUser,
  }) {
    return linkSocialAccount?.call(provider);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool? refresh)? fetchNotificationPreferences,
    TResult Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult Function()? fetchBlockedUsers,
    TResult Function(String provider)? linkSocialAccount,
    TResult Function(String accountId)? unlinkSocialAccount,
    TResult Function(String? reason)? deleteAccount,
    TResult Function(String userId)? blockUser,
    required TResult orElse(),
  }) {
    if (linkSocialAccount != null) {
      return linkSocialAccount(provider);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchNotificationPreferences value)
        fetchNotificationPreferences,
    required TResult Function(_SaveNotificationPreferences value)
        saveNotificationPreferences,
    required TResult Function(_FetchBlockedUsers value) fetchBlockedUsers,
    required TResult Function(_LinkSocialAccount value) linkSocialAccount,
    required TResult Function(_UnlinkSocialAccount value) unlinkSocialAccount,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_BlockUser value) blockUser,
  }) {
    return linkSocialAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult? Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult? Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult? Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult? Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_BlockUser value)? blockUser,
  }) {
    return linkSocialAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_BlockUser value)? blockUser,
    required TResult orElse(),
  }) {
    if (linkSocialAccount != null) {
      return linkSocialAccount(this);
    }
    return orElse();
  }
}

abstract class _LinkSocialAccount implements SettingsEvent {
  const factory _LinkSocialAccount(final String provider) =
      _$LinkSocialAccountImpl;

  String get provider;
  @JsonKey(ignore: true)
  _$$LinkSocialAccountImplCopyWith<_$LinkSocialAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnlinkSocialAccountImplCopyWith<$Res> {
  factory _$$UnlinkSocialAccountImplCopyWith(_$UnlinkSocialAccountImpl value,
          $Res Function(_$UnlinkSocialAccountImpl) then) =
      __$$UnlinkSocialAccountImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String accountId});
}

/// @nodoc
class __$$UnlinkSocialAccountImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UnlinkSocialAccountImpl>
    implements _$$UnlinkSocialAccountImplCopyWith<$Res> {
  __$$UnlinkSocialAccountImplCopyWithImpl(_$UnlinkSocialAccountImpl _value,
      $Res Function(_$UnlinkSocialAccountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
  }) {
    return _then(_$UnlinkSocialAccountImpl(
      null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UnlinkSocialAccountImpl implements _UnlinkSocialAccount {
  const _$UnlinkSocialAccountImpl(this.accountId);

  @override
  final String accountId;

  @override
  String toString() {
    return 'SettingsEvent.unlinkSocialAccount(accountId: $accountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnlinkSocialAccountImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnlinkSocialAccountImplCopyWith<_$UnlinkSocialAccountImpl> get copyWith =>
      __$$UnlinkSocialAccountImplCopyWithImpl<_$UnlinkSocialAccountImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool? refresh) fetchNotificationPreferences,
    required TResult Function(UpdateSettingsPayload preferences)
        saveNotificationPreferences,
    required TResult Function() fetchBlockedUsers,
    required TResult Function(String provider) linkSocialAccount,
    required TResult Function(String accountId) unlinkSocialAccount,
    required TResult Function(String? reason) deleteAccount,
    required TResult Function(String userId) blockUser,
  }) {
    return unlinkSocialAccount(accountId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool? refresh)? fetchNotificationPreferences,
    TResult? Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult? Function()? fetchBlockedUsers,
    TResult? Function(String provider)? linkSocialAccount,
    TResult? Function(String accountId)? unlinkSocialAccount,
    TResult? Function(String? reason)? deleteAccount,
    TResult? Function(String userId)? blockUser,
  }) {
    return unlinkSocialAccount?.call(accountId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool? refresh)? fetchNotificationPreferences,
    TResult Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult Function()? fetchBlockedUsers,
    TResult Function(String provider)? linkSocialAccount,
    TResult Function(String accountId)? unlinkSocialAccount,
    TResult Function(String? reason)? deleteAccount,
    TResult Function(String userId)? blockUser,
    required TResult orElse(),
  }) {
    if (unlinkSocialAccount != null) {
      return unlinkSocialAccount(accountId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchNotificationPreferences value)
        fetchNotificationPreferences,
    required TResult Function(_SaveNotificationPreferences value)
        saveNotificationPreferences,
    required TResult Function(_FetchBlockedUsers value) fetchBlockedUsers,
    required TResult Function(_LinkSocialAccount value) linkSocialAccount,
    required TResult Function(_UnlinkSocialAccount value) unlinkSocialAccount,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_BlockUser value) blockUser,
  }) {
    return unlinkSocialAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult? Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult? Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult? Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult? Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_BlockUser value)? blockUser,
  }) {
    return unlinkSocialAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_BlockUser value)? blockUser,
    required TResult orElse(),
  }) {
    if (unlinkSocialAccount != null) {
      return unlinkSocialAccount(this);
    }
    return orElse();
  }
}

abstract class _UnlinkSocialAccount implements SettingsEvent {
  const factory _UnlinkSocialAccount(final String accountId) =
      _$UnlinkSocialAccountImpl;

  String get accountId;
  @JsonKey(ignore: true)
  _$$UnlinkSocialAccountImplCopyWith<_$UnlinkSocialAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteAccountImplCopyWith<$Res> {
  factory _$$DeleteAccountImplCopyWith(
          _$DeleteAccountImpl value, $Res Function(_$DeleteAccountImpl) then) =
      __$$DeleteAccountImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? reason});
}

/// @nodoc
class __$$DeleteAccountImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$DeleteAccountImpl>
    implements _$$DeleteAccountImplCopyWith<$Res> {
  __$$DeleteAccountImplCopyWithImpl(
      _$DeleteAccountImpl _value, $Res Function(_$DeleteAccountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = freezed,
  }) {
    return _then(_$DeleteAccountImpl(
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$DeleteAccountImpl implements _DeleteAccount {
  const _$DeleteAccountImpl({this.reason});

  @override
  final String? reason;

  @override
  String toString() {
    return 'SettingsEvent.deleteAccount(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteAccountImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteAccountImplCopyWith<_$DeleteAccountImpl> get copyWith =>
      __$$DeleteAccountImplCopyWithImpl<_$DeleteAccountImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool? refresh) fetchNotificationPreferences,
    required TResult Function(UpdateSettingsPayload preferences)
        saveNotificationPreferences,
    required TResult Function() fetchBlockedUsers,
    required TResult Function(String provider) linkSocialAccount,
    required TResult Function(String accountId) unlinkSocialAccount,
    required TResult Function(String? reason) deleteAccount,
    required TResult Function(String userId) blockUser,
  }) {
    return deleteAccount(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool? refresh)? fetchNotificationPreferences,
    TResult? Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult? Function()? fetchBlockedUsers,
    TResult? Function(String provider)? linkSocialAccount,
    TResult? Function(String accountId)? unlinkSocialAccount,
    TResult? Function(String? reason)? deleteAccount,
    TResult? Function(String userId)? blockUser,
  }) {
    return deleteAccount?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool? refresh)? fetchNotificationPreferences,
    TResult Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult Function()? fetchBlockedUsers,
    TResult Function(String provider)? linkSocialAccount,
    TResult Function(String accountId)? unlinkSocialAccount,
    TResult Function(String? reason)? deleteAccount,
    TResult Function(String userId)? blockUser,
    required TResult orElse(),
  }) {
    if (deleteAccount != null) {
      return deleteAccount(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchNotificationPreferences value)
        fetchNotificationPreferences,
    required TResult Function(_SaveNotificationPreferences value)
        saveNotificationPreferences,
    required TResult Function(_FetchBlockedUsers value) fetchBlockedUsers,
    required TResult Function(_LinkSocialAccount value) linkSocialAccount,
    required TResult Function(_UnlinkSocialAccount value) unlinkSocialAccount,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_BlockUser value) blockUser,
  }) {
    return deleteAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult? Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult? Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult? Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult? Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_BlockUser value)? blockUser,
  }) {
    return deleteAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_BlockUser value)? blockUser,
    required TResult orElse(),
  }) {
    if (deleteAccount != null) {
      return deleteAccount(this);
    }
    return orElse();
  }
}

abstract class _DeleteAccount implements SettingsEvent {
  const factory _DeleteAccount({final String? reason}) = _$DeleteAccountImpl;

  String? get reason;
  @JsonKey(ignore: true)
  _$$DeleteAccountImplCopyWith<_$DeleteAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BlockUserImplCopyWith<$Res> {
  factory _$$BlockUserImplCopyWith(
          _$BlockUserImpl value, $Res Function(_$BlockUserImpl) then) =
      __$$BlockUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$BlockUserImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$BlockUserImpl>
    implements _$$BlockUserImplCopyWith<$Res> {
  __$$BlockUserImplCopyWithImpl(
      _$BlockUserImpl _value, $Res Function(_$BlockUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$BlockUserImpl(
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BlockUserImpl implements _BlockUser {
  const _$BlockUserImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'SettingsEvent.blockUser(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockUserImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockUserImplCopyWith<_$BlockUserImpl> get copyWith =>
      __$$BlockUserImplCopyWithImpl<_$BlockUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(bool? refresh) fetchNotificationPreferences,
    required TResult Function(UpdateSettingsPayload preferences)
        saveNotificationPreferences,
    required TResult Function() fetchBlockedUsers,
    required TResult Function(String provider) linkSocialAccount,
    required TResult Function(String accountId) unlinkSocialAccount,
    required TResult Function(String? reason) deleteAccount,
    required TResult Function(String userId) blockUser,
  }) {
    return blockUser(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(bool? refresh)? fetchNotificationPreferences,
    TResult? Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult? Function()? fetchBlockedUsers,
    TResult? Function(String provider)? linkSocialAccount,
    TResult? Function(String accountId)? unlinkSocialAccount,
    TResult? Function(String? reason)? deleteAccount,
    TResult? Function(String userId)? blockUser,
  }) {
    return blockUser?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(bool? refresh)? fetchNotificationPreferences,
    TResult Function(UpdateSettingsPayload preferences)?
        saveNotificationPreferences,
    TResult Function()? fetchBlockedUsers,
    TResult Function(String provider)? linkSocialAccount,
    TResult Function(String accountId)? unlinkSocialAccount,
    TResult Function(String? reason)? deleteAccount,
    TResult Function(String userId)? blockUser,
    required TResult orElse(),
  }) {
    if (blockUser != null) {
      return blockUser(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchNotificationPreferences value)
        fetchNotificationPreferences,
    required TResult Function(_SaveNotificationPreferences value)
        saveNotificationPreferences,
    required TResult Function(_FetchBlockedUsers value) fetchBlockedUsers,
    required TResult Function(_LinkSocialAccount value) linkSocialAccount,
    required TResult Function(_UnlinkSocialAccount value) unlinkSocialAccount,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_BlockUser value) blockUser,
  }) {
    return blockUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult? Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult? Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult? Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult? Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_BlockUser value)? blockUser,
  }) {
    return blockUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchNotificationPreferences value)?
        fetchNotificationPreferences,
    TResult Function(_SaveNotificationPreferences value)?
        saveNotificationPreferences,
    TResult Function(_FetchBlockedUsers value)? fetchBlockedUsers,
    TResult Function(_LinkSocialAccount value)? linkSocialAccount,
    TResult Function(_UnlinkSocialAccount value)? unlinkSocialAccount,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_BlockUser value)? blockUser,
    required TResult orElse(),
  }) {
    if (blockUser != null) {
      return blockUser(this);
    }
    return orElse();
  }
}

abstract class _BlockUser implements SettingsEvent {
  const factory _BlockUser(final String userId) = _$BlockUserImpl;

  String get userId;
  @JsonKey(ignore: true)
  _$$BlockUserImplCopyWith<_$BlockUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SettingsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res, SettingsState>;
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

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
    extends _$SettingsStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'SettingsState.initial()';
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
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
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
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SettingsState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$FetchNotificationPreferencesLoadingImplCopyWith<$Res> {
  factory _$$FetchNotificationPreferencesLoadingImplCopyWith(
          _$FetchNotificationPreferencesLoadingImpl value,
          $Res Function(_$FetchNotificationPreferencesLoadingImpl) then) =
      __$$FetchNotificationPreferencesLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchNotificationPreferencesLoadingImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res,
        _$FetchNotificationPreferencesLoadingImpl>
    implements _$$FetchNotificationPreferencesLoadingImplCopyWith<$Res> {
  __$$FetchNotificationPreferencesLoadingImplCopyWithImpl(
      _$FetchNotificationPreferencesLoadingImpl _value,
      $Res Function(_$FetchNotificationPreferencesLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FetchNotificationPreferencesLoadingImpl
    implements _FetchNotificationPreferencesLoading {
  const _$FetchNotificationPreferencesLoadingImpl();

  @override
  String toString() {
    return 'SettingsState.fetchNotificationPreferencesLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchNotificationPreferencesLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return fetchNotificationPreferencesLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return fetchNotificationPreferencesLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (fetchNotificationPreferencesLoading != null) {
      return fetchNotificationPreferencesLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return fetchNotificationPreferencesLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return fetchNotificationPreferencesLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (fetchNotificationPreferencesLoading != null) {
      return fetchNotificationPreferencesLoading(this);
    }
    return orElse();
  }
}

abstract class _FetchNotificationPreferencesLoading implements SettingsState {
  const factory _FetchNotificationPreferencesLoading() =
      _$FetchNotificationPreferencesLoadingImpl;
}

/// @nodoc
abstract class _$$FetchNotificationPreferencesSuccessImplCopyWith<$Res> {
  factory _$$FetchNotificationPreferencesSuccessImplCopyWith(
          _$FetchNotificationPreferencesSuccessImpl value,
          $Res Function(_$FetchNotificationPreferencesSuccessImpl) then) =
      __$$FetchNotificationPreferencesSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NotificationsPreferenceResponse response});
}

/// @nodoc
class __$$FetchNotificationPreferencesSuccessImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res,
        _$FetchNotificationPreferencesSuccessImpl>
    implements _$$FetchNotificationPreferencesSuccessImplCopyWith<$Res> {
  __$$FetchNotificationPreferencesSuccessImplCopyWithImpl(
      _$FetchNotificationPreferencesSuccessImpl _value,
      $Res Function(_$FetchNotificationPreferencesSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$FetchNotificationPreferencesSuccessImpl(
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as NotificationsPreferenceResponse,
    ));
  }
}

/// @nodoc

class _$FetchNotificationPreferencesSuccessImpl
    implements _FetchNotificationPreferencesSuccess {
  const _$FetchNotificationPreferencesSuccessImpl(this.response);

  @override
  final NotificationsPreferenceResponse response;

  @override
  String toString() {
    return 'SettingsState.fetchNotificationPreferencesSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchNotificationPreferencesSuccessImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchNotificationPreferencesSuccessImplCopyWith<
          _$FetchNotificationPreferencesSuccessImpl>
      get copyWith => __$$FetchNotificationPreferencesSuccessImplCopyWithImpl<
          _$FetchNotificationPreferencesSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return fetchNotificationPreferencesSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return fetchNotificationPreferencesSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (fetchNotificationPreferencesSuccess != null) {
      return fetchNotificationPreferencesSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return fetchNotificationPreferencesSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return fetchNotificationPreferencesSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (fetchNotificationPreferencesSuccess != null) {
      return fetchNotificationPreferencesSuccess(this);
    }
    return orElse();
  }
}

abstract class _FetchNotificationPreferencesSuccess implements SettingsState {
  const factory _FetchNotificationPreferencesSuccess(
          final NotificationsPreferenceResponse response) =
      _$FetchNotificationPreferencesSuccessImpl;

  NotificationsPreferenceResponse get response;
  @JsonKey(ignore: true)
  _$$FetchNotificationPreferencesSuccessImplCopyWith<
          _$FetchNotificationPreferencesSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchNotificationPreferencesFailureImplCopyWith<$Res> {
  factory _$$FetchNotificationPreferencesFailureImplCopyWith(
          _$FetchNotificationPreferencesFailureImpl value,
          $Res Function(_$FetchNotificationPreferencesFailureImpl) then) =
      __$$FetchNotificationPreferencesFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$FetchNotificationPreferencesFailureImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res,
        _$FetchNotificationPreferencesFailureImpl>
    implements _$$FetchNotificationPreferencesFailureImplCopyWith<$Res> {
  __$$FetchNotificationPreferencesFailureImplCopyWithImpl(
      _$FetchNotificationPreferencesFailureImpl _value,
      $Res Function(_$FetchNotificationPreferencesFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$FetchNotificationPreferencesFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchNotificationPreferencesFailureImpl
    implements _FetchNotificationPreferencesFailure {
  const _$FetchNotificationPreferencesFailureImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'SettingsState.fetchNotificationPreferencesFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchNotificationPreferencesFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchNotificationPreferencesFailureImplCopyWith<
          _$FetchNotificationPreferencesFailureImpl>
      get copyWith => __$$FetchNotificationPreferencesFailureImplCopyWithImpl<
          _$FetchNotificationPreferencesFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return fetchNotificationPreferencesFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return fetchNotificationPreferencesFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (fetchNotificationPreferencesFailure != null) {
      return fetchNotificationPreferencesFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return fetchNotificationPreferencesFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return fetchNotificationPreferencesFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (fetchNotificationPreferencesFailure != null) {
      return fetchNotificationPreferencesFailure(this);
    }
    return orElse();
  }
}

abstract class _FetchNotificationPreferencesFailure implements SettingsState {
  const factory _FetchNotificationPreferencesFailure(final String error) =
      _$FetchNotificationPreferencesFailureImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$FetchNotificationPreferencesFailureImplCopyWith<
          _$FetchNotificationPreferencesFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveNotificationPreferencesLoadingImplCopyWith<$Res> {
  factory _$$SaveNotificationPreferencesLoadingImplCopyWith(
          _$SaveNotificationPreferencesLoadingImpl value,
          $Res Function(_$SaveNotificationPreferencesLoadingImpl) then) =
      __$$SaveNotificationPreferencesLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SaveNotificationPreferencesLoadingImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res,
        _$SaveNotificationPreferencesLoadingImpl>
    implements _$$SaveNotificationPreferencesLoadingImplCopyWith<$Res> {
  __$$SaveNotificationPreferencesLoadingImplCopyWithImpl(
      _$SaveNotificationPreferencesLoadingImpl _value,
      $Res Function(_$SaveNotificationPreferencesLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SaveNotificationPreferencesLoadingImpl
    implements _SaveNotificationPreferencesLoading {
  const _$SaveNotificationPreferencesLoadingImpl();

  @override
  String toString() {
    return 'SettingsState.saveNotificationPreferencesLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveNotificationPreferencesLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return saveNotificationPreferencesLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return saveNotificationPreferencesLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (saveNotificationPreferencesLoading != null) {
      return saveNotificationPreferencesLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return saveNotificationPreferencesLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return saveNotificationPreferencesLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (saveNotificationPreferencesLoading != null) {
      return saveNotificationPreferencesLoading(this);
    }
    return orElse();
  }
}

abstract class _SaveNotificationPreferencesLoading implements SettingsState {
  const factory _SaveNotificationPreferencesLoading() =
      _$SaveNotificationPreferencesLoadingImpl;
}

/// @nodoc
abstract class _$$SaveNotificationPreferencesSuccessImplCopyWith<$Res> {
  factory _$$SaveNotificationPreferencesSuccessImplCopyWith(
          _$SaveNotificationPreferencesSuccessImpl value,
          $Res Function(_$SaveNotificationPreferencesSuccessImpl) then) =
      __$$SaveNotificationPreferencesSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic response});
}

/// @nodoc
class __$$SaveNotificationPreferencesSuccessImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res,
        _$SaveNotificationPreferencesSuccessImpl>
    implements _$$SaveNotificationPreferencesSuccessImplCopyWith<$Res> {
  __$$SaveNotificationPreferencesSuccessImplCopyWithImpl(
      _$SaveNotificationPreferencesSuccessImpl _value,
      $Res Function(_$SaveNotificationPreferencesSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_$SaveNotificationPreferencesSuccessImpl(
      freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$SaveNotificationPreferencesSuccessImpl
    implements _SaveNotificationPreferencesSuccess {
  const _$SaveNotificationPreferencesSuccessImpl(this.response);

  @override
  final dynamic response;

  @override
  String toString() {
    return 'SettingsState.saveNotificationPreferencesSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveNotificationPreferencesSuccessImpl &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(response));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveNotificationPreferencesSuccessImplCopyWith<
          _$SaveNotificationPreferencesSuccessImpl>
      get copyWith => __$$SaveNotificationPreferencesSuccessImplCopyWithImpl<
          _$SaveNotificationPreferencesSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return saveNotificationPreferencesSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return saveNotificationPreferencesSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (saveNotificationPreferencesSuccess != null) {
      return saveNotificationPreferencesSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return saveNotificationPreferencesSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return saveNotificationPreferencesSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (saveNotificationPreferencesSuccess != null) {
      return saveNotificationPreferencesSuccess(this);
    }
    return orElse();
  }
}

abstract class _SaveNotificationPreferencesSuccess implements SettingsState {
  const factory _SaveNotificationPreferencesSuccess(final dynamic response) =
      _$SaveNotificationPreferencesSuccessImpl;

  dynamic get response;
  @JsonKey(ignore: true)
  _$$SaveNotificationPreferencesSuccessImplCopyWith<
          _$SaveNotificationPreferencesSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveNotificationPreferencesFailureImplCopyWith<$Res> {
  factory _$$SaveNotificationPreferencesFailureImplCopyWith(
          _$SaveNotificationPreferencesFailureImpl value,
          $Res Function(_$SaveNotificationPreferencesFailureImpl) then) =
      __$$SaveNotificationPreferencesFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$SaveNotificationPreferencesFailureImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res,
        _$SaveNotificationPreferencesFailureImpl>
    implements _$$SaveNotificationPreferencesFailureImplCopyWith<$Res> {
  __$$SaveNotificationPreferencesFailureImplCopyWithImpl(
      _$SaveNotificationPreferencesFailureImpl _value,
      $Res Function(_$SaveNotificationPreferencesFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$SaveNotificationPreferencesFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SaveNotificationPreferencesFailureImpl
    implements _SaveNotificationPreferencesFailure {
  const _$SaveNotificationPreferencesFailureImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'SettingsState.saveNotificationPreferencesFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveNotificationPreferencesFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveNotificationPreferencesFailureImplCopyWith<
          _$SaveNotificationPreferencesFailureImpl>
      get copyWith => __$$SaveNotificationPreferencesFailureImplCopyWithImpl<
          _$SaveNotificationPreferencesFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return saveNotificationPreferencesFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return saveNotificationPreferencesFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (saveNotificationPreferencesFailure != null) {
      return saveNotificationPreferencesFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return saveNotificationPreferencesFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return saveNotificationPreferencesFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (saveNotificationPreferencesFailure != null) {
      return saveNotificationPreferencesFailure(this);
    }
    return orElse();
  }
}

abstract class _SaveNotificationPreferencesFailure implements SettingsState {
  const factory _SaveNotificationPreferencesFailure(final String error) =
      _$SaveNotificationPreferencesFailureImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$SaveNotificationPreferencesFailureImplCopyWith<
          _$SaveNotificationPreferencesFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchBlockedUsersLoadingImplCopyWith<$Res> {
  factory _$$FetchBlockedUsersLoadingImplCopyWith(
          _$FetchBlockedUsersLoadingImpl value,
          $Res Function(_$FetchBlockedUsersLoadingImpl) then) =
      __$$FetchBlockedUsersLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchBlockedUsersLoadingImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$FetchBlockedUsersLoadingImpl>
    implements _$$FetchBlockedUsersLoadingImplCopyWith<$Res> {
  __$$FetchBlockedUsersLoadingImplCopyWithImpl(
      _$FetchBlockedUsersLoadingImpl _value,
      $Res Function(_$FetchBlockedUsersLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FetchBlockedUsersLoadingImpl implements _FetchBlockedUsersLoading {
  const _$FetchBlockedUsersLoadingImpl();

  @override
  String toString() {
    return 'SettingsState.fetchBlockedUsersLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchBlockedUsersLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return fetchBlockedUsersLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return fetchBlockedUsersLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (fetchBlockedUsersLoading != null) {
      return fetchBlockedUsersLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return fetchBlockedUsersLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return fetchBlockedUsersLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (fetchBlockedUsersLoading != null) {
      return fetchBlockedUsersLoading(this);
    }
    return orElse();
  }
}

abstract class _FetchBlockedUsersLoading implements SettingsState {
  const factory _FetchBlockedUsersLoading() = _$FetchBlockedUsersLoadingImpl;
}

/// @nodoc
abstract class _$$FetchBlockedUsersSuccessImplCopyWith<$Res> {
  factory _$$FetchBlockedUsersSuccessImplCopyWith(
          _$FetchBlockedUsersSuccessImpl value,
          $Res Function(_$FetchBlockedUsersSuccessImpl) then) =
      __$$FetchBlockedUsersSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BlockedUsersResponse response});
}

/// @nodoc
class __$$FetchBlockedUsersSuccessImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$FetchBlockedUsersSuccessImpl>
    implements _$$FetchBlockedUsersSuccessImplCopyWith<$Res> {
  __$$FetchBlockedUsersSuccessImplCopyWithImpl(
      _$FetchBlockedUsersSuccessImpl _value,
      $Res Function(_$FetchBlockedUsersSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$FetchBlockedUsersSuccessImpl(
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as BlockedUsersResponse,
    ));
  }
}

/// @nodoc

class _$FetchBlockedUsersSuccessImpl implements _FetchBlockedUsersSuccess {
  const _$FetchBlockedUsersSuccessImpl(this.response);

  @override
  final BlockedUsersResponse response;

  @override
  String toString() {
    return 'SettingsState.fetchBlockedUsersSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchBlockedUsersSuccessImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchBlockedUsersSuccessImplCopyWith<_$FetchBlockedUsersSuccessImpl>
      get copyWith => __$$FetchBlockedUsersSuccessImplCopyWithImpl<
          _$FetchBlockedUsersSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return fetchBlockedUsersSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return fetchBlockedUsersSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (fetchBlockedUsersSuccess != null) {
      return fetchBlockedUsersSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return fetchBlockedUsersSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return fetchBlockedUsersSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (fetchBlockedUsersSuccess != null) {
      return fetchBlockedUsersSuccess(this);
    }
    return orElse();
  }
}

abstract class _FetchBlockedUsersSuccess implements SettingsState {
  const factory _FetchBlockedUsersSuccess(final BlockedUsersResponse response) =
      _$FetchBlockedUsersSuccessImpl;

  BlockedUsersResponse get response;
  @JsonKey(ignore: true)
  _$$FetchBlockedUsersSuccessImplCopyWith<_$FetchBlockedUsersSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchBlockedUsersFailureImplCopyWith<$Res> {
  factory _$$FetchBlockedUsersFailureImplCopyWith(
          _$FetchBlockedUsersFailureImpl value,
          $Res Function(_$FetchBlockedUsersFailureImpl) then) =
      __$$FetchBlockedUsersFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$FetchBlockedUsersFailureImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$FetchBlockedUsersFailureImpl>
    implements _$$FetchBlockedUsersFailureImplCopyWith<$Res> {
  __$$FetchBlockedUsersFailureImplCopyWithImpl(
      _$FetchBlockedUsersFailureImpl _value,
      $Res Function(_$FetchBlockedUsersFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$FetchBlockedUsersFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchBlockedUsersFailureImpl implements _FetchBlockedUsersFailure {
  const _$FetchBlockedUsersFailureImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'SettingsState.fetchBlockedUsersFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchBlockedUsersFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchBlockedUsersFailureImplCopyWith<_$FetchBlockedUsersFailureImpl>
      get copyWith => __$$FetchBlockedUsersFailureImplCopyWithImpl<
          _$FetchBlockedUsersFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return fetchBlockedUsersFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return fetchBlockedUsersFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (fetchBlockedUsersFailure != null) {
      return fetchBlockedUsersFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return fetchBlockedUsersFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return fetchBlockedUsersFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (fetchBlockedUsersFailure != null) {
      return fetchBlockedUsersFailure(this);
    }
    return orElse();
  }
}

abstract class _FetchBlockedUsersFailure implements SettingsState {
  const factory _FetchBlockedUsersFailure(final String error) =
      _$FetchBlockedUsersFailureImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$FetchBlockedUsersFailureImplCopyWith<_$FetchBlockedUsersFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LinkSocialAccountLoadingImplCopyWith<$Res> {
  factory _$$LinkSocialAccountLoadingImplCopyWith(
          _$LinkSocialAccountLoadingImpl value,
          $Res Function(_$LinkSocialAccountLoadingImpl) then) =
      __$$LinkSocialAccountLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LinkSocialAccountLoadingImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$LinkSocialAccountLoadingImpl>
    implements _$$LinkSocialAccountLoadingImplCopyWith<$Res> {
  __$$LinkSocialAccountLoadingImplCopyWithImpl(
      _$LinkSocialAccountLoadingImpl _value,
      $Res Function(_$LinkSocialAccountLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LinkSocialAccountLoadingImpl implements _LinkSocialAccountLoading {
  const _$LinkSocialAccountLoadingImpl();

  @override
  String toString() {
    return 'SettingsState.linkSocialAccountLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkSocialAccountLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return linkSocialAccountLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return linkSocialAccountLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (linkSocialAccountLoading != null) {
      return linkSocialAccountLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return linkSocialAccountLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return linkSocialAccountLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (linkSocialAccountLoading != null) {
      return linkSocialAccountLoading(this);
    }
    return orElse();
  }
}

abstract class _LinkSocialAccountLoading implements SettingsState {
  const factory _LinkSocialAccountLoading() = _$LinkSocialAccountLoadingImpl;
}

/// @nodoc
abstract class _$$LinkSocialAccountSuccessImplCopyWith<$Res> {
  factory _$$LinkSocialAccountSuccessImplCopyWith(
          _$LinkSocialAccountSuccessImpl value,
          $Res Function(_$LinkSocialAccountSuccessImpl) then) =
      __$$LinkSocialAccountSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic response});
}

/// @nodoc
class __$$LinkSocialAccountSuccessImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$LinkSocialAccountSuccessImpl>
    implements _$$LinkSocialAccountSuccessImplCopyWith<$Res> {
  __$$LinkSocialAccountSuccessImplCopyWithImpl(
      _$LinkSocialAccountSuccessImpl _value,
      $Res Function(_$LinkSocialAccountSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_$LinkSocialAccountSuccessImpl(
      freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$LinkSocialAccountSuccessImpl implements _LinkSocialAccountSuccess {
  const _$LinkSocialAccountSuccessImpl(this.response);

  @override
  final dynamic response;

  @override
  String toString() {
    return 'SettingsState.linkSocialAccountSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkSocialAccountSuccessImpl &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(response));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkSocialAccountSuccessImplCopyWith<_$LinkSocialAccountSuccessImpl>
      get copyWith => __$$LinkSocialAccountSuccessImplCopyWithImpl<
          _$LinkSocialAccountSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return linkSocialAccountSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return linkSocialAccountSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (linkSocialAccountSuccess != null) {
      return linkSocialAccountSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return linkSocialAccountSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return linkSocialAccountSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (linkSocialAccountSuccess != null) {
      return linkSocialAccountSuccess(this);
    }
    return orElse();
  }
}

abstract class _LinkSocialAccountSuccess implements SettingsState {
  const factory _LinkSocialAccountSuccess(final dynamic response) =
      _$LinkSocialAccountSuccessImpl;

  dynamic get response;
  @JsonKey(ignore: true)
  _$$LinkSocialAccountSuccessImplCopyWith<_$LinkSocialAccountSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LinkSocialAccountFailureImplCopyWith<$Res> {
  factory _$$LinkSocialAccountFailureImplCopyWith(
          _$LinkSocialAccountFailureImpl value,
          $Res Function(_$LinkSocialAccountFailureImpl) then) =
      __$$LinkSocialAccountFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$LinkSocialAccountFailureImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$LinkSocialAccountFailureImpl>
    implements _$$LinkSocialAccountFailureImplCopyWith<$Res> {
  __$$LinkSocialAccountFailureImplCopyWithImpl(
      _$LinkSocialAccountFailureImpl _value,
      $Res Function(_$LinkSocialAccountFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$LinkSocialAccountFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LinkSocialAccountFailureImpl implements _LinkSocialAccountFailure {
  const _$LinkSocialAccountFailureImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'SettingsState.linkSocialAccountFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkSocialAccountFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkSocialAccountFailureImplCopyWith<_$LinkSocialAccountFailureImpl>
      get copyWith => __$$LinkSocialAccountFailureImplCopyWithImpl<
          _$LinkSocialAccountFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return linkSocialAccountFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return linkSocialAccountFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (linkSocialAccountFailure != null) {
      return linkSocialAccountFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return linkSocialAccountFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return linkSocialAccountFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (linkSocialAccountFailure != null) {
      return linkSocialAccountFailure(this);
    }
    return orElse();
  }
}

abstract class _LinkSocialAccountFailure implements SettingsState {
  const factory _LinkSocialAccountFailure(final String error) =
      _$LinkSocialAccountFailureImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$LinkSocialAccountFailureImplCopyWith<_$LinkSocialAccountFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnlinkSocialAccountLoadingImplCopyWith<$Res> {
  factory _$$UnlinkSocialAccountLoadingImplCopyWith(
          _$UnlinkSocialAccountLoadingImpl value,
          $Res Function(_$UnlinkSocialAccountLoadingImpl) then) =
      __$$UnlinkSocialAccountLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnlinkSocialAccountLoadingImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$UnlinkSocialAccountLoadingImpl>
    implements _$$UnlinkSocialAccountLoadingImplCopyWith<$Res> {
  __$$UnlinkSocialAccountLoadingImplCopyWithImpl(
      _$UnlinkSocialAccountLoadingImpl _value,
      $Res Function(_$UnlinkSocialAccountLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UnlinkSocialAccountLoadingImpl implements _UnlinkSocialAccountLoading {
  const _$UnlinkSocialAccountLoadingImpl();

  @override
  String toString() {
    return 'SettingsState.unlinkSocialAccountLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnlinkSocialAccountLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return unlinkSocialAccountLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return unlinkSocialAccountLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (unlinkSocialAccountLoading != null) {
      return unlinkSocialAccountLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return unlinkSocialAccountLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return unlinkSocialAccountLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (unlinkSocialAccountLoading != null) {
      return unlinkSocialAccountLoading(this);
    }
    return orElse();
  }
}

abstract class _UnlinkSocialAccountLoading implements SettingsState {
  const factory _UnlinkSocialAccountLoading() =
      _$UnlinkSocialAccountLoadingImpl;
}

/// @nodoc
abstract class _$$UnlinkSocialAccountSuccessImplCopyWith<$Res> {
  factory _$$UnlinkSocialAccountSuccessImplCopyWith(
          _$UnlinkSocialAccountSuccessImpl value,
          $Res Function(_$UnlinkSocialAccountSuccessImpl) then) =
      __$$UnlinkSocialAccountSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic response});
}

/// @nodoc
class __$$UnlinkSocialAccountSuccessImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$UnlinkSocialAccountSuccessImpl>
    implements _$$UnlinkSocialAccountSuccessImplCopyWith<$Res> {
  __$$UnlinkSocialAccountSuccessImplCopyWithImpl(
      _$UnlinkSocialAccountSuccessImpl _value,
      $Res Function(_$UnlinkSocialAccountSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_$UnlinkSocialAccountSuccessImpl(
      freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$UnlinkSocialAccountSuccessImpl implements _UnlinkSocialAccountSuccess {
  const _$UnlinkSocialAccountSuccessImpl(this.response);

  @override
  final dynamic response;

  @override
  String toString() {
    return 'SettingsState.unlinkSocialAccountSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnlinkSocialAccountSuccessImpl &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(response));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnlinkSocialAccountSuccessImplCopyWith<_$UnlinkSocialAccountSuccessImpl>
      get copyWith => __$$UnlinkSocialAccountSuccessImplCopyWithImpl<
          _$UnlinkSocialAccountSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return unlinkSocialAccountSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return unlinkSocialAccountSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (unlinkSocialAccountSuccess != null) {
      return unlinkSocialAccountSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return unlinkSocialAccountSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return unlinkSocialAccountSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (unlinkSocialAccountSuccess != null) {
      return unlinkSocialAccountSuccess(this);
    }
    return orElse();
  }
}

abstract class _UnlinkSocialAccountSuccess implements SettingsState {
  const factory _UnlinkSocialAccountSuccess(final dynamic response) =
      _$UnlinkSocialAccountSuccessImpl;

  dynamic get response;
  @JsonKey(ignore: true)
  _$$UnlinkSocialAccountSuccessImplCopyWith<_$UnlinkSocialAccountSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnlinkSocialAccountFailureImplCopyWith<$Res> {
  factory _$$UnlinkSocialAccountFailureImplCopyWith(
          _$UnlinkSocialAccountFailureImpl value,
          $Res Function(_$UnlinkSocialAccountFailureImpl) then) =
      __$$UnlinkSocialAccountFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$UnlinkSocialAccountFailureImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$UnlinkSocialAccountFailureImpl>
    implements _$$UnlinkSocialAccountFailureImplCopyWith<$Res> {
  __$$UnlinkSocialAccountFailureImplCopyWithImpl(
      _$UnlinkSocialAccountFailureImpl _value,
      $Res Function(_$UnlinkSocialAccountFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$UnlinkSocialAccountFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UnlinkSocialAccountFailureImpl implements _UnlinkSocialAccountFailure {
  const _$UnlinkSocialAccountFailureImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'SettingsState.unlinkSocialAccountFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnlinkSocialAccountFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnlinkSocialAccountFailureImplCopyWith<_$UnlinkSocialAccountFailureImpl>
      get copyWith => __$$UnlinkSocialAccountFailureImplCopyWithImpl<
          _$UnlinkSocialAccountFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return unlinkSocialAccountFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return unlinkSocialAccountFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (unlinkSocialAccountFailure != null) {
      return unlinkSocialAccountFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return unlinkSocialAccountFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return unlinkSocialAccountFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (unlinkSocialAccountFailure != null) {
      return unlinkSocialAccountFailure(this);
    }
    return orElse();
  }
}

abstract class _UnlinkSocialAccountFailure implements SettingsState {
  const factory _UnlinkSocialAccountFailure(final String error) =
      _$UnlinkSocialAccountFailureImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$UnlinkSocialAccountFailureImplCopyWith<_$UnlinkSocialAccountFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteAccountLoadingImplCopyWith<$Res> {
  factory _$$DeleteAccountLoadingImplCopyWith(_$DeleteAccountLoadingImpl value,
          $Res Function(_$DeleteAccountLoadingImpl) then) =
      __$$DeleteAccountLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeleteAccountLoadingImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$DeleteAccountLoadingImpl>
    implements _$$DeleteAccountLoadingImplCopyWith<$Res> {
  __$$DeleteAccountLoadingImplCopyWithImpl(_$DeleteAccountLoadingImpl _value,
      $Res Function(_$DeleteAccountLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DeleteAccountLoadingImpl implements _DeleteAccountLoading {
  const _$DeleteAccountLoadingImpl();

  @override
  String toString() {
    return 'SettingsState.deleteAccountLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteAccountLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return deleteAccountLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return deleteAccountLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (deleteAccountLoading != null) {
      return deleteAccountLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return deleteAccountLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return deleteAccountLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (deleteAccountLoading != null) {
      return deleteAccountLoading(this);
    }
    return orElse();
  }
}

abstract class _DeleteAccountLoading implements SettingsState {
  const factory _DeleteAccountLoading() = _$DeleteAccountLoadingImpl;
}

/// @nodoc
abstract class _$$DeleteAccountSuccessImplCopyWith<$Res> {
  factory _$$DeleteAccountSuccessImplCopyWith(_$DeleteAccountSuccessImpl value,
          $Res Function(_$DeleteAccountSuccessImpl) then) =
      __$$DeleteAccountSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic response});
}

/// @nodoc
class __$$DeleteAccountSuccessImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$DeleteAccountSuccessImpl>
    implements _$$DeleteAccountSuccessImplCopyWith<$Res> {
  __$$DeleteAccountSuccessImplCopyWithImpl(_$DeleteAccountSuccessImpl _value,
      $Res Function(_$DeleteAccountSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_$DeleteAccountSuccessImpl(
      freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$DeleteAccountSuccessImpl implements _DeleteAccountSuccess {
  const _$DeleteAccountSuccessImpl(this.response);

  @override
  final dynamic response;

  @override
  String toString() {
    return 'SettingsState.deleteAccountSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteAccountSuccessImpl &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(response));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteAccountSuccessImplCopyWith<_$DeleteAccountSuccessImpl>
      get copyWith =>
          __$$DeleteAccountSuccessImplCopyWithImpl<_$DeleteAccountSuccessImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return deleteAccountSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return deleteAccountSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (deleteAccountSuccess != null) {
      return deleteAccountSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return deleteAccountSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return deleteAccountSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (deleteAccountSuccess != null) {
      return deleteAccountSuccess(this);
    }
    return orElse();
  }
}

abstract class _DeleteAccountSuccess implements SettingsState {
  const factory _DeleteAccountSuccess(final dynamic response) =
      _$DeleteAccountSuccessImpl;

  dynamic get response;
  @JsonKey(ignore: true)
  _$$DeleteAccountSuccessImplCopyWith<_$DeleteAccountSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteAccountFailureImplCopyWith<$Res> {
  factory _$$DeleteAccountFailureImplCopyWith(_$DeleteAccountFailureImpl value,
          $Res Function(_$DeleteAccountFailureImpl) then) =
      __$$DeleteAccountFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$DeleteAccountFailureImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$DeleteAccountFailureImpl>
    implements _$$DeleteAccountFailureImplCopyWith<$Res> {
  __$$DeleteAccountFailureImplCopyWithImpl(_$DeleteAccountFailureImpl _value,
      $Res Function(_$DeleteAccountFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$DeleteAccountFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteAccountFailureImpl implements _DeleteAccountFailure {
  const _$DeleteAccountFailureImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'SettingsState.deleteAccountFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteAccountFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteAccountFailureImplCopyWith<_$DeleteAccountFailureImpl>
      get copyWith =>
          __$$DeleteAccountFailureImplCopyWithImpl<_$DeleteAccountFailureImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return deleteAccountFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return deleteAccountFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (deleteAccountFailure != null) {
      return deleteAccountFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return deleteAccountFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return deleteAccountFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (deleteAccountFailure != null) {
      return deleteAccountFailure(this);
    }
    return orElse();
  }
}

abstract class _DeleteAccountFailure implements SettingsState {
  const factory _DeleteAccountFailure(final String error) =
      _$DeleteAccountFailureImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$DeleteAccountFailureImplCopyWith<_$DeleteAccountFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BlockUserLoadingImplCopyWith<$Res> {
  factory _$$BlockUserLoadingImplCopyWith(_$BlockUserLoadingImpl value,
          $Res Function(_$BlockUserLoadingImpl) then) =
      __$$BlockUserLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BlockUserLoadingImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$BlockUserLoadingImpl>
    implements _$$BlockUserLoadingImplCopyWith<$Res> {
  __$$BlockUserLoadingImplCopyWithImpl(_$BlockUserLoadingImpl _value,
      $Res Function(_$BlockUserLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BlockUserLoadingImpl implements _BlockUserLoading {
  const _$BlockUserLoadingImpl();

  @override
  String toString() {
    return 'SettingsState.blockUserLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BlockUserLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return blockUserLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return blockUserLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (blockUserLoading != null) {
      return blockUserLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return blockUserLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return blockUserLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (blockUserLoading != null) {
      return blockUserLoading(this);
    }
    return orElse();
  }
}

abstract class _BlockUserLoading implements SettingsState {
  const factory _BlockUserLoading() = _$BlockUserLoadingImpl;
}

/// @nodoc
abstract class _$$BlockUserSuccessImplCopyWith<$Res> {
  factory _$$BlockUserSuccessImplCopyWith(_$BlockUserSuccessImpl value,
          $Res Function(_$BlockUserSuccessImpl) then) =
      __$$BlockUserSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic response});
}

/// @nodoc
class __$$BlockUserSuccessImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$BlockUserSuccessImpl>
    implements _$$BlockUserSuccessImplCopyWith<$Res> {
  __$$BlockUserSuccessImplCopyWithImpl(_$BlockUserSuccessImpl _value,
      $Res Function(_$BlockUserSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_$BlockUserSuccessImpl(
      freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$BlockUserSuccessImpl implements _BlockUserSuccess {
  const _$BlockUserSuccessImpl(this.response);

  @override
  final dynamic response;

  @override
  String toString() {
    return 'SettingsState.blockUserSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockUserSuccessImpl &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(response));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockUserSuccessImplCopyWith<_$BlockUserSuccessImpl> get copyWith =>
      __$$BlockUserSuccessImplCopyWithImpl<_$BlockUserSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return blockUserSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return blockUserSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (blockUserSuccess != null) {
      return blockUserSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return blockUserSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return blockUserSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (blockUserSuccess != null) {
      return blockUserSuccess(this);
    }
    return orElse();
  }
}

abstract class _BlockUserSuccess implements SettingsState {
  const factory _BlockUserSuccess(final dynamic response) =
      _$BlockUserSuccessImpl;

  dynamic get response;
  @JsonKey(ignore: true)
  _$$BlockUserSuccessImplCopyWith<_$BlockUserSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BlockUserFailureImplCopyWith<$Res> {
  factory _$$BlockUserFailureImplCopyWith(_$BlockUserFailureImpl value,
          $Res Function(_$BlockUserFailureImpl) then) =
      __$$BlockUserFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$BlockUserFailureImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$BlockUserFailureImpl>
    implements _$$BlockUserFailureImplCopyWith<$Res> {
  __$$BlockUserFailureImplCopyWithImpl(_$BlockUserFailureImpl _value,
      $Res Function(_$BlockUserFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$BlockUserFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BlockUserFailureImpl implements _BlockUserFailure {
  const _$BlockUserFailureImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'SettingsState.blockUserFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockUserFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockUserFailureImplCopyWith<_$BlockUserFailureImpl> get copyWith =>
      __$$BlockUserFailureImplCopyWithImpl<_$BlockUserFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchNotificationPreferencesLoading,
    required TResult Function(NotificationsPreferenceResponse response)
        fetchNotificationPreferencesSuccess,
    required TResult Function(String error) fetchNotificationPreferencesFailure,
    required TResult Function() saveNotificationPreferencesLoading,
    required TResult Function(dynamic response)
        saveNotificationPreferencesSuccess,
    required TResult Function(String error) saveNotificationPreferencesFailure,
    required TResult Function() fetchBlockedUsersLoading,
    required TResult Function(BlockedUsersResponse response)
        fetchBlockedUsersSuccess,
    required TResult Function(String error) fetchBlockedUsersFailure,
    required TResult Function() linkSocialAccountLoading,
    required TResult Function(dynamic response) linkSocialAccountSuccess,
    required TResult Function(String error) linkSocialAccountFailure,
    required TResult Function() unlinkSocialAccountLoading,
    required TResult Function(dynamic response) unlinkSocialAccountSuccess,
    required TResult Function(String error) unlinkSocialAccountFailure,
    required TResult Function() deleteAccountLoading,
    required TResult Function(dynamic response) deleteAccountSuccess,
    required TResult Function(String error) deleteAccountFailure,
    required TResult Function() blockUserLoading,
    required TResult Function(dynamic response) blockUserSuccess,
    required TResult Function(String error) blockUserFailure,
  }) {
    return blockUserFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? fetchNotificationPreferencesLoading,
    TResult? Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(String error)? fetchNotificationPreferencesFailure,
    TResult? Function()? saveNotificationPreferencesLoading,
    TResult? Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult? Function(String error)? saveNotificationPreferencesFailure,
    TResult? Function()? fetchBlockedUsersLoading,
    TResult? Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult? Function(String error)? fetchBlockedUsersFailure,
    TResult? Function()? linkSocialAccountLoading,
    TResult? Function(dynamic response)? linkSocialAccountSuccess,
    TResult? Function(String error)? linkSocialAccountFailure,
    TResult? Function()? unlinkSocialAccountLoading,
    TResult? Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult? Function(String error)? unlinkSocialAccountFailure,
    TResult? Function()? deleteAccountLoading,
    TResult? Function(dynamic response)? deleteAccountSuccess,
    TResult? Function(String error)? deleteAccountFailure,
    TResult? Function()? blockUserLoading,
    TResult? Function(dynamic response)? blockUserSuccess,
    TResult? Function(String error)? blockUserFailure,
  }) {
    return blockUserFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchNotificationPreferencesLoading,
    TResult Function(NotificationsPreferenceResponse response)?
        fetchNotificationPreferencesSuccess,
    TResult Function(String error)? fetchNotificationPreferencesFailure,
    TResult Function()? saveNotificationPreferencesLoading,
    TResult Function(dynamic response)? saveNotificationPreferencesSuccess,
    TResult Function(String error)? saveNotificationPreferencesFailure,
    TResult Function()? fetchBlockedUsersLoading,
    TResult Function(BlockedUsersResponse response)? fetchBlockedUsersSuccess,
    TResult Function(String error)? fetchBlockedUsersFailure,
    TResult Function()? linkSocialAccountLoading,
    TResult Function(dynamic response)? linkSocialAccountSuccess,
    TResult Function(String error)? linkSocialAccountFailure,
    TResult Function()? unlinkSocialAccountLoading,
    TResult Function(dynamic response)? unlinkSocialAccountSuccess,
    TResult Function(String error)? unlinkSocialAccountFailure,
    TResult Function()? deleteAccountLoading,
    TResult Function(dynamic response)? deleteAccountSuccess,
    TResult Function(String error)? deleteAccountFailure,
    TResult Function()? blockUserLoading,
    TResult Function(dynamic response)? blockUserSuccess,
    TResult Function(String error)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (blockUserFailure != null) {
      return blockUserFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchNotificationPreferencesLoading value)
        fetchNotificationPreferencesLoading,
    required TResult Function(_FetchNotificationPreferencesSuccess value)
        fetchNotificationPreferencesSuccess,
    required TResult Function(_FetchNotificationPreferencesFailure value)
        fetchNotificationPreferencesFailure,
    required TResult Function(_SaveNotificationPreferencesLoading value)
        saveNotificationPreferencesLoading,
    required TResult Function(_SaveNotificationPreferencesSuccess value)
        saveNotificationPreferencesSuccess,
    required TResult Function(_SaveNotificationPreferencesFailure value)
        saveNotificationPreferencesFailure,
    required TResult Function(_FetchBlockedUsersLoading value)
        fetchBlockedUsersLoading,
    required TResult Function(_FetchBlockedUsersSuccess value)
        fetchBlockedUsersSuccess,
    required TResult Function(_FetchBlockedUsersFailure value)
        fetchBlockedUsersFailure,
    required TResult Function(_LinkSocialAccountLoading value)
        linkSocialAccountLoading,
    required TResult Function(_LinkSocialAccountSuccess value)
        linkSocialAccountSuccess,
    required TResult Function(_LinkSocialAccountFailure value)
        linkSocialAccountFailure,
    required TResult Function(_UnlinkSocialAccountLoading value)
        unlinkSocialAccountLoading,
    required TResult Function(_UnlinkSocialAccountSuccess value)
        unlinkSocialAccountSuccess,
    required TResult Function(_UnlinkSocialAccountFailure value)
        unlinkSocialAccountFailure,
    required TResult Function(_DeleteAccountLoading value) deleteAccountLoading,
    required TResult Function(_DeleteAccountSuccess value) deleteAccountSuccess,
    required TResult Function(_DeleteAccountFailure value) deleteAccountFailure,
    required TResult Function(_BlockUserLoading value) blockUserLoading,
    required TResult Function(_BlockUserSuccess value) blockUserSuccess,
    required TResult Function(_BlockUserFailure value) blockUserFailure,
  }) {
    return blockUserFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult? Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult? Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult? Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult? Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult? Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult? Function(_FetchBlockedUsersLoading value)?
        fetchBlockedUsersLoading,
    TResult? Function(_FetchBlockedUsersSuccess value)?
        fetchBlockedUsersSuccess,
    TResult? Function(_FetchBlockedUsersFailure value)?
        fetchBlockedUsersFailure,
    TResult? Function(_LinkSocialAccountLoading value)?
        linkSocialAccountLoading,
    TResult? Function(_LinkSocialAccountSuccess value)?
        linkSocialAccountSuccess,
    TResult? Function(_LinkSocialAccountFailure value)?
        linkSocialAccountFailure,
    TResult? Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult? Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult? Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult? Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult? Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult? Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult? Function(_BlockUserLoading value)? blockUserLoading,
    TResult? Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult? Function(_BlockUserFailure value)? blockUserFailure,
  }) {
    return blockUserFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchNotificationPreferencesLoading value)?
        fetchNotificationPreferencesLoading,
    TResult Function(_FetchNotificationPreferencesSuccess value)?
        fetchNotificationPreferencesSuccess,
    TResult Function(_FetchNotificationPreferencesFailure value)?
        fetchNotificationPreferencesFailure,
    TResult Function(_SaveNotificationPreferencesLoading value)?
        saveNotificationPreferencesLoading,
    TResult Function(_SaveNotificationPreferencesSuccess value)?
        saveNotificationPreferencesSuccess,
    TResult Function(_SaveNotificationPreferencesFailure value)?
        saveNotificationPreferencesFailure,
    TResult Function(_FetchBlockedUsersLoading value)? fetchBlockedUsersLoading,
    TResult Function(_FetchBlockedUsersSuccess value)? fetchBlockedUsersSuccess,
    TResult Function(_FetchBlockedUsersFailure value)? fetchBlockedUsersFailure,
    TResult Function(_LinkSocialAccountLoading value)? linkSocialAccountLoading,
    TResult Function(_LinkSocialAccountSuccess value)? linkSocialAccountSuccess,
    TResult Function(_LinkSocialAccountFailure value)? linkSocialAccountFailure,
    TResult Function(_UnlinkSocialAccountLoading value)?
        unlinkSocialAccountLoading,
    TResult Function(_UnlinkSocialAccountSuccess value)?
        unlinkSocialAccountSuccess,
    TResult Function(_UnlinkSocialAccountFailure value)?
        unlinkSocialAccountFailure,
    TResult Function(_DeleteAccountLoading value)? deleteAccountLoading,
    TResult Function(_DeleteAccountSuccess value)? deleteAccountSuccess,
    TResult Function(_DeleteAccountFailure value)? deleteAccountFailure,
    TResult Function(_BlockUserLoading value)? blockUserLoading,
    TResult Function(_BlockUserSuccess value)? blockUserSuccess,
    TResult Function(_BlockUserFailure value)? blockUserFailure,
    required TResult orElse(),
  }) {
    if (blockUserFailure != null) {
      return blockUserFailure(this);
    }
    return orElse();
  }
}

abstract class _BlockUserFailure implements SettingsState {
  const factory _BlockUserFailure(final String error) = _$BlockUserFailureImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$BlockUserFailureImplCopyWith<_$BlockUserFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
