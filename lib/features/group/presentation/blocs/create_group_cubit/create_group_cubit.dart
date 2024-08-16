import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/data/models/create_group_payload.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

part 'create_group_state.dart';

part 'create_group_cubit.freezed.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  final GroupsRepository groupRepository;
  CreateGroupPayload groupPayload = CreateGroupPayload.empty();

  CreateGroupCubit(this.groupRepository)
      : super(const CreateGroupState.initial());

  Future<void> createGroup(CreateGroupPayload payload) async {
    emit(const CreateGroupState.createGroupLoading());

    try {
      final response = await groupRepository.createGroup(payload);
      emit(CreateGroupState.createGroupSuccess(response));
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
  }
}
