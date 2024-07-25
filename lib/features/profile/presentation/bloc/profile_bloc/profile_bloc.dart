import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talkam/common/database/local/userstorage.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/authentication/data/models/get_avatars_response.dart';
import 'package:talkam/features/post/data/models/update_profile_response.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  TalkamUser? appUser;

  final _userStorage = UserStorage();

  ProfileBloc(this._profileRepository) : super(UserInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<SaveUserLocallyEvent>(_mapSaveUserEventToState);
    on<GetCachedUserEvent>(_mapGetUserEventToState);
    on<UploadAvatarEvent>(_onUploadAvatar);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<GetAvatarsEvent>(_mapGetAvatarsEventToState);
    on<BlockUerEvent>(_mapBlockUerEventToState);
    on<UpdateInterestEvent>(_mapUpdateInterestEventToState);
    on<GetRemoteUser>(_mapGetRemoteUserEventToState);
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
      final response = await _profileRepository.updateProfile(event.payload);
      emit(UpdateProfileSuccess(response));
      injector.get<ProfileBloc>().add(SaveUserLocallyEvent(response.data));
    } catch (error) {
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
    emit(BlockUserLoadingState());
    try {
      final response = await _profileRepository.getAvatars();
      emit(BlockUserSuccessState(response: response));
    } catch (error) {
      emit(BlockUserFailureState(error: error.toString()));
    }
  }

  FutureOr<void> _mapGetRemoteUserEventToState(
      GetRemoteUser event, Emitter<ProfileState> emit) async {
    emit(BlockUserLoadingState());
    try {
      var user = injector.get<ProfileBloc>().appUser;
      final response = await _profileRepository.getProfile(user!.id.toString());
      injector.get<ProfileBloc>().add(SaveUserLocallyEvent(response));
      // CustomDialogs.error(response.toString());
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
}
