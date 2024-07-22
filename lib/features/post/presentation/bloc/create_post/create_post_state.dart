part of 'create_post_cubit.dart';

@freezed
class CreatePostState with _$CreatePostState, NoEquality {
  const factory CreatePostState.initial() = _Initial;



  const factory CreatePostState.validateFormsState() = ValidateFormsState;
  const factory CreatePostState.validateFormsSuccessState() = ValidateFormsSuccessState;
  const factory CreatePostState.createPostLoading() = CreatePostLoadingState;
  const factory CreatePostState.createPostSuccess(CreatePostResponse response) = CreatePostSuccessState;
  const factory CreatePostState.createPostFailure(String error) = CreatePostFailureState;





}
