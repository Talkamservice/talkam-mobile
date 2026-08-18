import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talkam/common/database/local/userstorage.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/authentication/data/models/get_avatars_response.dart';
import 'package:talkam/features/post/data/models/update_profile_response.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/profile/data/models/block_user_response.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>
    with RefreshPostsMixin {
  final ProfileRepository _profileRepository;

  TalkamUser? appUser;

  final _userStorage = UserStorage();

  ProfileBloc(this._profileRepository) : super(UserInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<SaveUserLocallyEvent>(_mapSaveUserEventToState);
    on<Logout>(_Logout);
    on<GetCachedUserEvent>(_mapGetUserEventToState);
    on<UploadAvatarEvent>(_onUploadAvatar);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<GetAvatarsEvent>(_mapGetAvatarsEventToState);
    on<BlockUerEvent>(_mapBlockUerEventToState);
    on<UpdateInterestEvent>(_mapUpdateInterestEventToState);
    on<GetRemoteUser>(_mapGetRemoteUserEventToState);
    on<MuteUserEvent>(_mapMuteUserEventToState);
  }

  FutureOr<void> _mapSaveUserEventToState(
      SaveUserLocallyEvent event, Emitter<ProfileState> emit) {
    _userStorage.saveUser(event.appUser);
    appUser = event.appUser;

    // logger.w(appUser?.toJson());
    emit(UserCachedState(event.appUser));
  }

  FutureOr<void> _mapGetUserEventToState(
      GetCachedUserEvent event, Emitter<ProfileState> emit) async {
    var user = await _userStorage.getUser();

    if (user != null) {
      appUser = user;
      emit(UserCachedState(user));
    }
  }

  Future<void> _onUploadAvatar(
      UploadAvatarEvent event, Emitter<ProfileState> emit) async {
    emit(UploadAvatarLoading());
    try {
      final response = await _profileRepository.uploadAvatar(event.filePath);
      emit(UploadAvatarSuccess(response));
    } catch (error) {
      emit(UploadAvatarFailure(error.toString()));
    }
  }

  Future<void> _onUpdateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(UpdateProfileLoading());
    try {
      if (event.payload.interests != null &&
          event.payload.interests!.isNotEmpty) {
        await _profileRepository.saveInterests(event.payload.interests!);
        if (appUser?.onboarding != null) {
          final updatedOnboarding = Onboarding(
            userType: appUser!.onboarding!.userType,
            interests: true,
            avatar: appUser!.onboarding!.avatar,
            consents: appUser!.onboarding!.consents,
            completedAt: appUser!.onboarding!.completedAt,
          );
          appUser = appUser!.copyWith(onboarding: updatedOnboarding);
          _userStorage.saveUser(appUser!);
        }
      }

      if (event.payload.name != null ||
          event.payload.avatar != null ||
          event.payload.username != null ||
          event.payload.gender != null ||
          event.payload.dob != null) {
        final response = await _profileRepository.updateProfile(event.payload);
        final mergedUser = response.data.copyWith(
          onboarding: appUser?.onboarding,
          business: appUser?.business,
        );
        injector.get<ProfileBloc>().add(SaveUserLocallyEvent(mergedUser));
        emit(UpdateProfileSuccess(response));
      } else {
        if (appUser != null) {
          final dummyResponse = UpdateProfileResponse(
            message: "Interests saved successfully",
            data: appUser!,
            success: true,
            code: 200,
          );
          emit(UpdateProfileSuccess(dummyResponse));
        }
      }
      refreshPost(reload: false);
    } catch (error, stack) {
      logger.e(error, stackTrace: stack);
      emit(UpdateProfileFailure(error.toString()));
    }
  }

  FutureOr<void> _mapGetAvatarsEventToState(
      GetAvatarsEvent event, Emitter<ProfileState> emit) async {
    emit(GetAvatarsLoadingState());
    try {
      final response = await _profileRepository.getAvatars();
      emit(GetAvatarsSuccessState(response: response));
    } catch (error) {
      emit(GetAvatarsFailureState(error: error.toString()));
    }
  }

  FutureOr<void> _mapBlockUerEventToState(
      BlockUerEvent event, Emitter<ProfileState> emit) async {
    if (event.reload!) {
      emit(BlockUserLoadingState());
    }
    try {
      final response = await _profileRepository.blockUser(event.userId);

      emit(BlockUserSuccessState(response: response));
    } catch (error) {
      emit(BlockUserFailureState(error: error.toString()));
    }
  }

  FutureOr<void> _mapGetRemoteUserEventToState(
      GetRemoteUser event, Emitter<ProfileState> emit) async {
    emit(GetProfileLoadingState());
    try {
      final response = await _profileRepository.fetchUserProfile();
      if (response == null) {
        emit(BlockUserFailureState(error: "User session not found"));
        return;
      }
      injector.get<ProfileBloc>().add(SaveUserLocallyEvent(response));
      emit(GetProfileSuccessState(user: response));
    } catch (error) {
      emit(BlockUserFailureState(error: error.toString()));
    }
  }

  FutureOr<void> _mapUpdateInterestEventToState(
      UpdateInterestEvent event, Emitter<ProfileState> emit) async {
    emit(UpdateInterestLoadingState());
    try {
      // var user = injector.get<ProfileBloc>().appUser;
      final response =
          await _profileRepository.addOrRemoveInterest(event.categoryId);
      // injector.get<ProfileBloc>().add(SaveUserLocallyEvent(response));
      // CustomDialogs.error(response.toString());
      emit(UpdateInterestSuccessState(response: response));
    } catch (error) {
      emit(UpdateProfileFailure(error.toString()));
    }
  }

  FutureOr<void> _mapMuteUserEventToState(
      MuteUserEvent event, Emitter<ProfileState> emit) async {
    emit(MuteUserLoadingState());
    try {
      final muted = await _profileRepository.toggleMute(event.userId);
      emit(MuteUserSuccessState(muted: muted));
    } catch (error) {
      emit(MuteUserFailureState(error: error.toString()));
    }
  }

  FutureOr<void> _Logout(Logout event, Emitter<ProfileState> emit) {
    emit(ProfileInitial());
  }
}
