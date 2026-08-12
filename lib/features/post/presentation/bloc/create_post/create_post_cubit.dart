import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/utils/no_equality.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/data/models/create_post_response.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

part 'create_post_state.dart';

part 'create_post_cubit.freezed.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit(this._postRepository)
      : super(const CreatePostState.initial());
  final PostRepository _postRepository;

  bool formsValidated = false;
  CreatePostPayload createPostPayload = CreatePostPayload.empty();

  void createPost() async {
    emit(const CreatePostState.createPostLoading());
    try {
      final response = await _postRepository.createPost(createPostPayload);
      injector.get<ProfileBloc>().add(const GetRemoteUser());
      emit(CreatePostState.createPostSuccess(response));
    } catch (error, stack) {
      logger.e(error.toString());
      logger.e(stack.toString());
      emit(CreatePostState.createPostFailure(error.toString()));
    }
  }

  void saveDraft() async {
    emit(const CreatePostState.saveDraftLoading());
    try {
      final response = await _postRepository.saveDraft(createPostPayload);
      emit(CreatePostState.saveDraftSuccess(response));
    } catch (error, stack) {
      logger.e(error.toString());
      logger.e(stack.toString());
      emit(CreatePostState.saveDraftFailure(error.toString()));
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
