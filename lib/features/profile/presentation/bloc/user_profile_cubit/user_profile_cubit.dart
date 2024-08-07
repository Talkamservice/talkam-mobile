import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

part 'user_profile_state.dart';

part 'user_profile_cubit.freezed.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit(this._profileRepository)
      : super(const UserProfileState.initial());
  final ProfileRepository _profileRepository;

  Future<void> fetchUserProfile(String id) async {
    emit(const UserProfileState.profileLoading());

    try {
      // final Map<String, dynamic> usersData = SessionManager.instance.usersData;
      final talkAmUser = await _profileRepository.getProfile(id);
      if (talkAmUser != null) {
        emit(const UserProfileState.profileLoading());
        emit(UserProfileState.profileLoaded(talkAmUser));
      }
    } catch (exception, stackTrace) {
      logger.e(exception, stackTrace: stackTrace);
      emit(const UserProfileState.getProfileError());
    }
  }
}
