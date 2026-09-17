import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/resettable_on_logout.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/group/data/models/create_group_payload.dart';
import 'package:talkam/features/group/dormain/mixins/refresh_groups_mixin.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';
import 'package:talkam/features/home/dormain/mixins/refresh_app_mixin.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

part 'create_group_state.dart';

part 'create_group_cubit.freezed.dart';

class CreateGroupCubit extends Cubit<CreateGroupState>
    with RefreshGroupsMixin
    implements ResettableOnLogout {
  final GroupsRepository groupRepository;
  CreateGroupPayload groupPayload = CreateGroupPayload.empty();


  CreateGroupCubit(this.groupRepository)
      : super(const CreateGroupState.initial());

  @override
  void resetForLogout() => emit(const CreateGroupState.initial());

  Future<void> createGroup(CreateGroupPayload payload) async {
    emit(const CreateGroupState.createGroupLoading());

    try {
      final response = await groupRepository.createGroup(payload);
      injector.get<ProfileBloc>().add(const GetRemoteUser());
      emit(CreateGroupState.createGroupSuccess(response));
      // The flow completed — nothing left to resume next time.
      clearDraft();
      // The new group needs to show up in My Groups/Recent immediately,
      // not just after the user happens to pull-to-refresh.
      refreshAllGroupLists();
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(CreateGroupState.createGroupFailure(e.toString()));
    }
  }

  Future<void> updateGroup(String groupId, CreateGroupPayload payload) async {
    emit(const CreateGroupState.updateGroupLoading());

    try {
      final response = await groupRepository.updateGroup(groupId, payload);

      emit(CreateGroupState.updateGroupSuccess(response));
      // Changed name/image/category/etc. needs to be reflected everywhere
      // that group is listed, not just on this screen.
      refreshAllGroupLists();
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(CreateGroupState.updateGroupFailure(e.toString()));
    }
  }

  void updateGroupPayload({
    int? categoryId,
    String? categoryName,
    String? categoryImage,
    String? name,
    String? description,
    String? about,
    String? status,
    int? canPost,
    String? image,
    String? rulesSummary,
    List<String>? tags,
    String? groupAccess,
    List<GuidelinePayload>? guidelines,
  }) {
    groupPayload = groupPayload.copyWith(
      categoryId: categoryId ?? groupPayload.categoryId,
      name: name ?? groupPayload.name,
      description: description ?? groupPayload.description,
      about: about ?? groupPayload.about,
      status: status ?? groupPayload.status,
      canPost: canPost ?? groupPayload.canPost,
      image: image ?? groupPayload.image,
      rulesSummary: rulesSummary ?? groupPayload.rulesSummary,
      tags: tags ?? groupPayload.tags,
      groupAccess: groupAccess ?? groupPayload.groupAccess,
      guidelines: guidelines ?? groupPayload.guidelines,
      categoryImage: categoryImage ?? groupPayload.categoryImage,
      categoryName: categoryName ?? groupPayload.categoryName,
    );
    // Persist on every change, not on a timer or app-lifecycle hook, so
    // the draft survives even the app being killed outright mid-flow.
    _persistDraft();
  }

  static const _draftKey = 'create_group_draft';

  void _persistDraft() {
    SessionManager.instance.sharedPreferences
        ?.setString(_draftKey, createGroupPayloadToJson(groupPayload));
  }

  /// Whether a resumable draft exists. Requires at least a name so an
  /// abandoned flow that never got past the first field doesn't prompt.
  bool hasSavedDraft() {
    final raw = SessionManager.instance.sharedPreferences?.getString(_draftKey);
    if (raw == null) return false;
    try {
      return createGroupPayloadFromJson(raw).name.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Loads the persisted draft into [groupPayload]. Call [hasSavedDraft]
  /// first to confirm one exists.
  CreateGroupPayload? loadDraft() {
    final raw = SessionManager.instance.sharedPreferences?.getString(_draftKey);
    if (raw == null) return null;
    try {
      groupPayload = createGroupPayloadFromJson(raw);
      return groupPayload;
    } catch (e, stack) {
      logger.e('CreateGroupCubit: failed to load draft',
          error: e, stackTrace: stack);
      return null;
    }
  }

  /// Discards the persisted draft and resets in-memory state — call after
  /// a successful submission, or when the user chooses to start fresh
  /// instead of resuming.
  void clearDraft() {
    SessionManager.instance.sharedPreferences?.remove(_draftKey);
    groupPayload = CreateGroupPayload.empty();
  }

  /// Debug visibility into whatever's actually on disk right now, as
  /// opposed to [groupPayload]'s in-memory value — call whenever you need
  /// to confirm what a resumed draft will actually load.
  void logDraft() {
    final raw = SessionManager.instance.sharedPreferences?.getString(_draftKey);
    logger.i('CreateGroupCubit: persisted draft = $raw');
  }
}
