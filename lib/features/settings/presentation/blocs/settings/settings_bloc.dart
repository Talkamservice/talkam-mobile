// settings_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/authentication/data/models/oauth_req_dto.dart';
import 'package:talkam/features/authentication/dormain/repository/auth_repository.dart';
import 'package:talkam/features/settings/data/models/blocked_users_response.dart';
import 'package:talkam/features/settings/data/models/data_export_status.dart';
import 'package:talkam/features/settings/data/models/notification_preference_response.dart';
import 'package:talkam/features/settings/data/models/notification_preferences.dart';
import 'package:talkam/features/settings/data/models/payment_method.dart';
import 'package:talkam/features/settings/data/models/privacy_settings.dart';
import 'package:talkam/features/settings/data/models/update_settings_payload.dart';
import 'package:talkam/features/settings/dormain/repository/settings_repoitory.dart';

part 'settings_event.dart';

part 'settings_state.dart';

part 'settings_bloc.freezed.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;
  final AuthRepository _authRepository;

  SettingsBloc(this._settingsRepository, this._authRepository)
      : super(const SettingsState.initial()) {
    on<SettingsEvent>((event, emit) async {
      await event.map(
        fetchNotificationPreferences: (e) async =>
            await _mapFetchNotificationPreferencesToState(emit, e.refresh),
        saveNotificationPreferences: (e) async =>
            await _mapSaveNotificationPreferencesToState(e.preferences, emit),
        fetchBlockedUsers: (e) async =>
            await _mapFetchBlockedUsersToState(emit),
        linkSocialAccount: (e) async =>
            await _mapLinkSocialAccountToState(e.provider, emit),
        unlinkSocialAccount: (e) async =>
            await _mapUnlinkSocialAccountToState(e.accountId, emit),
        deleteAccount: (e) async =>
            await _mapDeleteAccountToState(emit, e.reason),
        blockUser: (e) async => await _mapBlockUserToState(e.userId, emit),
        started: (_Started value) {},
        getNotificationPreferencesV2: (e) async =>
            await _mapGetNotificationPreferencesV2ToState(emit),
        updateNotificationPreferencesV2: (e) async =>
            await _mapUpdateNotificationPreferencesV2ToState(
                e.preferences, emit),
        getPrivacySettings: (e) async =>
            await _mapGetPrivacySettingsToState(emit),
        updatePrivacySettings: (e) async =>
            await _mapUpdatePrivacySettingsToState(e.settings, emit,
                otp: e.otp),
        getPaymentMethods: (e) async =>
            await _mapGetPaymentMethodsToState(emit),
        deletePaymentMethod: (e) async =>
            await _mapDeletePaymentMethodToState(e.id, emit),
        setPaymentPin: (e) async => await _mapSetPaymentPinToState(emit,
            pin: e.pin, currentPin: e.currentPin, otp: e.otp),
        requestDataExport: (e) async =>
            await _mapRequestDataExportToState(emit),
        getDataExportStatus: (e) async =>
            await _mapGetDataExportStatusToState(emit),
      );
    });
  }

  Future<void> _mapFetchNotificationPreferencesToState(
      Emitter<SettingsState> emit, bool? refresh) async {
    if (refresh ?? true) {
      emit(const SettingsState.fetchNotificationPreferencesLoading());
    }

    try {
      var response = await _settingsRepository.fetchNotificationPreferences();

      emit(SettingsState.fetchNotificationPreferencesSuccess(response));
    } catch (e, stack) {
      logger.w(e, stackTrace: stack);
      emit(SettingsState.fetchNotificationPreferencesFailure(e.toString()));
    }
  }

  Future<void> _mapSaveNotificationPreferencesToState(
      UpdateSettingsPayload preferences, Emitter<SettingsState> emit) async {
    emit(const SettingsState.saveNotificationPreferencesLoading());
    try {
      var response =
          await _settingsRepository.saveNotificationPreferences(preferences);
      emit(SettingsState.saveNotificationPreferencesSuccess(response));
    } catch (e) {
      emit(SettingsState.saveNotificationPreferencesFailure(e.toString()));
    }
  }

  Future<void> _mapFetchBlockedUsersToState(Emitter<SettingsState> emit) async {
    emit(const SettingsState.fetchBlockedUsersLoading());
    try {
      var response = await _settingsRepository.fetchBlockedUsers();
      emit(SettingsState.fetchBlockedUsersSuccess(response));
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      emit(SettingsState.fetchBlockedUsersFailure(e.toString()));
    }
  }

  Future<void> _mapLinkSocialAccountToState(
      String provider, Emitter<SettingsState> emit) async {
    emit(const SettingsState.linkSocialAccountLoading());
    switch (provider) {
      case "google":
        await _handleLinkGoogleAccount(emit);
        return;
      case "apple":
        await _handleLinkAppleAccount(emit);
        return;
      case "facebook":
        await _handleLinkFacebookAccount(emit);
        return;
    }
  }

  Future<void> _mapUnlinkSocialAccountToState(
      String accountId, Emitter<SettingsState> emit) async {
    emit(const SettingsState.unlinkSocialAccountLoading());
    try {
      var response = await _settingsRepository.unlinkSocialAccount(accountId);
      emit(SettingsState.unlinkSocialAccountSuccess(response));
    } catch (e) {
      emit(SettingsState.unlinkSocialAccountFailure(e.toString()));
    }
  }

  Future<void> _mapDeleteAccountToState(
      Emitter<SettingsState> emit, String? reason) async {
    emit(const SettingsState.deleteAccountLoading());
    try {
      var response = await _settingsRepository.deleteAccount(reason: reason);
      emit(SettingsState.deleteAccountSuccess(response));
    } catch (e) {
      emit(SettingsState.deleteAccountFailure(e.toString()));
    }
  }

  Future<void> _mapBlockUserToState(
      String userId, Emitter<SettingsState> emit) async {
    emit(const SettingsState.blockUserLoading());
    try {
      var response = await _settingsRepository.blockUser(userId);
      emit(SettingsState.blockUserSuccess(response));
    } catch (e) {
      emit(SettingsState.blockUserFailure(e.toString()));
    }
  }

  Future _handleLinkGoogleAccount(Emitter<SettingsState> emit) async {
    try {
      final response = await _authRepository.googleAuth();

      if (response == null) {
        emit(const SettingsState.linkSocialAccountFailure(
            "Google Authentication canceled"));
        return;
      }
      var res = await _settingsRepository.linkSocialAccount(OauthReqDto(
        token: response.accessToken,
        provider: 'google',
      ));

      emit(SettingsState.linkSocialAccountSuccess(res));
    } catch (e) {
      emit(SettingsState.linkSocialAccountFailure(e.toString()));
    }
  }

  Future _handleLinkAppleAccount(Emitter<SettingsState> emit) async {
    try {
      final response = await _authRepository.appleAuth();

      if (response == null) {
        emit(const SettingsState.linkSocialAccountFailure(
            "Apple Authentication canceled"));
        return;
      }
      var res = await _settingsRepository.linkSocialAccount(OauthReqDto(
        token: response.identityToken,
        provider: 'apple',
      ));

      emit(SettingsState.linkSocialAccountSuccess(res));
    } catch (e) {
      emit(SettingsState.linkSocialAccountFailure(e.toString()));
    }
  }

  Future _handleLinkFacebookAccount(Emitter<SettingsState> emit) async {
    try {
      final response = await _authRepository.facebookAuth();

      if (response == null) {
        emit(const SettingsState.linkSocialAccountFailure(
            "Facebook Authentication canceled"));
        return;
      }
      var res = await _settingsRepository.linkSocialAccount(OauthReqDto(
        token: response.tokenString,
        provider: 'facebook',
      ));

      emit(SettingsState.linkSocialAccountSuccess(res));
    } catch (e) {
      emit(SettingsState.linkSocialAccountFailure(e.toString()));
    }
  }

  // ── v2 ────────────────────────────────────────────────────────────────

  Future<void> _mapGetNotificationPreferencesV2ToState(
      Emitter<SettingsState> emit) async {
    emit(const SettingsState.getNotificationPreferencesV2Loading());
    try {
      final prefs = await _settingsRepository.getNotificationPreferences();
      emit(SettingsState.getNotificationPreferencesV2Success(prefs));
    } catch (e) {
      emit(SettingsState.getNotificationPreferencesV2Failure(e.toString()));
    }
  }

  Future<void> _mapUpdateNotificationPreferencesV2ToState(
      NotificationPreferences preferences, Emitter<SettingsState> emit) async {
    emit(const SettingsState.updateNotificationPreferencesV2Loading());
    try {
      final prefs =
          await _settingsRepository.updateNotificationPreferences(preferences);
      emit(SettingsState.updateNotificationPreferencesV2Success(prefs));
    } catch (e) {
      emit(SettingsState.updateNotificationPreferencesV2Failure(e.toString()));
    }
  }

  Future<void> _mapGetPrivacySettingsToState(
      Emitter<SettingsState> emit) async {
    emit(const SettingsState.getPrivacySettingsLoading());
    try {
      final settings = await _settingsRepository.getPrivacySettings();
      emit(SettingsState.getPrivacySettingsSuccess(settings));
    } catch (e) {
      emit(SettingsState.getPrivacySettingsFailure(e.toString()));
    }
  }

  Future<void> _mapUpdatePrivacySettingsToState(
      PrivacySettings settings, Emitter<SettingsState> emit,
      {String? otp}) async {
    emit(const SettingsState.updatePrivacySettingsLoading());
    try {
      final updated =
          await _settingsRepository.updatePrivacySettings(settings, otp: otp);
      emit(SettingsState.updatePrivacySettingsSuccess(updated));
    } catch (e) {
      emit(SettingsState.updatePrivacySettingsFailure(e.toString()));
    }
  }

  Future<void> _mapGetPaymentMethodsToState(Emitter<SettingsState> emit) async {
    emit(const SettingsState.getPaymentMethodsLoading());
    try {
      final methods = await _settingsRepository.getPaymentMethods();
      emit(SettingsState.getPaymentMethodsSuccess(methods));
    } catch (e) {
      emit(SettingsState.getPaymentMethodsFailure(e.toString()));
    }
  }

  Future<void> _mapDeletePaymentMethodToState(
      String id, Emitter<SettingsState> emit) async {
    emit(const SettingsState.deletePaymentMethodLoading());
    try {
      await _settingsRepository.deletePaymentMethod(id);
      emit(SettingsState.deletePaymentMethodSuccess(id));
    } catch (e) {
      emit(SettingsState.deletePaymentMethodFailure(e.toString()));
    }
  }

  Future<void> _mapSetPaymentPinToState(
    Emitter<SettingsState> emit, {
    required String pin,
    String? currentPin,
    String? otp,
  }) async {
    emit(const SettingsState.setPaymentPinLoading());
    try {
      await _settingsRepository.setPaymentPin(
          pin: pin, currentPin: currentPin, otp: otp);
      emit(const SettingsState.setPaymentPinSuccess());
    } catch (e) {
      emit(SettingsState.setPaymentPinFailure(e.toString()));
    }
  }

  Future<void> _mapRequestDataExportToState(Emitter<SettingsState> emit) async {
    emit(const SettingsState.requestDataExportLoading());
    try {
      final status = await _settingsRepository.requestDataExport();
      emit(SettingsState.requestDataExportSuccess(status));
    } catch (e) {
      emit(SettingsState.requestDataExportFailure(e.toString()));
    }
  }

  Future<void> _mapGetDataExportStatusToState(
      Emitter<SettingsState> emit) async {
    emit(const SettingsState.getDataExportStatusLoading());
    try {
      final status = await _settingsRepository.getDataExportStatus();
      emit(SettingsState.getDataExportStatusSuccess(status));
    } catch (e) {
      emit(SettingsState.getDataExportStatusFailure(e.toString()));
    }
  }
}
