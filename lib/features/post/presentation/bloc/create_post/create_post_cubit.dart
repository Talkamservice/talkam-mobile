import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/resettable_on_logout.dart';
import 'package:talkam/core/utils/no_equality.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/data/models/create_post_response.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

part 'create_post_state.dart';

part 'create_post_cubit.freezed.dart';

class CreatePostCubit extends Cubit<CreatePostState>
    implements ResettableOnLogout {
  CreatePostCubit(this._postRepository)
      : super(const CreatePostState.initial());
  final PostRepository _postRepository;

  @override
  void resetForLogout() => emit(const CreatePostState.initial());

  bool formsValidated = false;
  CreatePostPayload createPostPayload = CreatePostPayload.empty();

  void createPost() async {
    emit(const CreatePostState.createPostLoading());
    try {
      final response = await _postRepository.createPost(createPostPayload);
      injector.get<ProfileBloc>().add(const GetRemoteUser());
      emit(CreatePostState.createPostSuccess(response));
    } catch (error, stack) {
      logger.e(error.toString(), error: error, stackTrace: stack);
      emit(CreatePostState.createPostFailure(error.toString()));
    }
  }

  void saveDraft() async {
    emit(const CreatePostState.saveDraftLoading());
    try {
      final response = await _postRepository.saveDraft(createPostPayload);
      emit(CreatePostState.saveDraftSuccess(response));
    } catch (error, stack) {
      logger.e(error.toString(), error: error, stackTrace: stack);
      emit(CreatePostState.saveDraftFailure(error.toString()));
    }
  }

  /// Content edit on an existing draft — [payload] is passed straight
  /// through rather than merged into [createPostPayload] via [updatePayload]
  /// so its `status: null` (deliberately unset, to leave the draft's status
  /// alone) can't get swallowed by copyWith's `status ?? this.status`.
  void updateDraft(int draftId, CreatePostPayload payload) async {
    emit(const CreatePostState.saveDraftLoading());
    try {
      final response =
          await _postRepository.updateDraft(draftId.toString(), payload);
      emit(CreatePostState.saveDraftSuccess(response));
    } catch (error, stack) {
      logger.e(error.toString(), error: error, stackTrace: stack);
      emit(CreatePostState.saveDraftFailure(error.toString()));
    }
  }

  /// Moves an existing draft into the real feed — same endpoint as
  /// [updateDraft], just with `status: "Active"` (or "Scheduled") already
  /// set on [payload], matching how [DraftsCubit.publishDraft] does it.
  void publishDraft(int draftId, CreatePostPayload payload) async {
    emit(const CreatePostState.createPostLoading());
    try {
      final response =
          await _postRepository.updateDraft(draftId.toString(), payload);
      injector.get<ProfileBloc>().add(const GetRemoteUser());
      emit(CreatePostState.createPostSuccess(response));
    } catch (error, stack) {
      logger.e(error.toString(), error: error, stackTrace: stack);
      emit(CreatePostState.createPostFailure(error.toString()));
    }
  }

  void validateForms() {
    // Triggers form validation for create post forms
    emit(const CreatePostState.validateFormsState());

    // Resets State Back to initial
    emit(const CreatePostState.initial());
  }

  void validateFormsSuccess() {
    formsValidated = true;
    emit(const CreatePostState.validateFormsSuccessState());
  }

  void updatePayload(CreatePostPayload updatedData) {
    createPostPayload = createPostPayload.copyWith(
      categoryId: updatedData.categoryId,
      type: updatedData.type,
      title: updatedData.title,
      body: updatedData.body,
      groupId: updatedData.groupId,
      status: updatedData.status,
      publishAt: updatedData.publishAt,
      canComment: updatedData.canComment,
      isAnonymous: updatedData.isAnonymous,
      attachments: updatedData.attachments,
      tags: updatedData.tags,
      poll: updatedData.poll,
    );
  }
}
