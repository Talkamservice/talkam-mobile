import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

part 'profile_screen_state.dart';

part 'profile_screen_cubit.freezed.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  final ProfileRepository _profileRepository;

  ProfileScreenCubit(this._profileRepository) : super(const ProfileScreenState.initial());

  bool get hasCachedUserData => SessionManager.instance.usersData.isNotEmpty;

  Future<void> fetchUserProfile() async {
    emit(const ProfileScreenState.loading());
    try {
      final Map<String, dynamic> usersData = SessionManager.instance.usersData;
      if (hasCachedUserData) {
        final TalkamUser talkAmUser = TalkamUser.fromJson(usersData);
        await Future.delayed(const Duration(milliseconds: 500));
        emit(ProfileScreenState.loaded(talkAmUser));
      }

      final talkAmUser = await _profileRepository.fetchUserProfile();
      if (talkAmUser != null) {
        emit(const ProfileScreenState.loading());
        emit(ProfileScreenState.loaded(talkAmUser));
      }
    } catch (exception, stackTrace) {
      logger.e(exception, stackTrace: stackTrace);
      if (hasCachedUserData) {
        emit(ProfileScreenState.loaded(TalkamUser.fromJson(SessionManager.instance.usersData)));
      } else {
        emit(const ProfileScreenState.error());
      }
    }
  }
}
