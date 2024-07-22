// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? categoryId) getCategories,
    required TResult Function() getPosts,
    required TResult Function(CreatePostPayload postData) createPost,
    required TResult Function(String postId) getPostDetails,
    required TResult Function(String postId) deletePost,
    required TResult Function(String postId, String action) postReaction,
    required TResult Function(String postId, String reason) reportPost,
    required TResult Function() getPolls,
    required TResult Function(String postId) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? categoryId)? getCategories,
    TResult? Function()? getPosts,
    TResult? Function(CreatePostPayload postData)? createPost,
    TResult? Function(String postId)? getPostDetails,
    TResult? Function(String postId)? deletePost,
    TResult? Function(String postId, String action)? postReaction,
    TResult? Function(String postId, String reason)? reportPost,
    TResult? Function()? getPolls,
    TResult? Function(String postId)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? categoryId)? getCategories,
    TResult Function()? getPosts,
    TResult Function(CreatePostPayload postData)? createPost,
    TResult Function(String postId)? getPostDetails,
    TResult Function(String postId)? deletePost,
    TResult Function(String postId, String action)? postReaction,
    TResult Function(String postId, String reason)? reportPost,
    TResult Function()? getPolls,
    TResult Function(String postId)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCategoriesEvent value) getCategories,
    required TResult Function(_GetPostsEvent value) getPosts,
    required TResult Function(_CreatePostEvent value) createPost,
    required TResult Function(_GetPostDetailsEvent value) getPostDetails,
    required TResult Function(_DeletePostEvent value) deletePost,
    required TResult Function(_PostReactionEvent value) postReaction,
    required TResult Function(ReportPostEvent value) reportPost,
    required TResult Function(_GetPollsEvent value) getPolls,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCategoriesEvent value)? getCategories,
    TResult? Function(_GetPostsEvent value)? getPosts,
    TResult? Function(_CreatePostEvent value)? createPost,
    TResult? Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult? Function(_DeletePostEvent value)? deletePost,
    TResult? Function(_PostReactionEvent value)? postReaction,
    TResult? Function(ReportPostEvent value)? reportPost,
    TResult? Function(_GetPollsEvent value)? getPolls,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCategoriesEvent value)? getCategories,
    TResult Function(_GetPostsEvent value)? getPosts,
    TResult Function(_CreatePostEvent value)? createPost,
    TResult Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult Function(_DeletePostEvent value)? deletePost,
    TResult Function(_PostReactionEvent value)? postReaction,
    TResult Function(ReportPostEvent value)? reportPost,
    TResult Function(_GetPollsEvent value)? getPolls,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostEventCopyWith<$Res> {
  factory $PostEventCopyWith(PostEvent value, $Res Function(PostEvent) then) =
      _$PostEventCopyWithImpl<$Res, PostEvent>;
}

/// @nodoc
class _$PostEventCopyWithImpl<$Res, $Val extends PostEvent>
    implements $PostEventCopyWith<$Res> {
  _$PostEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GetCategoriesEventImplCopyWith<$Res> {
  factory _$$GetCategoriesEventImplCopyWith(_$GetCategoriesEventImpl value,
          $Res Function(_$GetCategoriesEventImpl) then) =
      __$$GetCategoriesEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? categoryId});
}

/// @nodoc
class __$$GetCategoriesEventImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$GetCategoriesEventImpl>
    implements _$$GetCategoriesEventImplCopyWith<$Res> {
  __$$GetCategoriesEventImplCopyWithImpl(_$GetCategoriesEventImpl _value,
      $Res Function(_$GetCategoriesEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = freezed,
  }) {
    return _then(_$GetCategoriesEventImpl(
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GetCategoriesEventImpl implements _GetCategoriesEvent {
  const _$GetCategoriesEventImpl({this.categoryId});

  @override
  final String? categoryId;

  @override
  String toString() {
    return 'PostEvent.getCategories(categoryId: $categoryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCategoriesEventImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, categoryId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCategoriesEventImplCopyWith<_$GetCategoriesEventImpl> get copyWith =>
      __$$GetCategoriesEventImplCopyWithImpl<_$GetCategoriesEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? categoryId) getCategories,
    required TResult Function() getPosts,
    required TResult Function(CreatePostPayload postData) createPost,
    required TResult Function(String postId) getPostDetails,
    required TResult Function(String postId) deletePost,
    required TResult Function(String postId, String action) postReaction,
    required TResult Function(String postId, String reason) reportPost,
    required TResult Function() getPolls,
    required TResult Function(String postId) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return getCategories(categoryId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? categoryId)? getCategories,
    TResult? Function()? getPosts,
    TResult? Function(CreatePostPayload postData)? createPost,
    TResult? Function(String postId)? getPostDetails,
    TResult? Function(String postId)? deletePost,
    TResult? Function(String postId, String action)? postReaction,
    TResult? Function(String postId, String reason)? reportPost,
    TResult? Function()? getPolls,
    TResult? Function(String postId)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return getCategories?.call(categoryId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? categoryId)? getCategories,
    TResult Function()? getPosts,
    TResult Function(CreatePostPayload postData)? createPost,
    TResult Function(String postId)? getPostDetails,
    TResult Function(String postId)? deletePost,
    TResult Function(String postId, String action)? postReaction,
    TResult Function(String postId, String reason)? reportPost,
    TResult Function()? getPolls,
    TResult Function(String postId)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (getCategories != null) {
      return getCategories(categoryId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCategoriesEvent value) getCategories,
    required TResult Function(_GetPostsEvent value) getPosts,
    required TResult Function(_CreatePostEvent value) createPost,
    required TResult Function(_GetPostDetailsEvent value) getPostDetails,
    required TResult Function(_DeletePostEvent value) deletePost,
    required TResult Function(_PostReactionEvent value) postReaction,
    required TResult Function(ReportPostEvent value) reportPost,
    required TResult Function(_GetPollsEvent value) getPolls,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return getCategories(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCategoriesEvent value)? getCategories,
    TResult? Function(_GetPostsEvent value)? getPosts,
    TResult? Function(_CreatePostEvent value)? createPost,
    TResult? Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult? Function(_DeletePostEvent value)? deletePost,
    TResult? Function(_PostReactionEvent value)? postReaction,
    TResult? Function(ReportPostEvent value)? reportPost,
    TResult? Function(_GetPollsEvent value)? getPolls,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return getCategories?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCategoriesEvent value)? getCategories,
    TResult Function(_GetPostsEvent value)? getPosts,
    TResult Function(_CreatePostEvent value)? createPost,
    TResult Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult Function(_DeletePostEvent value)? deletePost,
    TResult Function(_PostReactionEvent value)? postReaction,
    TResult Function(ReportPostEvent value)? reportPost,
    TResult Function(_GetPollsEvent value)? getPolls,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (getCategories != null) {
      return getCategories(this);
    }
    return orElse();
  }
}

abstract class _GetCategoriesEvent implements PostEvent {
  const factory _GetCategoriesEvent({final String? categoryId}) =
      _$GetCategoriesEventImpl;

  String? get categoryId;
  @JsonKey(ignore: true)
  _$$GetCategoriesEventImplCopyWith<_$GetCategoriesEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetPostsEventImplCopyWith<$Res> {
  factory _$$GetPostsEventImplCopyWith(
          _$GetPostsEventImpl value, $Res Function(_$GetPostsEventImpl) then) =
      __$$GetPostsEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetPostsEventImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$GetPostsEventImpl>
    implements _$$GetPostsEventImplCopyWith<$Res> {
  __$$GetPostsEventImplCopyWithImpl(
      _$GetPostsEventImpl _value, $Res Function(_$GetPostsEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetPostsEventImpl implements _GetPostsEvent {
  const _$GetPostsEventImpl();

  @override
  String toString() {
    return 'PostEvent.getPosts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetPostsEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? categoryId) getCategories,
    required TResult Function() getPosts,
    required TResult Function(CreatePostPayload postData) createPost,
    required TResult Function(String postId) getPostDetails,
    required TResult Function(String postId) deletePost,
    required TResult Function(String postId, String action) postReaction,
    required TResult Function(String postId, String reason) reportPost,
    required TResult Function() getPolls,
    required TResult Function(String postId) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return getPosts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? categoryId)? getCategories,
    TResult? Function()? getPosts,
    TResult? Function(CreatePostPayload postData)? createPost,
    TResult? Function(String postId)? getPostDetails,
    TResult? Function(String postId)? deletePost,
    TResult? Function(String postId, String action)? postReaction,
    TResult? Function(String postId, String reason)? reportPost,
    TResult? Function()? getPolls,
    TResult? Function(String postId)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return getPosts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? categoryId)? getCategories,
    TResult Function()? getPosts,
    TResult Function(CreatePostPayload postData)? createPost,
    TResult Function(String postId)? getPostDetails,
    TResult Function(String postId)? deletePost,
    TResult Function(String postId, String action)? postReaction,
    TResult Function(String postId, String reason)? reportPost,
    TResult Function()? getPolls,
    TResult Function(String postId)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (getPosts != null) {
      return getPosts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCategoriesEvent value) getCategories,
    required TResult Function(_GetPostsEvent value) getPosts,
    required TResult Function(_CreatePostEvent value) createPost,
    required TResult Function(_GetPostDetailsEvent value) getPostDetails,
    required TResult Function(_DeletePostEvent value) deletePost,
    required TResult Function(_PostReactionEvent value) postReaction,
    required TResult Function(ReportPostEvent value) reportPost,
    required TResult Function(_GetPollsEvent value) getPolls,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return getPosts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCategoriesEvent value)? getCategories,
    TResult? Function(_GetPostsEvent value)? getPosts,
    TResult? Function(_CreatePostEvent value)? createPost,
    TResult? Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult? Function(_DeletePostEvent value)? deletePost,
    TResult? Function(_PostReactionEvent value)? postReaction,
    TResult? Function(ReportPostEvent value)? reportPost,
    TResult? Function(_GetPollsEvent value)? getPolls,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return getPosts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCategoriesEvent value)? getCategories,
    TResult Function(_GetPostsEvent value)? getPosts,
    TResult Function(_CreatePostEvent value)? createPost,
    TResult Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult Function(_DeletePostEvent value)? deletePost,
    TResult Function(_PostReactionEvent value)? postReaction,
    TResult Function(ReportPostEvent value)? reportPost,
    TResult Function(_GetPollsEvent value)? getPolls,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (getPosts != null) {
      return getPosts(this);
    }
    return orElse();
  }
}

abstract class _GetPostsEvent implements PostEvent {
  const factory _GetPostsEvent() = _$GetPostsEventImpl;
}

/// @nodoc
abstract class _$$CreatePostEventImplCopyWith<$Res> {
  factory _$$CreatePostEventImplCopyWith(_$CreatePostEventImpl value,
          $Res Function(_$CreatePostEventImpl) then) =
      __$$CreatePostEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CreatePostPayload postData});
}

/// @nodoc
class __$$CreatePostEventImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$CreatePostEventImpl>
    implements _$$CreatePostEventImplCopyWith<$Res> {
  __$$CreatePostEventImplCopyWithImpl(
      _$CreatePostEventImpl _value, $Res Function(_$CreatePostEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postData = null,
  }) {
    return _then(_$CreatePostEventImpl(
      null == postData
          ? _value.postData
          : postData // ignore: cast_nullable_to_non_nullable
              as CreatePostPayload,
    ));
  }
}

/// @nodoc

class _$CreatePostEventImpl implements _CreatePostEvent {
  const _$CreatePostEventImpl(this.postData);

  @override
  final CreatePostPayload postData;

  @override
  String toString() {
    return 'PostEvent.createPost(postData: $postData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePostEventImpl &&
            (identical(other.postData, postData) ||
                other.postData == postData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePostEventImplCopyWith<_$CreatePostEventImpl> get copyWith =>
      __$$CreatePostEventImplCopyWithImpl<_$CreatePostEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? categoryId) getCategories,
    required TResult Function() getPosts,
    required TResult Function(CreatePostPayload postData) createPost,
    required TResult Function(String postId) getPostDetails,
    required TResult Function(String postId) deletePost,
    required TResult Function(String postId, String action) postReaction,
    required TResult Function(String postId, String reason) reportPost,
    required TResult Function() getPolls,
    required TResult Function(String postId) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return createPost(postData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? categoryId)? getCategories,
    TResult? Function()? getPosts,
    TResult? Function(CreatePostPayload postData)? createPost,
    TResult? Function(String postId)? getPostDetails,
    TResult? Function(String postId)? deletePost,
    TResult? Function(String postId, String action)? postReaction,
    TResult? Function(String postId, String reason)? reportPost,
    TResult? Function()? getPolls,
    TResult? Function(String postId)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return createPost?.call(postData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? categoryId)? getCategories,
    TResult Function()? getPosts,
    TResult Function(CreatePostPayload postData)? createPost,
    TResult Function(String postId)? getPostDetails,
    TResult Function(String postId)? deletePost,
    TResult Function(String postId, String action)? postReaction,
    TResult Function(String postId, String reason)? reportPost,
    TResult Function()? getPolls,
    TResult Function(String postId)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (createPost != null) {
      return createPost(postData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCategoriesEvent value) getCategories,
    required TResult Function(_GetPostsEvent value) getPosts,
    required TResult Function(_CreatePostEvent value) createPost,
    required TResult Function(_GetPostDetailsEvent value) getPostDetails,
    required TResult Function(_DeletePostEvent value) deletePost,
    required TResult Function(_PostReactionEvent value) postReaction,
    required TResult Function(ReportPostEvent value) reportPost,
    required TResult Function(_GetPollsEvent value) getPolls,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return createPost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCategoriesEvent value)? getCategories,
    TResult? Function(_GetPostsEvent value)? getPosts,
    TResult? Function(_CreatePostEvent value)? createPost,
    TResult? Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult? Function(_DeletePostEvent value)? deletePost,
    TResult? Function(_PostReactionEvent value)? postReaction,
    TResult? Function(ReportPostEvent value)? reportPost,
    TResult? Function(_GetPollsEvent value)? getPolls,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return createPost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCategoriesEvent value)? getCategories,
    TResult Function(_GetPostsEvent value)? getPosts,
    TResult Function(_CreatePostEvent value)? createPost,
    TResult Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult Function(_DeletePostEvent value)? deletePost,
    TResult Function(_PostReactionEvent value)? postReaction,
    TResult Function(ReportPostEvent value)? reportPost,
    TResult Function(_GetPollsEvent value)? getPolls,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (createPost != null) {
      return createPost(this);
    }
    return orElse();
  }
}

abstract class _CreatePostEvent implements PostEvent {
  const factory _CreatePostEvent(final CreatePostPayload postData) =
      _$CreatePostEventImpl;

  CreatePostPayload get postData;
  @JsonKey(ignore: true)
  _$$CreatePostEventImplCopyWith<_$CreatePostEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetPostDetailsEventImplCopyWith<$Res> {
  factory _$$GetPostDetailsEventImplCopyWith(_$GetPostDetailsEventImpl value,
          $Res Function(_$GetPostDetailsEventImpl) then) =
      __$$GetPostDetailsEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId});
}

/// @nodoc
class __$$GetPostDetailsEventImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$GetPostDetailsEventImpl>
    implements _$$GetPostDetailsEventImplCopyWith<$Res> {
  __$$GetPostDetailsEventImplCopyWithImpl(_$GetPostDetailsEventImpl _value,
      $Res Function(_$GetPostDetailsEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
  }) {
    return _then(_$GetPostDetailsEventImpl(
      null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetPostDetailsEventImpl implements _GetPostDetailsEvent {
  const _$GetPostDetailsEventImpl(this.postId);

  @override
  final String postId;

  @override
  String toString() {
    return 'PostEvent.getPostDetails(postId: $postId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPostDetailsEventImpl &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPostDetailsEventImplCopyWith<_$GetPostDetailsEventImpl> get copyWith =>
      __$$GetPostDetailsEventImplCopyWithImpl<_$GetPostDetailsEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? categoryId) getCategories,
    required TResult Function() getPosts,
    required TResult Function(CreatePostPayload postData) createPost,
    required TResult Function(String postId) getPostDetails,
    required TResult Function(String postId) deletePost,
    required TResult Function(String postId, String action) postReaction,
    required TResult Function(String postId, String reason) reportPost,
    required TResult Function() getPolls,
    required TResult Function(String postId) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return getPostDetails(postId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? categoryId)? getCategories,
    TResult? Function()? getPosts,
    TResult? Function(CreatePostPayload postData)? createPost,
    TResult? Function(String postId)? getPostDetails,
    TResult? Function(String postId)? deletePost,
    TResult? Function(String postId, String action)? postReaction,
    TResult? Function(String postId, String reason)? reportPost,
    TResult? Function()? getPolls,
    TResult? Function(String postId)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return getPostDetails?.call(postId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? categoryId)? getCategories,
    TResult Function()? getPosts,
    TResult Function(CreatePostPayload postData)? createPost,
    TResult Function(String postId)? getPostDetails,
    TResult Function(String postId)? deletePost,
    TResult Function(String postId, String action)? postReaction,
    TResult Function(String postId, String reason)? reportPost,
    TResult Function()? getPolls,
    TResult Function(String postId)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (getPostDetails != null) {
      return getPostDetails(postId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCategoriesEvent value) getCategories,
    required TResult Function(_GetPostsEvent value) getPosts,
    required TResult Function(_CreatePostEvent value) createPost,
    required TResult Function(_GetPostDetailsEvent value) getPostDetails,
    required TResult Function(_DeletePostEvent value) deletePost,
    required TResult Function(_PostReactionEvent value) postReaction,
    required TResult Function(ReportPostEvent value) reportPost,
    required TResult Function(_GetPollsEvent value) getPolls,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return getPostDetails(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCategoriesEvent value)? getCategories,
    TResult? Function(_GetPostsEvent value)? getPosts,
    TResult? Function(_CreatePostEvent value)? createPost,
    TResult? Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult? Function(_DeletePostEvent value)? deletePost,
    TResult? Function(_PostReactionEvent value)? postReaction,
    TResult? Function(ReportPostEvent value)? reportPost,
    TResult? Function(_GetPollsEvent value)? getPolls,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return getPostDetails?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCategoriesEvent value)? getCategories,
    TResult Function(_GetPostsEvent value)? getPosts,
    TResult Function(_CreatePostEvent value)? createPost,
    TResult Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult Function(_DeletePostEvent value)? deletePost,
    TResult Function(_PostReactionEvent value)? postReaction,
    TResult Function(ReportPostEvent value)? reportPost,
    TResult Function(_GetPollsEvent value)? getPolls,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (getPostDetails != null) {
      return getPostDetails(this);
    }
    return orElse();
  }
}

abstract class _GetPostDetailsEvent implements PostEvent {
  const factory _GetPostDetailsEvent(final String postId) =
      _$GetPostDetailsEventImpl;

  String get postId;
  @JsonKey(ignore: true)
  _$$GetPostDetailsEventImplCopyWith<_$GetPostDetailsEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeletePostEventImplCopyWith<$Res> {
  factory _$$DeletePostEventImplCopyWith(_$DeletePostEventImpl value,
          $Res Function(_$DeletePostEventImpl) then) =
      __$$DeletePostEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId});
}

/// @nodoc
class __$$DeletePostEventImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$DeletePostEventImpl>
    implements _$$DeletePostEventImplCopyWith<$Res> {
  __$$DeletePostEventImplCopyWithImpl(
      _$DeletePostEventImpl _value, $Res Function(_$DeletePostEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
  }) {
    return _then(_$DeletePostEventImpl(
      null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeletePostEventImpl implements _DeletePostEvent {
  const _$DeletePostEventImpl(this.postId);

  @override
  final String postId;

  @override
  String toString() {
    return 'PostEvent.deletePost(postId: $postId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePostEventImpl &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletePostEventImplCopyWith<_$DeletePostEventImpl> get copyWith =>
      __$$DeletePostEventImplCopyWithImpl<_$DeletePostEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? categoryId) getCategories,
    required TResult Function() getPosts,
    required TResult Function(CreatePostPayload postData) createPost,
    required TResult Function(String postId) getPostDetails,
    required TResult Function(String postId) deletePost,
    required TResult Function(String postId, String action) postReaction,
    required TResult Function(String postId, String reason) reportPost,
    required TResult Function() getPolls,
    required TResult Function(String postId) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return deletePost(postId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? categoryId)? getCategories,
    TResult? Function()? getPosts,
    TResult? Function(CreatePostPayload postData)? createPost,
    TResult? Function(String postId)? getPostDetails,
    TResult? Function(String postId)? deletePost,
    TResult? Function(String postId, String action)? postReaction,
    TResult? Function(String postId, String reason)? reportPost,
    TResult? Function()? getPolls,
    TResult? Function(String postId)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return deletePost?.call(postId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? categoryId)? getCategories,
    TResult Function()? getPosts,
    TResult Function(CreatePostPayload postData)? createPost,
    TResult Function(String postId)? getPostDetails,
    TResult Function(String postId)? deletePost,
    TResult Function(String postId, String action)? postReaction,
    TResult Function(String postId, String reason)? reportPost,
    TResult Function()? getPolls,
    TResult Function(String postId)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (deletePost != null) {
      return deletePost(postId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCategoriesEvent value) getCategories,
    required TResult Function(_GetPostsEvent value) getPosts,
    required TResult Function(_CreatePostEvent value) createPost,
    required TResult Function(_GetPostDetailsEvent value) getPostDetails,
    required TResult Function(_DeletePostEvent value) deletePost,
    required TResult Function(_PostReactionEvent value) postReaction,
    required TResult Function(ReportPostEvent value) reportPost,
    required TResult Function(_GetPollsEvent value) getPolls,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return deletePost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCategoriesEvent value)? getCategories,
    TResult? Function(_GetPostsEvent value)? getPosts,
    TResult? Function(_CreatePostEvent value)? createPost,
    TResult? Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult? Function(_DeletePostEvent value)? deletePost,
    TResult? Function(_PostReactionEvent value)? postReaction,
    TResult? Function(ReportPostEvent value)? reportPost,
    TResult? Function(_GetPollsEvent value)? getPolls,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return deletePost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCategoriesEvent value)? getCategories,
    TResult Function(_GetPostsEvent value)? getPosts,
    TResult Function(_CreatePostEvent value)? createPost,
    TResult Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult Function(_DeletePostEvent value)? deletePost,
    TResult Function(_PostReactionEvent value)? postReaction,
    TResult Function(ReportPostEvent value)? reportPost,
    TResult Function(_GetPollsEvent value)? getPolls,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (deletePost != null) {
      return deletePost(this);
    }
    return orElse();
  }
}

abstract class _DeletePostEvent implements PostEvent {
  const factory _DeletePostEvent(final String postId) = _$DeletePostEventImpl;

  String get postId;
  @JsonKey(ignore: true)
  _$$DeletePostEventImplCopyWith<_$DeletePostEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostReactionEventImplCopyWith<$Res> {
  factory _$$PostReactionEventImplCopyWith(_$PostReactionEventImpl value,
          $Res Function(_$PostReactionEventImpl) then) =
      __$$PostReactionEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId, String action});
}

/// @nodoc
class __$$PostReactionEventImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$PostReactionEventImpl>
    implements _$$PostReactionEventImplCopyWith<$Res> {
  __$$PostReactionEventImplCopyWithImpl(_$PostReactionEventImpl _value,
      $Res Function(_$PostReactionEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? action = null,
  }) {
    return _then(_$PostReactionEventImpl(
      null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PostReactionEventImpl implements _PostReactionEvent {
  const _$PostReactionEventImpl(this.postId, this.action);

  @override
  final String postId;
  @override
  final String action;

  @override
  String toString() {
    return 'PostEvent.postReaction(postId: $postId, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostReactionEventImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.action, action) || other.action == action));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, action);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostReactionEventImplCopyWith<_$PostReactionEventImpl> get copyWith =>
      __$$PostReactionEventImplCopyWithImpl<_$PostReactionEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? categoryId) getCategories,
    required TResult Function() getPosts,
    required TResult Function(CreatePostPayload postData) createPost,
    required TResult Function(String postId) getPostDetails,
    required TResult Function(String postId) deletePost,
    required TResult Function(String postId, String action) postReaction,
    required TResult Function(String postId, String reason) reportPost,
    required TResult Function() getPolls,
    required TResult Function(String postId) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return postReaction(postId, action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? categoryId)? getCategories,
    TResult? Function()? getPosts,
    TResult? Function(CreatePostPayload postData)? createPost,
    TResult? Function(String postId)? getPostDetails,
    TResult? Function(String postId)? deletePost,
    TResult? Function(String postId, String action)? postReaction,
    TResult? Function(String postId, String reason)? reportPost,
    TResult? Function()? getPolls,
    TResult? Function(String postId)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return postReaction?.call(postId, action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? categoryId)? getCategories,
    TResult Function()? getPosts,
    TResult Function(CreatePostPayload postData)? createPost,
    TResult Function(String postId)? getPostDetails,
    TResult Function(String postId)? deletePost,
    TResult Function(String postId, String action)? postReaction,
    TResult Function(String postId, String reason)? reportPost,
    TResult Function()? getPolls,
    TResult Function(String postId)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (postReaction != null) {
      return postReaction(postId, action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCategoriesEvent value) getCategories,
    required TResult Function(_GetPostsEvent value) getPosts,
    required TResult Function(_CreatePostEvent value) createPost,
    required TResult Function(_GetPostDetailsEvent value) getPostDetails,
    required TResult Function(_DeletePostEvent value) deletePost,
    required TResult Function(_PostReactionEvent value) postReaction,
    required TResult Function(ReportPostEvent value) reportPost,
    required TResult Function(_GetPollsEvent value) getPolls,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return postReaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCategoriesEvent value)? getCategories,
    TResult? Function(_GetPostsEvent value)? getPosts,
    TResult? Function(_CreatePostEvent value)? createPost,
    TResult? Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult? Function(_DeletePostEvent value)? deletePost,
    TResult? Function(_PostReactionEvent value)? postReaction,
    TResult? Function(ReportPostEvent value)? reportPost,
    TResult? Function(_GetPollsEvent value)? getPolls,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return postReaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCategoriesEvent value)? getCategories,
    TResult Function(_GetPostsEvent value)? getPosts,
    TResult Function(_CreatePostEvent value)? createPost,
    TResult Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult Function(_DeletePostEvent value)? deletePost,
    TResult Function(_PostReactionEvent value)? postReaction,
    TResult Function(ReportPostEvent value)? reportPost,
    TResult Function(_GetPollsEvent value)? getPolls,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (postReaction != null) {
      return postReaction(this);
    }
    return orElse();
  }
}

abstract class _PostReactionEvent implements PostEvent {
  const factory _PostReactionEvent(final String postId, final String action) =
      _$PostReactionEventImpl;

  String get postId;
  String get action;
  @JsonKey(ignore: true)
  _$$PostReactionEventImplCopyWith<_$PostReactionEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReportPostEventImplCopyWith<$Res> {
  factory _$$ReportPostEventImplCopyWith(_$ReportPostEventImpl value,
          $Res Function(_$ReportPostEventImpl) then) =
      __$$ReportPostEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId, String reason});
}

/// @nodoc
class __$$ReportPostEventImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$ReportPostEventImpl>
    implements _$$ReportPostEventImplCopyWith<$Res> {
  __$$ReportPostEventImplCopyWithImpl(
      _$ReportPostEventImpl _value, $Res Function(_$ReportPostEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? reason = null,
  }) {
    return _then(_$ReportPostEventImpl(
      null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ReportPostEventImpl implements ReportPostEvent {
  const _$ReportPostEventImpl(this.postId, this.reason);

  @override
  final String postId;
  @override
  final String reason;

  @override
  String toString() {
    return 'PostEvent.reportPost(postId: $postId, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportPostEventImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportPostEventImplCopyWith<_$ReportPostEventImpl> get copyWith =>
      __$$ReportPostEventImplCopyWithImpl<_$ReportPostEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? categoryId) getCategories,
    required TResult Function() getPosts,
    required TResult Function(CreatePostPayload postData) createPost,
    required TResult Function(String postId) getPostDetails,
    required TResult Function(String postId) deletePost,
    required TResult Function(String postId, String action) postReaction,
    required TResult Function(String postId, String reason) reportPost,
    required TResult Function() getPolls,
    required TResult Function(String postId) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return reportPost(postId, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? categoryId)? getCategories,
    TResult? Function()? getPosts,
    TResult? Function(CreatePostPayload postData)? createPost,
    TResult? Function(String postId)? getPostDetails,
    TResult? Function(String postId)? deletePost,
    TResult? Function(String postId, String action)? postReaction,
    TResult? Function(String postId, String reason)? reportPost,
    TResult? Function()? getPolls,
    TResult? Function(String postId)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return reportPost?.call(postId, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? categoryId)? getCategories,
    TResult Function()? getPosts,
    TResult Function(CreatePostPayload postData)? createPost,
    TResult Function(String postId)? getPostDetails,
    TResult Function(String postId)? deletePost,
    TResult Function(String postId, String action)? postReaction,
    TResult Function(String postId, String reason)? reportPost,
    TResult Function()? getPolls,
    TResult Function(String postId)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (reportPost != null) {
      return reportPost(postId, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCategoriesEvent value) getCategories,
    required TResult Function(_GetPostsEvent value) getPosts,
    required TResult Function(_CreatePostEvent value) createPost,
    required TResult Function(_GetPostDetailsEvent value) getPostDetails,
    required TResult Function(_DeletePostEvent value) deletePost,
    required TResult Function(_PostReactionEvent value) postReaction,
    required TResult Function(ReportPostEvent value) reportPost,
    required TResult Function(_GetPollsEvent value) getPolls,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return reportPost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCategoriesEvent value)? getCategories,
    TResult? Function(_GetPostsEvent value)? getPosts,
    TResult? Function(_CreatePostEvent value)? createPost,
    TResult? Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult? Function(_DeletePostEvent value)? deletePost,
    TResult? Function(_PostReactionEvent value)? postReaction,
    TResult? Function(ReportPostEvent value)? reportPost,
    TResult? Function(_GetPollsEvent value)? getPolls,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return reportPost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCategoriesEvent value)? getCategories,
    TResult Function(_GetPostsEvent value)? getPosts,
    TResult Function(_CreatePostEvent value)? createPost,
    TResult Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult Function(_DeletePostEvent value)? deletePost,
    TResult Function(_PostReactionEvent value)? postReaction,
    TResult Function(ReportPostEvent value)? reportPost,
    TResult Function(_GetPollsEvent value)? getPolls,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (reportPost != null) {
      return reportPost(this);
    }
    return orElse();
  }
}

abstract class ReportPostEvent implements PostEvent {
  const factory ReportPostEvent(final String postId, final String reason) =
      _$ReportPostEventImpl;

  String get postId;
  String get reason;
  @JsonKey(ignore: true)
  _$$ReportPostEventImplCopyWith<_$ReportPostEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetPollsEventImplCopyWith<$Res> {
  factory _$$GetPollsEventImplCopyWith(
          _$GetPollsEventImpl value, $Res Function(_$GetPollsEventImpl) then) =
      __$$GetPollsEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetPollsEventImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$GetPollsEventImpl>
    implements _$$GetPollsEventImplCopyWith<$Res> {
  __$$GetPollsEventImplCopyWithImpl(
      _$GetPollsEventImpl _value, $Res Function(_$GetPollsEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetPollsEventImpl implements _GetPollsEvent {
  const _$GetPollsEventImpl();

  @override
  String toString() {
    return 'PostEvent.getPolls()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetPollsEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? categoryId) getCategories,
    required TResult Function() getPosts,
    required TResult Function(CreatePostPayload postData) createPost,
    required TResult Function(String postId) getPostDetails,
    required TResult Function(String postId) deletePost,
    required TResult Function(String postId, String action) postReaction,
    required TResult Function(String postId, String reason) reportPost,
    required TResult Function() getPolls,
    required TResult Function(String postId) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return getPolls();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? categoryId)? getCategories,
    TResult? Function()? getPosts,
    TResult? Function(CreatePostPayload postData)? createPost,
    TResult? Function(String postId)? getPostDetails,
    TResult? Function(String postId)? deletePost,
    TResult? Function(String postId, String action)? postReaction,
    TResult? Function(String postId, String reason)? reportPost,
    TResult? Function()? getPolls,
    TResult? Function(String postId)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return getPolls?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? categoryId)? getCategories,
    TResult Function()? getPosts,
    TResult Function(CreatePostPayload postData)? createPost,
    TResult Function(String postId)? getPostDetails,
    TResult Function(String postId)? deletePost,
    TResult Function(String postId, String action)? postReaction,
    TResult Function(String postId, String reason)? reportPost,
    TResult Function()? getPolls,
    TResult Function(String postId)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (getPolls != null) {
      return getPolls();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCategoriesEvent value) getCategories,
    required TResult Function(_GetPostsEvent value) getPosts,
    required TResult Function(_CreatePostEvent value) createPost,
    required TResult Function(_GetPostDetailsEvent value) getPostDetails,
    required TResult Function(_DeletePostEvent value) deletePost,
    required TResult Function(_PostReactionEvent value) postReaction,
    required TResult Function(ReportPostEvent value) reportPost,
    required TResult Function(_GetPollsEvent value) getPolls,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return getPolls(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCategoriesEvent value)? getCategories,
    TResult? Function(_GetPostsEvent value)? getPosts,
    TResult? Function(_CreatePostEvent value)? createPost,
    TResult? Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult? Function(_DeletePostEvent value)? deletePost,
    TResult? Function(_PostReactionEvent value)? postReaction,
    TResult? Function(ReportPostEvent value)? reportPost,
    TResult? Function(_GetPollsEvent value)? getPolls,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return getPolls?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCategoriesEvent value)? getCategories,
    TResult Function(_GetPostsEvent value)? getPosts,
    TResult Function(_CreatePostEvent value)? createPost,
    TResult Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult Function(_DeletePostEvent value)? deletePost,
    TResult Function(_PostReactionEvent value)? postReaction,
    TResult Function(ReportPostEvent value)? reportPost,
    TResult Function(_GetPollsEvent value)? getPolls,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (getPolls != null) {
      return getPolls(this);
    }
    return orElse();
  }
}

abstract class _GetPollsEvent implements PostEvent {
  const factory _GetPollsEvent() = _$GetPollsEventImpl;
}

/// @nodoc
abstract class _$$GetCommentsEventImplCopyWith<$Res> {
  factory _$$GetCommentsEventImplCopyWith(_$GetCommentsEventImpl value,
          $Res Function(_$GetCommentsEventImpl) then) =
      __$$GetCommentsEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId});
}

/// @nodoc
class __$$GetCommentsEventImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$GetCommentsEventImpl>
    implements _$$GetCommentsEventImplCopyWith<$Res> {
  __$$GetCommentsEventImplCopyWithImpl(_$GetCommentsEventImpl _value,
      $Res Function(_$GetCommentsEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
  }) {
    return _then(_$GetCommentsEventImpl(
      null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetCommentsEventImpl implements _GetCommentsEvent {
  const _$GetCommentsEventImpl(this.postId);

  @override
  final String postId;

  @override
  String toString() {
    return 'PostEvent.getComments(postId: $postId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCommentsEventImpl &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCommentsEventImplCopyWith<_$GetCommentsEventImpl> get copyWith =>
      __$$GetCommentsEventImplCopyWithImpl<_$GetCommentsEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? categoryId) getCategories,
    required TResult Function() getPosts,
    required TResult Function(CreatePostPayload postData) createPost,
    required TResult Function(String postId) getPostDetails,
    required TResult Function(String postId) deletePost,
    required TResult Function(String postId, String action) postReaction,
    required TResult Function(String postId, String reason) reportPost,
    required TResult Function() getPolls,
    required TResult Function(String postId) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return getComments(postId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? categoryId)? getCategories,
    TResult? Function()? getPosts,
    TResult? Function(CreatePostPayload postData)? createPost,
    TResult? Function(String postId)? getPostDetails,
    TResult? Function(String postId)? deletePost,
    TResult? Function(String postId, String action)? postReaction,
    TResult? Function(String postId, String reason)? reportPost,
    TResult? Function()? getPolls,
    TResult? Function(String postId)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return getComments?.call(postId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? categoryId)? getCategories,
    TResult Function()? getPosts,
    TResult Function(CreatePostPayload postData)? createPost,
    TResult Function(String postId)? getPostDetails,
    TResult Function(String postId)? deletePost,
    TResult Function(String postId, String action)? postReaction,
    TResult Function(String postId, String reason)? reportPost,
    TResult Function()? getPolls,
    TResult Function(String postId)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (getComments != null) {
      return getComments(postId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCategoriesEvent value) getCategories,
    required TResult Function(_GetPostsEvent value) getPosts,
    required TResult Function(_CreatePostEvent value) createPost,
    required TResult Function(_GetPostDetailsEvent value) getPostDetails,
    required TResult Function(_DeletePostEvent value) deletePost,
    required TResult Function(_PostReactionEvent value) postReaction,
    required TResult Function(ReportPostEvent value) reportPost,
    required TResult Function(_GetPollsEvent value) getPolls,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return getComments(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCategoriesEvent value)? getCategories,
    TResult? Function(_GetPostsEvent value)? getPosts,
    TResult? Function(_CreatePostEvent value)? createPost,
    TResult? Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult? Function(_DeletePostEvent value)? deletePost,
    TResult? Function(_PostReactionEvent value)? postReaction,
    TResult? Function(ReportPostEvent value)? reportPost,
    TResult? Function(_GetPollsEvent value)? getPolls,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return getComments?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCategoriesEvent value)? getCategories,
    TResult Function(_GetPostsEvent value)? getPosts,
    TResult Function(_CreatePostEvent value)? createPost,
    TResult Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult Function(_DeletePostEvent value)? deletePost,
    TResult Function(_PostReactionEvent value)? postReaction,
    TResult Function(ReportPostEvent value)? reportPost,
    TResult Function(_GetPollsEvent value)? getPolls,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (getComments != null) {
      return getComments(this);
    }
    return orElse();
  }
}

abstract class _GetCommentsEvent implements PostEvent {
  const factory _GetCommentsEvent(final String postId) = _$GetCommentsEventImpl;

  String get postId;
  @JsonKey(ignore: true)
  _$$GetCommentsEventImplCopyWith<_$GetCommentsEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetACommentEventImplCopyWith<$Res> {
  factory _$$GetACommentEventImplCopyWith(_$GetACommentEventImpl value,
          $Res Function(_$GetACommentEventImpl) then) =
      __$$GetACommentEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String commentId});
}

/// @nodoc
class __$$GetACommentEventImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$GetACommentEventImpl>
    implements _$$GetACommentEventImplCopyWith<$Res> {
  __$$GetACommentEventImplCopyWithImpl(_$GetACommentEventImpl _value,
      $Res Function(_$GetACommentEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = null,
  }) {
    return _then(_$GetACommentEventImpl(
      null == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetACommentEventImpl implements _GetACommentEvent {
  const _$GetACommentEventImpl(this.commentId);

  @override
  final String commentId;

  @override
  String toString() {
    return 'PostEvent.getAComment(commentId: $commentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetACommentEventImpl &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, commentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetACommentEventImplCopyWith<_$GetACommentEventImpl> get copyWith =>
      __$$GetACommentEventImplCopyWithImpl<_$GetACommentEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? categoryId) getCategories,
    required TResult Function() getPosts,
    required TResult Function(CreatePostPayload postData) createPost,
    required TResult Function(String postId) getPostDetails,
    required TResult Function(String postId) deletePost,
    required TResult Function(String postId, String action) postReaction,
    required TResult Function(String postId, String reason) reportPost,
    required TResult Function() getPolls,
    required TResult Function(String postId) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return getAComment(commentId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? categoryId)? getCategories,
    TResult? Function()? getPosts,
    TResult? Function(CreatePostPayload postData)? createPost,
    TResult? Function(String postId)? getPostDetails,
    TResult? Function(String postId)? deletePost,
    TResult? Function(String postId, String action)? postReaction,
    TResult? Function(String postId, String reason)? reportPost,
    TResult? Function()? getPolls,
    TResult? Function(String postId)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return getAComment?.call(commentId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? categoryId)? getCategories,
    TResult Function()? getPosts,
    TResult Function(CreatePostPayload postData)? createPost,
    TResult Function(String postId)? getPostDetails,
    TResult Function(String postId)? deletePost,
    TResult Function(String postId, String action)? postReaction,
    TResult Function(String postId, String reason)? reportPost,
    TResult Function()? getPolls,
    TResult Function(String postId)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (getAComment != null) {
      return getAComment(commentId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCategoriesEvent value) getCategories,
    required TResult Function(_GetPostsEvent value) getPosts,
    required TResult Function(_CreatePostEvent value) createPost,
    required TResult Function(_GetPostDetailsEvent value) getPostDetails,
    required TResult Function(_DeletePostEvent value) deletePost,
    required TResult Function(_PostReactionEvent value) postReaction,
    required TResult Function(ReportPostEvent value) reportPost,
    required TResult Function(_GetPollsEvent value) getPolls,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return getAComment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCategoriesEvent value)? getCategories,
    TResult? Function(_GetPostsEvent value)? getPosts,
    TResult? Function(_CreatePostEvent value)? createPost,
    TResult? Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult? Function(_DeletePostEvent value)? deletePost,
    TResult? Function(_PostReactionEvent value)? postReaction,
    TResult? Function(ReportPostEvent value)? reportPost,
    TResult? Function(_GetPollsEvent value)? getPolls,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return getAComment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCategoriesEvent value)? getCategories,
    TResult Function(_GetPostsEvent value)? getPosts,
    TResult Function(_CreatePostEvent value)? createPost,
    TResult Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult Function(_DeletePostEvent value)? deletePost,
    TResult Function(_PostReactionEvent value)? postReaction,
    TResult Function(ReportPostEvent value)? reportPost,
    TResult Function(_GetPollsEvent value)? getPolls,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (getAComment != null) {
      return getAComment(this);
    }
    return orElse();
  }
}

abstract class _GetACommentEvent implements PostEvent {
  const factory _GetACommentEvent(final String commentId) =
      _$GetACommentEventImpl;

  String get commentId;
  @JsonKey(ignore: true)
  _$$GetACommentEventImplCopyWith<_$GetACommentEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveACommentEventImplCopyWith<$Res> {
  factory _$$SaveACommentEventImplCopyWith(_$SaveACommentEventImpl value,
          $Res Function(_$SaveACommentEventImpl) then) =
      __$$SaveACommentEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SaveCommentPayload payload});
}

/// @nodoc
class __$$SaveACommentEventImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$SaveACommentEventImpl>
    implements _$$SaveACommentEventImplCopyWith<$Res> {
  __$$SaveACommentEventImplCopyWithImpl(_$SaveACommentEventImpl _value,
      $Res Function(_$SaveACommentEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payload = null,
  }) {
    return _then(_$SaveACommentEventImpl(
      null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as SaveCommentPayload,
    ));
  }
}

/// @nodoc

class _$SaveACommentEventImpl implements _SaveACommentEvent {
  const _$SaveACommentEventImpl(this.payload);

  @override
  final SaveCommentPayload payload;

  @override
  String toString() {
    return 'PostEvent.saveAComment(payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveACommentEventImpl &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @override
  int get hashCode => Object.hash(runtimeType, payload);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveACommentEventImplCopyWith<_$SaveACommentEventImpl> get copyWith =>
      __$$SaveACommentEventImplCopyWithImpl<_$SaveACommentEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? categoryId) getCategories,
    required TResult Function() getPosts,
    required TResult Function(CreatePostPayload postData) createPost,
    required TResult Function(String postId) getPostDetails,
    required TResult Function(String postId) deletePost,
    required TResult Function(String postId, String action) postReaction,
    required TResult Function(String postId, String reason) reportPost,
    required TResult Function() getPolls,
    required TResult Function(String postId) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return saveAComment(payload);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? categoryId)? getCategories,
    TResult? Function()? getPosts,
    TResult? Function(CreatePostPayload postData)? createPost,
    TResult? Function(String postId)? getPostDetails,
    TResult? Function(String postId)? deletePost,
    TResult? Function(String postId, String action)? postReaction,
    TResult? Function(String postId, String reason)? reportPost,
    TResult? Function()? getPolls,
    TResult? Function(String postId)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return saveAComment?.call(payload);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? categoryId)? getCategories,
    TResult Function()? getPosts,
    TResult Function(CreatePostPayload postData)? createPost,
    TResult Function(String postId)? getPostDetails,
    TResult Function(String postId)? deletePost,
    TResult Function(String postId, String action)? postReaction,
    TResult Function(String postId, String reason)? reportPost,
    TResult Function()? getPolls,
    TResult Function(String postId)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (saveAComment != null) {
      return saveAComment(payload);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCategoriesEvent value) getCategories,
    required TResult Function(_GetPostsEvent value) getPosts,
    required TResult Function(_CreatePostEvent value) createPost,
    required TResult Function(_GetPostDetailsEvent value) getPostDetails,
    required TResult Function(_DeletePostEvent value) deletePost,
    required TResult Function(_PostReactionEvent value) postReaction,
    required TResult Function(ReportPostEvent value) reportPost,
    required TResult Function(_GetPollsEvent value) getPolls,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return saveAComment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCategoriesEvent value)? getCategories,
    TResult? Function(_GetPostsEvent value)? getPosts,
    TResult? Function(_CreatePostEvent value)? createPost,
    TResult? Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult? Function(_DeletePostEvent value)? deletePost,
    TResult? Function(_PostReactionEvent value)? postReaction,
    TResult? Function(ReportPostEvent value)? reportPost,
    TResult? Function(_GetPollsEvent value)? getPolls,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return saveAComment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCategoriesEvent value)? getCategories,
    TResult Function(_GetPostsEvent value)? getPosts,
    TResult Function(_CreatePostEvent value)? createPost,
    TResult Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult Function(_DeletePostEvent value)? deletePost,
    TResult Function(_PostReactionEvent value)? postReaction,
    TResult Function(ReportPostEvent value)? reportPost,
    TResult Function(_GetPollsEvent value)? getPolls,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (saveAComment != null) {
      return saveAComment(this);
    }
    return orElse();
  }
}

abstract class _SaveACommentEvent implements PostEvent {
  const factory _SaveACommentEvent(final SaveCommentPayload payload) =
      _$SaveACommentEventImpl;

  SaveCommentPayload get payload;
  @JsonKey(ignore: true)
  _$$SaveACommentEventImplCopyWith<_$SaveACommentEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteCommentEventImplCopyWith<$Res> {
  factory _$$DeleteCommentEventImplCopyWith(_$DeleteCommentEventImpl value,
          $Res Function(_$DeleteCommentEventImpl) then) =
      __$$DeleteCommentEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String commentId});
}

/// @nodoc
class __$$DeleteCommentEventImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$DeleteCommentEventImpl>
    implements _$$DeleteCommentEventImplCopyWith<$Res> {
  __$$DeleteCommentEventImplCopyWithImpl(_$DeleteCommentEventImpl _value,
      $Res Function(_$DeleteCommentEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = null,
  }) {
    return _then(_$DeleteCommentEventImpl(
      null == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteCommentEventImpl implements _DeleteCommentEvent {
  const _$DeleteCommentEventImpl(this.commentId);

  @override
  final String commentId;

  @override
  String toString() {
    return 'PostEvent.deleteComment(commentId: $commentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCommentEventImpl &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, commentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCommentEventImplCopyWith<_$DeleteCommentEventImpl> get copyWith =>
      __$$DeleteCommentEventImplCopyWithImpl<_$DeleteCommentEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? categoryId) getCategories,
    required TResult Function() getPosts,
    required TResult Function(CreatePostPayload postData) createPost,
    required TResult Function(String postId) getPostDetails,
    required TResult Function(String postId) deletePost,
    required TResult Function(String postId, String action) postReaction,
    required TResult Function(String postId, String reason) reportPost,
    required TResult Function() getPolls,
    required TResult Function(String postId) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return deleteComment(commentId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? categoryId)? getCategories,
    TResult? Function()? getPosts,
    TResult? Function(CreatePostPayload postData)? createPost,
    TResult? Function(String postId)? getPostDetails,
    TResult? Function(String postId)? deletePost,
    TResult? Function(String postId, String action)? postReaction,
    TResult? Function(String postId, String reason)? reportPost,
    TResult? Function()? getPolls,
    TResult? Function(String postId)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return deleteComment?.call(commentId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? categoryId)? getCategories,
    TResult Function()? getPosts,
    TResult Function(CreatePostPayload postData)? createPost,
    TResult Function(String postId)? getPostDetails,
    TResult Function(String postId)? deletePost,
    TResult Function(String postId, String action)? postReaction,
    TResult Function(String postId, String reason)? reportPost,
    TResult Function()? getPolls,
    TResult Function(String postId)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (deleteComment != null) {
      return deleteComment(commentId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCategoriesEvent value) getCategories,
    required TResult Function(_GetPostsEvent value) getPosts,
    required TResult Function(_CreatePostEvent value) createPost,
    required TResult Function(_GetPostDetailsEvent value) getPostDetails,
    required TResult Function(_DeletePostEvent value) deletePost,
    required TResult Function(_PostReactionEvent value) postReaction,
    required TResult Function(ReportPostEvent value) reportPost,
    required TResult Function(_GetPollsEvent value) getPolls,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return deleteComment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCategoriesEvent value)? getCategories,
    TResult? Function(_GetPostsEvent value)? getPosts,
    TResult? Function(_CreatePostEvent value)? createPost,
    TResult? Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult? Function(_DeletePostEvent value)? deletePost,
    TResult? Function(_PostReactionEvent value)? postReaction,
    TResult? Function(ReportPostEvent value)? reportPost,
    TResult? Function(_GetPollsEvent value)? getPolls,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return deleteComment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCategoriesEvent value)? getCategories,
    TResult Function(_GetPostsEvent value)? getPosts,
    TResult Function(_CreatePostEvent value)? createPost,
    TResult Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult Function(_DeletePostEvent value)? deletePost,
    TResult Function(_PostReactionEvent value)? postReaction,
    TResult Function(ReportPostEvent value)? reportPost,
    TResult Function(_GetPollsEvent value)? getPolls,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (deleteComment != null) {
      return deleteComment(this);
    }
    return orElse();
  }
}

abstract class _DeleteCommentEvent implements PostEvent {
  const factory _DeleteCommentEvent(final String commentId) =
      _$DeleteCommentEventImpl;

  String get commentId;
  @JsonKey(ignore: true)
  _$$DeleteCommentEventImplCopyWith<_$DeleteCommentEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CommentReactionEventImplCopyWith<$Res> {
  factory _$$CommentReactionEventImplCopyWith(_$CommentReactionEventImpl value,
          $Res Function(_$CommentReactionEventImpl) then) =
      __$$CommentReactionEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String commentId, String action});
}

/// @nodoc
class __$$CommentReactionEventImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$CommentReactionEventImpl>
    implements _$$CommentReactionEventImplCopyWith<$Res> {
  __$$CommentReactionEventImplCopyWithImpl(_$CommentReactionEventImpl _value,
      $Res Function(_$CommentReactionEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = null,
    Object? action = null,
  }) {
    return _then(_$CommentReactionEventImpl(
      null == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
      null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CommentReactionEventImpl implements _CommentReactionEvent {
  const _$CommentReactionEventImpl(this.commentId, this.action);

  @override
  final String commentId;
  @override
  final String action;

  @override
  String toString() {
    return 'PostEvent.commentReaction(commentId: $commentId, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentReactionEventImpl &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.action, action) || other.action == action));
  }

  @override
  int get hashCode => Object.hash(runtimeType, commentId, action);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentReactionEventImplCopyWith<_$CommentReactionEventImpl>
      get copyWith =>
          __$$CommentReactionEventImplCopyWithImpl<_$CommentReactionEventImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? categoryId) getCategories,
    required TResult Function() getPosts,
    required TResult Function(CreatePostPayload postData) createPost,
    required TResult Function(String postId) getPostDetails,
    required TResult Function(String postId) deletePost,
    required TResult Function(String postId, String action) postReaction,
    required TResult Function(String postId, String reason) reportPost,
    required TResult Function() getPolls,
    required TResult Function(String postId) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return commentReaction(commentId, action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? categoryId)? getCategories,
    TResult? Function()? getPosts,
    TResult? Function(CreatePostPayload postData)? createPost,
    TResult? Function(String postId)? getPostDetails,
    TResult? Function(String postId)? deletePost,
    TResult? Function(String postId, String action)? postReaction,
    TResult? Function(String postId, String reason)? reportPost,
    TResult? Function()? getPolls,
    TResult? Function(String postId)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return commentReaction?.call(commentId, action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? categoryId)? getCategories,
    TResult Function()? getPosts,
    TResult Function(CreatePostPayload postData)? createPost,
    TResult Function(String postId)? getPostDetails,
    TResult Function(String postId)? deletePost,
    TResult Function(String postId, String action)? postReaction,
    TResult Function(String postId, String reason)? reportPost,
    TResult Function()? getPolls,
    TResult Function(String postId)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (commentReaction != null) {
      return commentReaction(commentId, action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCategoriesEvent value) getCategories,
    required TResult Function(_GetPostsEvent value) getPosts,
    required TResult Function(_CreatePostEvent value) createPost,
    required TResult Function(_GetPostDetailsEvent value) getPostDetails,
    required TResult Function(_DeletePostEvent value) deletePost,
    required TResult Function(_PostReactionEvent value) postReaction,
    required TResult Function(ReportPostEvent value) reportPost,
    required TResult Function(_GetPollsEvent value) getPolls,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return commentReaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCategoriesEvent value)? getCategories,
    TResult? Function(_GetPostsEvent value)? getPosts,
    TResult? Function(_CreatePostEvent value)? createPost,
    TResult? Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult? Function(_DeletePostEvent value)? deletePost,
    TResult? Function(_PostReactionEvent value)? postReaction,
    TResult? Function(ReportPostEvent value)? reportPost,
    TResult? Function(_GetPollsEvent value)? getPolls,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return commentReaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCategoriesEvent value)? getCategories,
    TResult Function(_GetPostsEvent value)? getPosts,
    TResult Function(_CreatePostEvent value)? createPost,
    TResult Function(_GetPostDetailsEvent value)? getPostDetails,
    TResult Function(_DeletePostEvent value)? deletePost,
    TResult Function(_PostReactionEvent value)? postReaction,
    TResult Function(ReportPostEvent value)? reportPost,
    TResult Function(_GetPollsEvent value)? getPolls,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (commentReaction != null) {
      return commentReaction(this);
    }
    return orElse();
  }
}

abstract class _CommentReactionEvent implements PostEvent {
  const factory _CommentReactionEvent(
      final String commentId, final String action) = _$CommentReactionEventImpl;

  String get commentId;
  String get action;
  @JsonKey(ignore: true)
  _$$CommentReactionEventImplCopyWith<_$CommentReactionEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PostState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostStateCopyWith<$Res> {
  factory $PostStateCopyWith(PostState value, $Res Function(PostState) then) =
      _$PostStateCopyWithImpl<$Res, PostState>;
}

/// @nodoc
class _$PostStateCopyWithImpl<$Res, $Val extends PostState>
    implements $PostStateCopyWith<$Res> {
  _$PostStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PostInitialImplCopyWith<$Res> {
  factory _$$PostInitialImplCopyWith(
          _$PostInitialImpl value, $Res Function(_$PostInitialImpl) then) =
      __$$PostInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PostInitialImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$PostInitialImpl>
    implements _$$PostInitialImplCopyWith<$Res> {
  __$$PostInitialImplCopyWithImpl(
      _$PostInitialImpl _value, $Res Function(_$PostInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PostInitialImpl implements PostInitial {
  const _$PostInitialImpl();

  @override
  String toString() {
    return 'PostState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PostInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PostInitial implements PostState {
  const factory PostInitial() = _$PostInitialImpl;
}

/// @nodoc
abstract class _$$GetCategoriesLoadingStateImplCopyWith<$Res> {
  factory _$$GetCategoriesLoadingStateImplCopyWith(
          _$GetCategoriesLoadingStateImpl value,
          $Res Function(_$GetCategoriesLoadingStateImpl) then) =
      __$$GetCategoriesLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetCategoriesLoadingStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetCategoriesLoadingStateImpl>
    implements _$$GetCategoriesLoadingStateImplCopyWith<$Res> {
  __$$GetCategoriesLoadingStateImplCopyWithImpl(
      _$GetCategoriesLoadingStateImpl _value,
      $Res Function(_$GetCategoriesLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetCategoriesLoadingStateImpl implements GetCategoriesLoadingState {
  const _$GetCategoriesLoadingStateImpl();

  @override
  String toString() {
    return 'PostState.getCategoriesLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCategoriesLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getCategoriesLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getCategoriesLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getCategoriesLoading != null) {
      return getCategoriesLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getCategoriesLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getCategoriesLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getCategoriesLoading != null) {
      return getCategoriesLoading(this);
    }
    return orElse();
  }
}

abstract class GetCategoriesLoadingState implements PostState {
  const factory GetCategoriesLoadingState() = _$GetCategoriesLoadingStateImpl;
}

/// @nodoc
abstract class _$$GetCategoriesSuccessStateImplCopyWith<$Res> {
  factory _$$GetCategoriesSuccessStateImplCopyWith(
          _$GetCategoriesSuccessStateImpl value,
          $Res Function(_$GetCategoriesSuccessStateImpl) then) =
      __$$GetCategoriesSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GetCategoriesResponse response});
}

/// @nodoc
class __$$GetCategoriesSuccessStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetCategoriesSuccessStateImpl>
    implements _$$GetCategoriesSuccessStateImplCopyWith<$Res> {
  __$$GetCategoriesSuccessStateImplCopyWithImpl(
      _$GetCategoriesSuccessStateImpl _value,
      $Res Function(_$GetCategoriesSuccessStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$GetCategoriesSuccessStateImpl(
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as GetCategoriesResponse,
    ));
  }
}

/// @nodoc

class _$GetCategoriesSuccessStateImpl implements GetCategoriesSuccessState {
  const _$GetCategoriesSuccessStateImpl(this.response);

  @override
  final GetCategoriesResponse response;

  @override
  String toString() {
    return 'PostState.getCategoriesSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCategoriesSuccessStateImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCategoriesSuccessStateImplCopyWith<_$GetCategoriesSuccessStateImpl>
      get copyWith => __$$GetCategoriesSuccessStateImplCopyWithImpl<
          _$GetCategoriesSuccessStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getCategoriesSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getCategoriesSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getCategoriesSuccess != null) {
      return getCategoriesSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getCategoriesSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getCategoriesSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getCategoriesSuccess != null) {
      return getCategoriesSuccess(this);
    }
    return orElse();
  }
}

abstract class GetCategoriesSuccessState implements PostState {
  const factory GetCategoriesSuccessState(
      final GetCategoriesResponse response) = _$GetCategoriesSuccessStateImpl;

  GetCategoriesResponse get response;
  @JsonKey(ignore: true)
  _$$GetCategoriesSuccessStateImplCopyWith<_$GetCategoriesSuccessStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetCategoriesFailureStateImplCopyWith<$Res> {
  factory _$$GetCategoriesFailureStateImplCopyWith(
          _$GetCategoriesFailureStateImpl value,
          $Res Function(_$GetCategoriesFailureStateImpl) then) =
      __$$GetCategoriesFailureStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$GetCategoriesFailureStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetCategoriesFailureStateImpl>
    implements _$$GetCategoriesFailureStateImplCopyWith<$Res> {
  __$$GetCategoriesFailureStateImplCopyWithImpl(
      _$GetCategoriesFailureStateImpl _value,
      $Res Function(_$GetCategoriesFailureStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$GetCategoriesFailureStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetCategoriesFailureStateImpl implements GetCategoriesFailureState {
  const _$GetCategoriesFailureStateImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PostState.getCategoriesFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCategoriesFailureStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCategoriesFailureStateImplCopyWith<_$GetCategoriesFailureStateImpl>
      get copyWith => __$$GetCategoriesFailureStateImplCopyWithImpl<
          _$GetCategoriesFailureStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getCategoriesFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getCategoriesFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getCategoriesFailure != null) {
      return getCategoriesFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getCategoriesFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getCategoriesFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getCategoriesFailure != null) {
      return getCategoriesFailure(this);
    }
    return orElse();
  }
}

abstract class GetCategoriesFailureState implements PostState {
  const factory GetCategoriesFailureState(final String error) =
      _$GetCategoriesFailureStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$GetCategoriesFailureStateImplCopyWith<_$GetCategoriesFailureStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetPostsLoadingStateImplCopyWith<$Res> {
  factory _$$GetPostsLoadingStateImplCopyWith(_$GetPostsLoadingStateImpl value,
          $Res Function(_$GetPostsLoadingStateImpl) then) =
      __$$GetPostsLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetPostsLoadingStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetPostsLoadingStateImpl>
    implements _$$GetPostsLoadingStateImplCopyWith<$Res> {
  __$$GetPostsLoadingStateImplCopyWithImpl(_$GetPostsLoadingStateImpl _value,
      $Res Function(_$GetPostsLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetPostsLoadingStateImpl implements GetPostsLoadingState {
  const _$GetPostsLoadingStateImpl();

  @override
  String toString() {
    return 'PostState.getPostsLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPostsLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getPostsLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getPostsLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPostsLoading != null) {
      return getPostsLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getPostsLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getPostsLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPostsLoading != null) {
      return getPostsLoading(this);
    }
    return orElse();
  }
}

abstract class GetPostsLoadingState implements PostState {
  const factory GetPostsLoadingState() = _$GetPostsLoadingStateImpl;
}

/// @nodoc
abstract class _$$GetPostsSuccessStateImplCopyWith<$Res> {
  factory _$$GetPostsSuccessStateImplCopyWith(_$GetPostsSuccessStateImpl value,
          $Res Function(_$GetPostsSuccessStateImpl) then) =
      __$$GetPostsSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GetPostsResponse response});
}

/// @nodoc
class __$$GetPostsSuccessStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetPostsSuccessStateImpl>
    implements _$$GetPostsSuccessStateImplCopyWith<$Res> {
  __$$GetPostsSuccessStateImplCopyWithImpl(_$GetPostsSuccessStateImpl _value,
      $Res Function(_$GetPostsSuccessStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$GetPostsSuccessStateImpl(
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as GetPostsResponse,
    ));
  }
}

/// @nodoc

class _$GetPostsSuccessStateImpl implements GetPostsSuccessState {
  const _$GetPostsSuccessStateImpl(this.response);

  @override
  final GetPostsResponse response;

  @override
  String toString() {
    return 'PostState.getPostsSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPostsSuccessStateImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPostsSuccessStateImplCopyWith<_$GetPostsSuccessStateImpl>
      get copyWith =>
          __$$GetPostsSuccessStateImplCopyWithImpl<_$GetPostsSuccessStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getPostsSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getPostsSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPostsSuccess != null) {
      return getPostsSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getPostsSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getPostsSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPostsSuccess != null) {
      return getPostsSuccess(this);
    }
    return orElse();
  }
}

abstract class GetPostsSuccessState implements PostState {
  const factory GetPostsSuccessState(final GetPostsResponse response) =
      _$GetPostsSuccessStateImpl;

  GetPostsResponse get response;
  @JsonKey(ignore: true)
  _$$GetPostsSuccessStateImplCopyWith<_$GetPostsSuccessStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetPostsFailureStateImplCopyWith<$Res> {
  factory _$$GetPostsFailureStateImplCopyWith(_$GetPostsFailureStateImpl value,
          $Res Function(_$GetPostsFailureStateImpl) then) =
      __$$GetPostsFailureStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$GetPostsFailureStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetPostsFailureStateImpl>
    implements _$$GetPostsFailureStateImplCopyWith<$Res> {
  __$$GetPostsFailureStateImplCopyWithImpl(_$GetPostsFailureStateImpl _value,
      $Res Function(_$GetPostsFailureStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$GetPostsFailureStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetPostsFailureStateImpl implements GetPostsFailureState {
  const _$GetPostsFailureStateImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PostState.getPostsFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPostsFailureStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPostsFailureStateImplCopyWith<_$GetPostsFailureStateImpl>
      get copyWith =>
          __$$GetPostsFailureStateImplCopyWithImpl<_$GetPostsFailureStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getPostsFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getPostsFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPostsFailure != null) {
      return getPostsFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getPostsFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getPostsFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPostsFailure != null) {
      return getPostsFailure(this);
    }
    return orElse();
  }
}

abstract class GetPostsFailureState implements PostState {
  const factory GetPostsFailureState(final String error) =
      _$GetPostsFailureStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$GetPostsFailureStateImplCopyWith<_$GetPostsFailureStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreatePostLoadingStateImplCopyWith<$Res> {
  factory _$$CreatePostLoadingStateImplCopyWith(
          _$CreatePostLoadingStateImpl value,
          $Res Function(_$CreatePostLoadingStateImpl) then) =
      __$$CreatePostLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreatePostLoadingStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$CreatePostLoadingStateImpl>
    implements _$$CreatePostLoadingStateImplCopyWith<$Res> {
  __$$CreatePostLoadingStateImplCopyWithImpl(
      _$CreatePostLoadingStateImpl _value,
      $Res Function(_$CreatePostLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CreatePostLoadingStateImpl implements CreatePostLoadingState {
  const _$CreatePostLoadingStateImpl();

  @override
  String toString() {
    return 'PostState.createPostLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePostLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return createPostLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return createPostLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (createPostLoading != null) {
      return createPostLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return createPostLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return createPostLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (createPostLoading != null) {
      return createPostLoading(this);
    }
    return orElse();
  }
}

abstract class CreatePostLoadingState implements PostState {
  const factory CreatePostLoadingState() = _$CreatePostLoadingStateImpl;
}

/// @nodoc
abstract class _$$CreatePostSuccessStateImplCopyWith<$Res> {
  factory _$$CreatePostSuccessStateImplCopyWith(
          _$CreatePostSuccessStateImpl value,
          $Res Function(_$CreatePostSuccessStateImpl) then) =
      __$$CreatePostSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CreatePostResponse response});
}

/// @nodoc
class __$$CreatePostSuccessStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$CreatePostSuccessStateImpl>
    implements _$$CreatePostSuccessStateImplCopyWith<$Res> {
  __$$CreatePostSuccessStateImplCopyWithImpl(
      _$CreatePostSuccessStateImpl _value,
      $Res Function(_$CreatePostSuccessStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$CreatePostSuccessStateImpl(
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as CreatePostResponse,
    ));
  }
}

/// @nodoc

class _$CreatePostSuccessStateImpl implements CreatePostSuccessState {
  const _$CreatePostSuccessStateImpl(this.response);

  @override
  final CreatePostResponse response;

  @override
  String toString() {
    return 'PostState.createPostSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePostSuccessStateImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePostSuccessStateImplCopyWith<_$CreatePostSuccessStateImpl>
      get copyWith => __$$CreatePostSuccessStateImplCopyWithImpl<
          _$CreatePostSuccessStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return createPostSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return createPostSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (createPostSuccess != null) {
      return createPostSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return createPostSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return createPostSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (createPostSuccess != null) {
      return createPostSuccess(this);
    }
    return orElse();
  }
}

abstract class CreatePostSuccessState implements PostState {
  const factory CreatePostSuccessState(final CreatePostResponse response) =
      _$CreatePostSuccessStateImpl;

  CreatePostResponse get response;
  @JsonKey(ignore: true)
  _$$CreatePostSuccessStateImplCopyWith<_$CreatePostSuccessStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreatePostFailureStateImplCopyWith<$Res> {
  factory _$$CreatePostFailureStateImplCopyWith(
          _$CreatePostFailureStateImpl value,
          $Res Function(_$CreatePostFailureStateImpl) then) =
      __$$CreatePostFailureStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$CreatePostFailureStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$CreatePostFailureStateImpl>
    implements _$$CreatePostFailureStateImplCopyWith<$Res> {
  __$$CreatePostFailureStateImplCopyWithImpl(
      _$CreatePostFailureStateImpl _value,
      $Res Function(_$CreatePostFailureStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$CreatePostFailureStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CreatePostFailureStateImpl implements CreatePostFailureState {
  const _$CreatePostFailureStateImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PostState.createPostFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePostFailureStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePostFailureStateImplCopyWith<_$CreatePostFailureStateImpl>
      get copyWith => __$$CreatePostFailureStateImplCopyWithImpl<
          _$CreatePostFailureStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return createPostFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return createPostFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (createPostFailure != null) {
      return createPostFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return createPostFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return createPostFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (createPostFailure != null) {
      return createPostFailure(this);
    }
    return orElse();
  }
}

abstract class CreatePostFailureState implements PostState {
  const factory CreatePostFailureState(final String error) =
      _$CreatePostFailureStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$CreatePostFailureStateImplCopyWith<_$CreatePostFailureStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetPostDetailsLoadingStateImplCopyWith<$Res> {
  factory _$$GetPostDetailsLoadingStateImplCopyWith(
          _$GetPostDetailsLoadingStateImpl value,
          $Res Function(_$GetPostDetailsLoadingStateImpl) then) =
      __$$GetPostDetailsLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetPostDetailsLoadingStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetPostDetailsLoadingStateImpl>
    implements _$$GetPostDetailsLoadingStateImplCopyWith<$Res> {
  __$$GetPostDetailsLoadingStateImplCopyWithImpl(
      _$GetPostDetailsLoadingStateImpl _value,
      $Res Function(_$GetPostDetailsLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetPostDetailsLoadingStateImpl implements GetPostDetailsLoadingState {
  const _$GetPostDetailsLoadingStateImpl();

  @override
  String toString() {
    return 'PostState.getPostDetailsLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPostDetailsLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getPostDetailsLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getPostDetailsLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPostDetailsLoading != null) {
      return getPostDetailsLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getPostDetailsLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getPostDetailsLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPostDetailsLoading != null) {
      return getPostDetailsLoading(this);
    }
    return orElse();
  }
}

abstract class GetPostDetailsLoadingState implements PostState {
  const factory GetPostDetailsLoadingState() = _$GetPostDetailsLoadingStateImpl;
}

/// @nodoc
abstract class _$$GetPostDetailsSuccessStateImplCopyWith<$Res> {
  factory _$$GetPostDetailsSuccessStateImplCopyWith(
          _$GetPostDetailsSuccessStateImpl value,
          $Res Function(_$GetPostDetailsSuccessStateImpl) then) =
      __$$GetPostDetailsSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PostDetailsResponse response});
}

/// @nodoc
class __$$GetPostDetailsSuccessStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetPostDetailsSuccessStateImpl>
    implements _$$GetPostDetailsSuccessStateImplCopyWith<$Res> {
  __$$GetPostDetailsSuccessStateImplCopyWithImpl(
      _$GetPostDetailsSuccessStateImpl _value,
      $Res Function(_$GetPostDetailsSuccessStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$GetPostDetailsSuccessStateImpl(
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as PostDetailsResponse,
    ));
  }
}

/// @nodoc

class _$GetPostDetailsSuccessStateImpl implements GetPostDetailsSuccessState {
  const _$GetPostDetailsSuccessStateImpl(this.response);

  @override
  final PostDetailsResponse response;

  @override
  String toString() {
    return 'PostState.getPostDetailsSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPostDetailsSuccessStateImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPostDetailsSuccessStateImplCopyWith<_$GetPostDetailsSuccessStateImpl>
      get copyWith => __$$GetPostDetailsSuccessStateImplCopyWithImpl<
          _$GetPostDetailsSuccessStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getPostDetailsSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getPostDetailsSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPostDetailsSuccess != null) {
      return getPostDetailsSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getPostDetailsSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getPostDetailsSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPostDetailsSuccess != null) {
      return getPostDetailsSuccess(this);
    }
    return orElse();
  }
}

abstract class GetPostDetailsSuccessState implements PostState {
  const factory GetPostDetailsSuccessState(final PostDetailsResponse response) =
      _$GetPostDetailsSuccessStateImpl;

  PostDetailsResponse get response;
  @JsonKey(ignore: true)
  _$$GetPostDetailsSuccessStateImplCopyWith<_$GetPostDetailsSuccessStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetPostDetailsFailureStateImplCopyWith<$Res> {
  factory _$$GetPostDetailsFailureStateImplCopyWith(
          _$GetPostDetailsFailureStateImpl value,
          $Res Function(_$GetPostDetailsFailureStateImpl) then) =
      __$$GetPostDetailsFailureStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$GetPostDetailsFailureStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetPostDetailsFailureStateImpl>
    implements _$$GetPostDetailsFailureStateImplCopyWith<$Res> {
  __$$GetPostDetailsFailureStateImplCopyWithImpl(
      _$GetPostDetailsFailureStateImpl _value,
      $Res Function(_$GetPostDetailsFailureStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$GetPostDetailsFailureStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetPostDetailsFailureStateImpl implements GetPostDetailsFailureState {
  const _$GetPostDetailsFailureStateImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PostState.getPostDetailsFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPostDetailsFailureStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPostDetailsFailureStateImplCopyWith<_$GetPostDetailsFailureStateImpl>
      get copyWith => __$$GetPostDetailsFailureStateImplCopyWithImpl<
          _$GetPostDetailsFailureStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getPostDetailsFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getPostDetailsFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPostDetailsFailure != null) {
      return getPostDetailsFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getPostDetailsFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getPostDetailsFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPostDetailsFailure != null) {
      return getPostDetailsFailure(this);
    }
    return orElse();
  }
}

abstract class GetPostDetailsFailureState implements PostState {
  const factory GetPostDetailsFailureState(final String error) =
      _$GetPostDetailsFailureStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$GetPostDetailsFailureStateImplCopyWith<_$GetPostDetailsFailureStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeletePostLoadingStateImplCopyWith<$Res> {
  factory _$$DeletePostLoadingStateImplCopyWith(
          _$DeletePostLoadingStateImpl value,
          $Res Function(_$DeletePostLoadingStateImpl) then) =
      __$$DeletePostLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeletePostLoadingStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$DeletePostLoadingStateImpl>
    implements _$$DeletePostLoadingStateImplCopyWith<$Res> {
  __$$DeletePostLoadingStateImplCopyWithImpl(
      _$DeletePostLoadingStateImpl _value,
      $Res Function(_$DeletePostLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DeletePostLoadingStateImpl implements DeletePostLoadingState {
  const _$DeletePostLoadingStateImpl();

  @override
  String toString() {
    return 'PostState.deletePostLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePostLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return deletePostLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return deletePostLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (deletePostLoading != null) {
      return deletePostLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return deletePostLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return deletePostLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (deletePostLoading != null) {
      return deletePostLoading(this);
    }
    return orElse();
  }
}

abstract class DeletePostLoadingState implements PostState {
  const factory DeletePostLoadingState() = _$DeletePostLoadingStateImpl;
}

/// @nodoc
abstract class _$$DeletePostSuccessStateImplCopyWith<$Res> {
  factory _$$DeletePostSuccessStateImplCopyWith(
          _$DeletePostSuccessStateImpl value,
          $Res Function(_$DeletePostSuccessStateImpl) then) =
      __$$DeletePostSuccessStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeletePostSuccessStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$DeletePostSuccessStateImpl>
    implements _$$DeletePostSuccessStateImplCopyWith<$Res> {
  __$$DeletePostSuccessStateImplCopyWithImpl(
      _$DeletePostSuccessStateImpl _value,
      $Res Function(_$DeletePostSuccessStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DeletePostSuccessStateImpl implements DeletePostSuccessState {
  const _$DeletePostSuccessStateImpl();

  @override
  String toString() {
    return 'PostState.deletePostSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePostSuccessStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return deletePostSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return deletePostSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (deletePostSuccess != null) {
      return deletePostSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return deletePostSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return deletePostSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (deletePostSuccess != null) {
      return deletePostSuccess(this);
    }
    return orElse();
  }
}

abstract class DeletePostSuccessState implements PostState {
  const factory DeletePostSuccessState() = _$DeletePostSuccessStateImpl;
}

/// @nodoc
abstract class _$$DeletePostFailureStateImplCopyWith<$Res> {
  factory _$$DeletePostFailureStateImplCopyWith(
          _$DeletePostFailureStateImpl value,
          $Res Function(_$DeletePostFailureStateImpl) then) =
      __$$DeletePostFailureStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$DeletePostFailureStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$DeletePostFailureStateImpl>
    implements _$$DeletePostFailureStateImplCopyWith<$Res> {
  __$$DeletePostFailureStateImplCopyWithImpl(
      _$DeletePostFailureStateImpl _value,
      $Res Function(_$DeletePostFailureStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$DeletePostFailureStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeletePostFailureStateImpl implements DeletePostFailureState {
  const _$DeletePostFailureStateImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PostState.deletePostFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePostFailureStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletePostFailureStateImplCopyWith<_$DeletePostFailureStateImpl>
      get copyWith => __$$DeletePostFailureStateImplCopyWithImpl<
          _$DeletePostFailureStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return deletePostFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return deletePostFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (deletePostFailure != null) {
      return deletePostFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return deletePostFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return deletePostFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (deletePostFailure != null) {
      return deletePostFailure(this);
    }
    return orElse();
  }
}

abstract class DeletePostFailureState implements PostState {
  const factory DeletePostFailureState(final String error) =
      _$DeletePostFailureStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$DeletePostFailureStateImplCopyWith<_$DeletePostFailureStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostReactionLoadingStateImplCopyWith<$Res> {
  factory _$$PostReactionLoadingStateImplCopyWith(
          _$PostReactionLoadingStateImpl value,
          $Res Function(_$PostReactionLoadingStateImpl) then) =
      __$$PostReactionLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PostReactionLoadingStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$PostReactionLoadingStateImpl>
    implements _$$PostReactionLoadingStateImplCopyWith<$Res> {
  __$$PostReactionLoadingStateImplCopyWithImpl(
      _$PostReactionLoadingStateImpl _value,
      $Res Function(_$PostReactionLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PostReactionLoadingStateImpl implements PostReactionLoadingState {
  const _$PostReactionLoadingStateImpl();

  @override
  String toString() {
    return 'PostState.postReactionLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostReactionLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return postReactionLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return postReactionLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (postReactionLoading != null) {
      return postReactionLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return postReactionLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return postReactionLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (postReactionLoading != null) {
      return postReactionLoading(this);
    }
    return orElse();
  }
}

abstract class PostReactionLoadingState implements PostState {
  const factory PostReactionLoadingState() = _$PostReactionLoadingStateImpl;
}

/// @nodoc
abstract class _$$PostReactionSuccessStateImplCopyWith<$Res> {
  factory _$$PostReactionSuccessStateImplCopyWith(
          _$PostReactionSuccessStateImpl value,
          $Res Function(_$PostReactionSuccessStateImpl) then) =
      __$$PostReactionSuccessStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PostReactionSuccessStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$PostReactionSuccessStateImpl>
    implements _$$PostReactionSuccessStateImplCopyWith<$Res> {
  __$$PostReactionSuccessStateImplCopyWithImpl(
      _$PostReactionSuccessStateImpl _value,
      $Res Function(_$PostReactionSuccessStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PostReactionSuccessStateImpl implements PostReactionSuccessState {
  const _$PostReactionSuccessStateImpl();

  @override
  String toString() {
    return 'PostState.postReactionSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostReactionSuccessStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return postReactionSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return postReactionSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (postReactionSuccess != null) {
      return postReactionSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return postReactionSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return postReactionSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (postReactionSuccess != null) {
      return postReactionSuccess(this);
    }
    return orElse();
  }
}

abstract class PostReactionSuccessState implements PostState {
  const factory PostReactionSuccessState() = _$PostReactionSuccessStateImpl;
}

/// @nodoc
abstract class _$$PostReactionFailureStateImplCopyWith<$Res> {
  factory _$$PostReactionFailureStateImplCopyWith(
          _$PostReactionFailureStateImpl value,
          $Res Function(_$PostReactionFailureStateImpl) then) =
      __$$PostReactionFailureStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$PostReactionFailureStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$PostReactionFailureStateImpl>
    implements _$$PostReactionFailureStateImplCopyWith<$Res> {
  __$$PostReactionFailureStateImplCopyWithImpl(
      _$PostReactionFailureStateImpl _value,
      $Res Function(_$PostReactionFailureStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$PostReactionFailureStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PostReactionFailureStateImpl implements PostReactionFailureState {
  const _$PostReactionFailureStateImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PostState.postReactionFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostReactionFailureStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostReactionFailureStateImplCopyWith<_$PostReactionFailureStateImpl>
      get copyWith => __$$PostReactionFailureStateImplCopyWithImpl<
          _$PostReactionFailureStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return postReactionFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return postReactionFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (postReactionFailure != null) {
      return postReactionFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return postReactionFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return postReactionFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (postReactionFailure != null) {
      return postReactionFailure(this);
    }
    return orElse();
  }
}

abstract class PostReactionFailureState implements PostState {
  const factory PostReactionFailureState(final String error) =
      _$PostReactionFailureStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$PostReactionFailureStateImplCopyWith<_$PostReactionFailureStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReportPostLoadingStateImplCopyWith<$Res> {
  factory _$$ReportPostLoadingStateImplCopyWith(
          _$ReportPostLoadingStateImpl value,
          $Res Function(_$ReportPostLoadingStateImpl) then) =
      __$$ReportPostLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReportPostLoadingStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$ReportPostLoadingStateImpl>
    implements _$$ReportPostLoadingStateImplCopyWith<$Res> {
  __$$ReportPostLoadingStateImplCopyWithImpl(
      _$ReportPostLoadingStateImpl _value,
      $Res Function(_$ReportPostLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ReportPostLoadingStateImpl implements ReportPostLoadingState {
  const _$ReportPostLoadingStateImpl();

  @override
  String toString() {
    return 'PostState.reportPostLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportPostLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return reportPostLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return reportPostLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (reportPostLoading != null) {
      return reportPostLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return reportPostLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return reportPostLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (reportPostLoading != null) {
      return reportPostLoading(this);
    }
    return orElse();
  }
}

abstract class ReportPostLoadingState implements PostState {
  const factory ReportPostLoadingState() = _$ReportPostLoadingStateImpl;
}

/// @nodoc
abstract class _$$ReportPostSuccessStateImplCopyWith<$Res> {
  factory _$$ReportPostSuccessStateImplCopyWith(
          _$ReportPostSuccessStateImpl value,
          $Res Function(_$ReportPostSuccessStateImpl) then) =
      __$$ReportPostSuccessStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReportPostSuccessStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$ReportPostSuccessStateImpl>
    implements _$$ReportPostSuccessStateImplCopyWith<$Res> {
  __$$ReportPostSuccessStateImplCopyWithImpl(
      _$ReportPostSuccessStateImpl _value,
      $Res Function(_$ReportPostSuccessStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ReportPostSuccessStateImpl implements ReportPostSuccessState {
  const _$ReportPostSuccessStateImpl();

  @override
  String toString() {
    return 'PostState.reportPostSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportPostSuccessStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return reportPostSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return reportPostSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (reportPostSuccess != null) {
      return reportPostSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return reportPostSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return reportPostSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (reportPostSuccess != null) {
      return reportPostSuccess(this);
    }
    return orElse();
  }
}

abstract class ReportPostSuccessState implements PostState {
  const factory ReportPostSuccessState() = _$ReportPostSuccessStateImpl;
}

/// @nodoc
abstract class _$$ReportPostFailureStateImplCopyWith<$Res> {
  factory _$$ReportPostFailureStateImplCopyWith(
          _$ReportPostFailureStateImpl value,
          $Res Function(_$ReportPostFailureStateImpl) then) =
      __$$ReportPostFailureStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ReportPostFailureStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$ReportPostFailureStateImpl>
    implements _$$ReportPostFailureStateImplCopyWith<$Res> {
  __$$ReportPostFailureStateImplCopyWithImpl(
      _$ReportPostFailureStateImpl _value,
      $Res Function(_$ReportPostFailureStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ReportPostFailureStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ReportPostFailureStateImpl implements ReportPostFailureState {
  const _$ReportPostFailureStateImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PostState.reportPostFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportPostFailureStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportPostFailureStateImplCopyWith<_$ReportPostFailureStateImpl>
      get copyWith => __$$ReportPostFailureStateImplCopyWithImpl<
          _$ReportPostFailureStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return reportPostFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return reportPostFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (reportPostFailure != null) {
      return reportPostFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return reportPostFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return reportPostFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (reportPostFailure != null) {
      return reportPostFailure(this);
    }
    return orElse();
  }
}

abstract class ReportPostFailureState implements PostState {
  const factory ReportPostFailureState(final String error) =
      _$ReportPostFailureStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$ReportPostFailureStateImplCopyWith<_$ReportPostFailureStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetPollsLoadingStateImplCopyWith<$Res> {
  factory _$$GetPollsLoadingStateImplCopyWith(_$GetPollsLoadingStateImpl value,
          $Res Function(_$GetPollsLoadingStateImpl) then) =
      __$$GetPollsLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetPollsLoadingStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetPollsLoadingStateImpl>
    implements _$$GetPollsLoadingStateImplCopyWith<$Res> {
  __$$GetPollsLoadingStateImplCopyWithImpl(_$GetPollsLoadingStateImpl _value,
      $Res Function(_$GetPollsLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetPollsLoadingStateImpl implements GetPollsLoadingState {
  const _$GetPollsLoadingStateImpl();

  @override
  String toString() {
    return 'PostState.getPollsLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPollsLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getPollsLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getPollsLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPollsLoading != null) {
      return getPollsLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getPollsLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getPollsLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPollsLoading != null) {
      return getPollsLoading(this);
    }
    return orElse();
  }
}

abstract class GetPollsLoadingState implements PostState {
  const factory GetPollsLoadingState() = _$GetPollsLoadingStateImpl;
}

/// @nodoc
abstract class _$$GetPollsSuccessStateImplCopyWith<$Res> {
  factory _$$GetPollsSuccessStateImplCopyWith(_$GetPollsSuccessStateImpl value,
          $Res Function(_$GetPollsSuccessStateImpl) then) =
      __$$GetPollsSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GetPollsResponse response});
}

/// @nodoc
class __$$GetPollsSuccessStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetPollsSuccessStateImpl>
    implements _$$GetPollsSuccessStateImplCopyWith<$Res> {
  __$$GetPollsSuccessStateImplCopyWithImpl(_$GetPollsSuccessStateImpl _value,
      $Res Function(_$GetPollsSuccessStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$GetPollsSuccessStateImpl(
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as GetPollsResponse,
    ));
  }
}

/// @nodoc

class _$GetPollsSuccessStateImpl implements GetPollsSuccessState {
  const _$GetPollsSuccessStateImpl(this.response);

  @override
  final GetPollsResponse response;

  @override
  String toString() {
    return 'PostState.getPollsSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPollsSuccessStateImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPollsSuccessStateImplCopyWith<_$GetPollsSuccessStateImpl>
      get copyWith =>
          __$$GetPollsSuccessStateImplCopyWithImpl<_$GetPollsSuccessStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getPollsSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getPollsSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPollsSuccess != null) {
      return getPollsSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getPollsSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getPollsSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPollsSuccess != null) {
      return getPollsSuccess(this);
    }
    return orElse();
  }
}

abstract class GetPollsSuccessState implements PostState {
  const factory GetPollsSuccessState(final GetPollsResponse response) =
      _$GetPollsSuccessStateImpl;

  GetPollsResponse get response;
  @JsonKey(ignore: true)
  _$$GetPollsSuccessStateImplCopyWith<_$GetPollsSuccessStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetPollsFailureStateImplCopyWith<$Res> {
  factory _$$GetPollsFailureStateImplCopyWith(_$GetPollsFailureStateImpl value,
          $Res Function(_$GetPollsFailureStateImpl) then) =
      __$$GetPollsFailureStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$GetPollsFailureStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetPollsFailureStateImpl>
    implements _$$GetPollsFailureStateImplCopyWith<$Res> {
  __$$GetPollsFailureStateImplCopyWithImpl(_$GetPollsFailureStateImpl _value,
      $Res Function(_$GetPollsFailureStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$GetPollsFailureStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetPollsFailureStateImpl implements GetPollsFailureState {
  const _$GetPollsFailureStateImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PostState.getPollsFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPollsFailureStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPollsFailureStateImplCopyWith<_$GetPollsFailureStateImpl>
      get copyWith =>
          __$$GetPollsFailureStateImplCopyWithImpl<_$GetPollsFailureStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getPollsFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getPollsFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPollsFailure != null) {
      return getPollsFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getPollsFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getPollsFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getPollsFailure != null) {
      return getPollsFailure(this);
    }
    return orElse();
  }
}

abstract class GetPollsFailureState implements PostState {
  const factory GetPollsFailureState(final String error) =
      _$GetPollsFailureStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$GetPollsFailureStateImplCopyWith<_$GetPollsFailureStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetCommentsLoadingStateImplCopyWith<$Res> {
  factory _$$GetCommentsLoadingStateImplCopyWith(
          _$GetCommentsLoadingStateImpl value,
          $Res Function(_$GetCommentsLoadingStateImpl) then) =
      __$$GetCommentsLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetCommentsLoadingStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetCommentsLoadingStateImpl>
    implements _$$GetCommentsLoadingStateImplCopyWith<$Res> {
  __$$GetCommentsLoadingStateImplCopyWithImpl(
      _$GetCommentsLoadingStateImpl _value,
      $Res Function(_$GetCommentsLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetCommentsLoadingStateImpl implements GetCommentsLoadingState {
  const _$GetCommentsLoadingStateImpl();

  @override
  String toString() {
    return 'PostState.getCommentsLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCommentsLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getCommentsLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getCommentsLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getCommentsLoading != null) {
      return getCommentsLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getCommentsLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getCommentsLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getCommentsLoading != null) {
      return getCommentsLoading(this);
    }
    return orElse();
  }
}

abstract class GetCommentsLoadingState implements PostState {
  const factory GetCommentsLoadingState() = _$GetCommentsLoadingStateImpl;
}

/// @nodoc
abstract class _$$GetCommentsSuccessStateImplCopyWith<$Res> {
  factory _$$GetCommentsSuccessStateImplCopyWith(
          _$GetCommentsSuccessStateImpl value,
          $Res Function(_$GetCommentsSuccessStateImpl) then) =
      __$$GetCommentsSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic response});
}

/// @nodoc
class __$$GetCommentsSuccessStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetCommentsSuccessStateImpl>
    implements _$$GetCommentsSuccessStateImplCopyWith<$Res> {
  __$$GetCommentsSuccessStateImplCopyWithImpl(
      _$GetCommentsSuccessStateImpl _value,
      $Res Function(_$GetCommentsSuccessStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_$GetCommentsSuccessStateImpl(
      freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$GetCommentsSuccessStateImpl implements GetCommentsSuccessState {
  const _$GetCommentsSuccessStateImpl(this.response);

  @override
  final dynamic response;

  @override
  String toString() {
    return 'PostState.getCommentsSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCommentsSuccessStateImpl &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(response));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCommentsSuccessStateImplCopyWith<_$GetCommentsSuccessStateImpl>
      get copyWith => __$$GetCommentsSuccessStateImplCopyWithImpl<
          _$GetCommentsSuccessStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getCommentsSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getCommentsSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getCommentsSuccess != null) {
      return getCommentsSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getCommentsSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getCommentsSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getCommentsSuccess != null) {
      return getCommentsSuccess(this);
    }
    return orElse();
  }
}

abstract class GetCommentsSuccessState implements PostState {
  const factory GetCommentsSuccessState(final dynamic response) =
      _$GetCommentsSuccessStateImpl;

  dynamic get response;
  @JsonKey(ignore: true)
  _$$GetCommentsSuccessStateImplCopyWith<_$GetCommentsSuccessStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetCommentsFailureStateImplCopyWith<$Res> {
  factory _$$GetCommentsFailureStateImplCopyWith(
          _$GetCommentsFailureStateImpl value,
          $Res Function(_$GetCommentsFailureStateImpl) then) =
      __$$GetCommentsFailureStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$GetCommentsFailureStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetCommentsFailureStateImpl>
    implements _$$GetCommentsFailureStateImplCopyWith<$Res> {
  __$$GetCommentsFailureStateImplCopyWithImpl(
      _$GetCommentsFailureStateImpl _value,
      $Res Function(_$GetCommentsFailureStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$GetCommentsFailureStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetCommentsFailureStateImpl implements GetCommentsFailureState {
  const _$GetCommentsFailureStateImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PostState.getCommentsFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCommentsFailureStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCommentsFailureStateImplCopyWith<_$GetCommentsFailureStateImpl>
      get copyWith => __$$GetCommentsFailureStateImplCopyWithImpl<
          _$GetCommentsFailureStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getCommentsFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getCommentsFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getCommentsFailure != null) {
      return getCommentsFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getCommentsFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getCommentsFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getCommentsFailure != null) {
      return getCommentsFailure(this);
    }
    return orElse();
  }
}

abstract class GetCommentsFailureState implements PostState {
  const factory GetCommentsFailureState(final String error) =
      _$GetCommentsFailureStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$GetCommentsFailureStateImplCopyWith<_$GetCommentsFailureStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetACommentLoadingStateImplCopyWith<$Res> {
  factory _$$GetACommentLoadingStateImplCopyWith(
          _$GetACommentLoadingStateImpl value,
          $Res Function(_$GetACommentLoadingStateImpl) then) =
      __$$GetACommentLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetACommentLoadingStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetACommentLoadingStateImpl>
    implements _$$GetACommentLoadingStateImplCopyWith<$Res> {
  __$$GetACommentLoadingStateImplCopyWithImpl(
      _$GetACommentLoadingStateImpl _value,
      $Res Function(_$GetACommentLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetACommentLoadingStateImpl implements GetACommentLoadingState {
  const _$GetACommentLoadingStateImpl();

  @override
  String toString() {
    return 'PostState.getACommentLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetACommentLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getACommentLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getACommentLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getACommentLoading != null) {
      return getACommentLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getACommentLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getACommentLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getACommentLoading != null) {
      return getACommentLoading(this);
    }
    return orElse();
  }
}

abstract class GetACommentLoadingState implements PostState {
  const factory GetACommentLoadingState() = _$GetACommentLoadingStateImpl;
}

/// @nodoc
abstract class _$$GetACommentSuccessStateImplCopyWith<$Res> {
  factory _$$GetACommentSuccessStateImplCopyWith(
          _$GetACommentSuccessStateImpl value,
          $Res Function(_$GetACommentSuccessStateImpl) then) =
      __$$GetACommentSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic response});
}

/// @nodoc
class __$$GetACommentSuccessStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetACommentSuccessStateImpl>
    implements _$$GetACommentSuccessStateImplCopyWith<$Res> {
  __$$GetACommentSuccessStateImplCopyWithImpl(
      _$GetACommentSuccessStateImpl _value,
      $Res Function(_$GetACommentSuccessStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_$GetACommentSuccessStateImpl(
      freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$GetACommentSuccessStateImpl implements GetACommentSuccessState {
  const _$GetACommentSuccessStateImpl(this.response);

  @override
  final dynamic response;

  @override
  String toString() {
    return 'PostState.getACommentSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetACommentSuccessStateImpl &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(response));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetACommentSuccessStateImplCopyWith<_$GetACommentSuccessStateImpl>
      get copyWith => __$$GetACommentSuccessStateImplCopyWithImpl<
          _$GetACommentSuccessStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getACommentSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getACommentSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getACommentSuccess != null) {
      return getACommentSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getACommentSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getACommentSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getACommentSuccess != null) {
      return getACommentSuccess(this);
    }
    return orElse();
  }
}

abstract class GetACommentSuccessState implements PostState {
  const factory GetACommentSuccessState(final dynamic response) =
      _$GetACommentSuccessStateImpl;

  dynamic get response;
  @JsonKey(ignore: true)
  _$$GetACommentSuccessStateImplCopyWith<_$GetACommentSuccessStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetACommentFailureStateImplCopyWith<$Res> {
  factory _$$GetACommentFailureStateImplCopyWith(
          _$GetACommentFailureStateImpl value,
          $Res Function(_$GetACommentFailureStateImpl) then) =
      __$$GetACommentFailureStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$GetACommentFailureStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$GetACommentFailureStateImpl>
    implements _$$GetACommentFailureStateImplCopyWith<$Res> {
  __$$GetACommentFailureStateImplCopyWithImpl(
      _$GetACommentFailureStateImpl _value,
      $Res Function(_$GetACommentFailureStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$GetACommentFailureStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetACommentFailureStateImpl implements GetACommentFailureState {
  const _$GetACommentFailureStateImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PostState.getACommentFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetACommentFailureStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetACommentFailureStateImplCopyWith<_$GetACommentFailureStateImpl>
      get copyWith => __$$GetACommentFailureStateImplCopyWithImpl<
          _$GetACommentFailureStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return getACommentFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return getACommentFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getACommentFailure != null) {
      return getACommentFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return getACommentFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return getACommentFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (getACommentFailure != null) {
      return getACommentFailure(this);
    }
    return orElse();
  }
}

abstract class GetACommentFailureState implements PostState {
  const factory GetACommentFailureState(final String error) =
      _$GetACommentFailureStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$GetACommentFailureStateImplCopyWith<_$GetACommentFailureStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveACommentLoadingStateImplCopyWith<$Res> {
  factory _$$SaveACommentLoadingStateImplCopyWith(
          _$SaveACommentLoadingStateImpl value,
          $Res Function(_$SaveACommentLoadingStateImpl) then) =
      __$$SaveACommentLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SaveACommentLoadingStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$SaveACommentLoadingStateImpl>
    implements _$$SaveACommentLoadingStateImplCopyWith<$Res> {
  __$$SaveACommentLoadingStateImplCopyWithImpl(
      _$SaveACommentLoadingStateImpl _value,
      $Res Function(_$SaveACommentLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SaveACommentLoadingStateImpl implements SaveACommentLoadingState {
  const _$SaveACommentLoadingStateImpl();

  @override
  String toString() {
    return 'PostState.saveACommentLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveACommentLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return saveACommentLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return saveACommentLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (saveACommentLoading != null) {
      return saveACommentLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return saveACommentLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return saveACommentLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (saveACommentLoading != null) {
      return saveACommentLoading(this);
    }
    return orElse();
  }
}

abstract class SaveACommentLoadingState implements PostState {
  const factory SaveACommentLoadingState() = _$SaveACommentLoadingStateImpl;
}

/// @nodoc
abstract class _$$SaveACommentSuccessStateImplCopyWith<$Res> {
  factory _$$SaveACommentSuccessStateImplCopyWith(
          _$SaveACommentSuccessStateImpl value,
          $Res Function(_$SaveACommentSuccessStateImpl) then) =
      __$$SaveACommentSuccessStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SaveACommentSuccessStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$SaveACommentSuccessStateImpl>
    implements _$$SaveACommentSuccessStateImplCopyWith<$Res> {
  __$$SaveACommentSuccessStateImplCopyWithImpl(
      _$SaveACommentSuccessStateImpl _value,
      $Res Function(_$SaveACommentSuccessStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SaveACommentSuccessStateImpl implements SaveACommentSuccessState {
  const _$SaveACommentSuccessStateImpl();

  @override
  String toString() {
    return 'PostState.saveACommentSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveACommentSuccessStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return saveACommentSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return saveACommentSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (saveACommentSuccess != null) {
      return saveACommentSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return saveACommentSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return saveACommentSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (saveACommentSuccess != null) {
      return saveACommentSuccess(this);
    }
    return orElse();
  }
}

abstract class SaveACommentSuccessState implements PostState {
  const factory SaveACommentSuccessState() = _$SaveACommentSuccessStateImpl;
}

/// @nodoc
abstract class _$$SaveACommentFailureStateImplCopyWith<$Res> {
  factory _$$SaveACommentFailureStateImplCopyWith(
          _$SaveACommentFailureStateImpl value,
          $Res Function(_$SaveACommentFailureStateImpl) then) =
      __$$SaveACommentFailureStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$SaveACommentFailureStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$SaveACommentFailureStateImpl>
    implements _$$SaveACommentFailureStateImplCopyWith<$Res> {
  __$$SaveACommentFailureStateImplCopyWithImpl(
      _$SaveACommentFailureStateImpl _value,
      $Res Function(_$SaveACommentFailureStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$SaveACommentFailureStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SaveACommentFailureStateImpl implements SaveACommentFailureState {
  const _$SaveACommentFailureStateImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PostState.saveACommentFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveACommentFailureStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveACommentFailureStateImplCopyWith<_$SaveACommentFailureStateImpl>
      get copyWith => __$$SaveACommentFailureStateImplCopyWithImpl<
          _$SaveACommentFailureStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return saveACommentFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return saveACommentFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (saveACommentFailure != null) {
      return saveACommentFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return saveACommentFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return saveACommentFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (saveACommentFailure != null) {
      return saveACommentFailure(this);
    }
    return orElse();
  }
}

abstract class SaveACommentFailureState implements PostState {
  const factory SaveACommentFailureState(final String error) =
      _$SaveACommentFailureStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$SaveACommentFailureStateImplCopyWith<_$SaveACommentFailureStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteCommentLoadingStateImplCopyWith<$Res> {
  factory _$$DeleteCommentLoadingStateImplCopyWith(
          _$DeleteCommentLoadingStateImpl value,
          $Res Function(_$DeleteCommentLoadingStateImpl) then) =
      __$$DeleteCommentLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeleteCommentLoadingStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$DeleteCommentLoadingStateImpl>
    implements _$$DeleteCommentLoadingStateImplCopyWith<$Res> {
  __$$DeleteCommentLoadingStateImplCopyWithImpl(
      _$DeleteCommentLoadingStateImpl _value,
      $Res Function(_$DeleteCommentLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DeleteCommentLoadingStateImpl implements DeleteCommentLoadingState {
  const _$DeleteCommentLoadingStateImpl();

  @override
  String toString() {
    return 'PostState.deleteCommentLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCommentLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return deleteCommentLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return deleteCommentLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (deleteCommentLoading != null) {
      return deleteCommentLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return deleteCommentLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return deleteCommentLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (deleteCommentLoading != null) {
      return deleteCommentLoading(this);
    }
    return orElse();
  }
}

abstract class DeleteCommentLoadingState implements PostState {
  const factory DeleteCommentLoadingState() = _$DeleteCommentLoadingStateImpl;
}

/// @nodoc
abstract class _$$DeleteCommentSuccessStateImplCopyWith<$Res> {
  factory _$$DeleteCommentSuccessStateImplCopyWith(
          _$DeleteCommentSuccessStateImpl value,
          $Res Function(_$DeleteCommentSuccessStateImpl) then) =
      __$$DeleteCommentSuccessStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeleteCommentSuccessStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$DeleteCommentSuccessStateImpl>
    implements _$$DeleteCommentSuccessStateImplCopyWith<$Res> {
  __$$DeleteCommentSuccessStateImplCopyWithImpl(
      _$DeleteCommentSuccessStateImpl _value,
      $Res Function(_$DeleteCommentSuccessStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DeleteCommentSuccessStateImpl implements DeleteCommentSuccessState {
  const _$DeleteCommentSuccessStateImpl();

  @override
  String toString() {
    return 'PostState.deleteCommentSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCommentSuccessStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return deleteCommentSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return deleteCommentSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (deleteCommentSuccess != null) {
      return deleteCommentSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return deleteCommentSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return deleteCommentSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (deleteCommentSuccess != null) {
      return deleteCommentSuccess(this);
    }
    return orElse();
  }
}

abstract class DeleteCommentSuccessState implements PostState {
  const factory DeleteCommentSuccessState() = _$DeleteCommentSuccessStateImpl;
}

/// @nodoc
abstract class _$$DeleteCommentFailureStateImplCopyWith<$Res> {
  factory _$$DeleteCommentFailureStateImplCopyWith(
          _$DeleteCommentFailureStateImpl value,
          $Res Function(_$DeleteCommentFailureStateImpl) then) =
      __$$DeleteCommentFailureStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$DeleteCommentFailureStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$DeleteCommentFailureStateImpl>
    implements _$$DeleteCommentFailureStateImplCopyWith<$Res> {
  __$$DeleteCommentFailureStateImplCopyWithImpl(
      _$DeleteCommentFailureStateImpl _value,
      $Res Function(_$DeleteCommentFailureStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$DeleteCommentFailureStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteCommentFailureStateImpl implements DeleteCommentFailureState {
  const _$DeleteCommentFailureStateImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PostState.deleteCommentFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCommentFailureStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCommentFailureStateImplCopyWith<_$DeleteCommentFailureStateImpl>
      get copyWith => __$$DeleteCommentFailureStateImplCopyWithImpl<
          _$DeleteCommentFailureStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return deleteCommentFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return deleteCommentFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (deleteCommentFailure != null) {
      return deleteCommentFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return deleteCommentFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return deleteCommentFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (deleteCommentFailure != null) {
      return deleteCommentFailure(this);
    }
    return orElse();
  }
}

abstract class DeleteCommentFailureState implements PostState {
  const factory DeleteCommentFailureState(final String error) =
      _$DeleteCommentFailureStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$DeleteCommentFailureStateImplCopyWith<_$DeleteCommentFailureStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CommentReactionLoadingStateImplCopyWith<$Res> {
  factory _$$CommentReactionLoadingStateImplCopyWith(
          _$CommentReactionLoadingStateImpl value,
          $Res Function(_$CommentReactionLoadingStateImpl) then) =
      __$$CommentReactionLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CommentReactionLoadingStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$CommentReactionLoadingStateImpl>
    implements _$$CommentReactionLoadingStateImplCopyWith<$Res> {
  __$$CommentReactionLoadingStateImplCopyWithImpl(
      _$CommentReactionLoadingStateImpl _value,
      $Res Function(_$CommentReactionLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CommentReactionLoadingStateImpl implements CommentReactionLoadingState {
  const _$CommentReactionLoadingStateImpl();

  @override
  String toString() {
    return 'PostState.commentReactionLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentReactionLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return commentReactionLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return commentReactionLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (commentReactionLoading != null) {
      return commentReactionLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return commentReactionLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return commentReactionLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (commentReactionLoading != null) {
      return commentReactionLoading(this);
    }
    return orElse();
  }
}

abstract class CommentReactionLoadingState implements PostState {
  const factory CommentReactionLoadingState() =
      _$CommentReactionLoadingStateImpl;
}

/// @nodoc
abstract class _$$CommentReactionSuccessStateImplCopyWith<$Res> {
  factory _$$CommentReactionSuccessStateImplCopyWith(
          _$CommentReactionSuccessStateImpl value,
          $Res Function(_$CommentReactionSuccessStateImpl) then) =
      __$$CommentReactionSuccessStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CommentReactionSuccessStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$CommentReactionSuccessStateImpl>
    implements _$$CommentReactionSuccessStateImplCopyWith<$Res> {
  __$$CommentReactionSuccessStateImplCopyWithImpl(
      _$CommentReactionSuccessStateImpl _value,
      $Res Function(_$CommentReactionSuccessStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CommentReactionSuccessStateImpl implements CommentReactionSuccessState {
  const _$CommentReactionSuccessStateImpl();

  @override
  String toString() {
    return 'PostState.commentReactionSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentReactionSuccessStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return commentReactionSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return commentReactionSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (commentReactionSuccess != null) {
      return commentReactionSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return commentReactionSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return commentReactionSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (commentReactionSuccess != null) {
      return commentReactionSuccess(this);
    }
    return orElse();
  }
}

abstract class CommentReactionSuccessState implements PostState {
  const factory CommentReactionSuccessState() =
      _$CommentReactionSuccessStateImpl;
}

/// @nodoc
abstract class _$$CommentReactionFailureStateImplCopyWith<$Res> {
  factory _$$CommentReactionFailureStateImplCopyWith(
          _$CommentReactionFailureStateImpl value,
          $Res Function(_$CommentReactionFailureStateImpl) then) =
      __$$CommentReactionFailureStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$CommentReactionFailureStateImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$CommentReactionFailureStateImpl>
    implements _$$CommentReactionFailureStateImplCopyWith<$Res> {
  __$$CommentReactionFailureStateImplCopyWithImpl(
      _$CommentReactionFailureStateImpl _value,
      $Res Function(_$CommentReactionFailureStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$CommentReactionFailureStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CommentReactionFailureStateImpl implements CommentReactionFailureState {
  const _$CommentReactionFailureStateImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PostState.commentReactionFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentReactionFailureStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentReactionFailureStateImplCopyWith<_$CommentReactionFailureStateImpl>
      get copyWith => __$$CommentReactionFailureStateImplCopyWithImpl<
          _$CommentReactionFailureStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getCategoriesLoading,
    required TResult Function(GetCategoriesResponse response)
        getCategoriesSuccess,
    required TResult Function(String error) getCategoriesFailure,
    required TResult Function() getPostsLoading,
    required TResult Function(GetPostsResponse response) getPostsSuccess,
    required TResult Function(String error) getPostsFailure,
    required TResult Function() createPostLoading,
    required TResult Function(CreatePostResponse response) createPostSuccess,
    required TResult Function(String error) createPostFailure,
    required TResult Function() getPostDetailsLoading,
    required TResult Function(PostDetailsResponse response)
        getPostDetailsSuccess,
    required TResult Function(String error) getPostDetailsFailure,
    required TResult Function() deletePostLoading,
    required TResult Function() deletePostSuccess,
    required TResult Function(String error) deletePostFailure,
    required TResult Function() postReactionLoading,
    required TResult Function() postReactionSuccess,
    required TResult Function(String error) postReactionFailure,
    required TResult Function() reportPostLoading,
    required TResult Function() reportPostSuccess,
    required TResult Function(String error) reportPostFailure,
    required TResult Function() getPollsLoading,
    required TResult Function(GetPollsResponse response) getPollsSuccess,
    required TResult Function(String error) getPollsFailure,
    required TResult Function() getCommentsLoading,
    required TResult Function(dynamic response) getCommentsSuccess,
    required TResult Function(String error) getCommentsFailure,
    required TResult Function() getACommentLoading,
    required TResult Function(dynamic response) getACommentSuccess,
    required TResult Function(String error) getACommentFailure,
    required TResult Function() saveACommentLoading,
    required TResult Function() saveACommentSuccess,
    required TResult Function(String error) saveACommentFailure,
    required TResult Function() deleteCommentLoading,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String error) deleteCommentFailure,
    required TResult Function() commentReactionLoading,
    required TResult Function() commentReactionSuccess,
    required TResult Function(String error) commentReactionFailure,
  }) {
    return commentReactionFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getCategoriesLoading,
    TResult? Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult? Function(String error)? getCategoriesFailure,
    TResult? Function()? getPostsLoading,
    TResult? Function(GetPostsResponse response)? getPostsSuccess,
    TResult? Function(String error)? getPostsFailure,
    TResult? Function()? createPostLoading,
    TResult? Function(CreatePostResponse response)? createPostSuccess,
    TResult? Function(String error)? createPostFailure,
    TResult? Function()? getPostDetailsLoading,
    TResult? Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult? Function(String error)? getPostDetailsFailure,
    TResult? Function()? deletePostLoading,
    TResult? Function()? deletePostSuccess,
    TResult? Function(String error)? deletePostFailure,
    TResult? Function()? postReactionLoading,
    TResult? Function()? postReactionSuccess,
    TResult? Function(String error)? postReactionFailure,
    TResult? Function()? reportPostLoading,
    TResult? Function()? reportPostSuccess,
    TResult? Function(String error)? reportPostFailure,
    TResult? Function()? getPollsLoading,
    TResult? Function(GetPollsResponse response)? getPollsSuccess,
    TResult? Function(String error)? getPollsFailure,
    TResult? Function()? getCommentsLoading,
    TResult? Function(dynamic response)? getCommentsSuccess,
    TResult? Function(String error)? getCommentsFailure,
    TResult? Function()? getACommentLoading,
    TResult? Function(dynamic response)? getACommentSuccess,
    TResult? Function(String error)? getACommentFailure,
    TResult? Function()? saveACommentLoading,
    TResult? Function()? saveACommentSuccess,
    TResult? Function(String error)? saveACommentFailure,
    TResult? Function()? deleteCommentLoading,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String error)? deleteCommentFailure,
    TResult? Function()? commentReactionLoading,
    TResult? Function()? commentReactionSuccess,
    TResult? Function(String error)? commentReactionFailure,
  }) {
    return commentReactionFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getCategoriesLoading,
    TResult Function(GetCategoriesResponse response)? getCategoriesSuccess,
    TResult Function(String error)? getCategoriesFailure,
    TResult Function()? getPostsLoading,
    TResult Function(GetPostsResponse response)? getPostsSuccess,
    TResult Function(String error)? getPostsFailure,
    TResult Function()? createPostLoading,
    TResult Function(CreatePostResponse response)? createPostSuccess,
    TResult Function(String error)? createPostFailure,
    TResult Function()? getPostDetailsLoading,
    TResult Function(PostDetailsResponse response)? getPostDetailsSuccess,
    TResult Function(String error)? getPostDetailsFailure,
    TResult Function()? deletePostLoading,
    TResult Function()? deletePostSuccess,
    TResult Function(String error)? deletePostFailure,
    TResult Function()? postReactionLoading,
    TResult Function()? postReactionSuccess,
    TResult Function(String error)? postReactionFailure,
    TResult Function()? reportPostLoading,
    TResult Function()? reportPostSuccess,
    TResult Function(String error)? reportPostFailure,
    TResult Function()? getPollsLoading,
    TResult Function(GetPollsResponse response)? getPollsSuccess,
    TResult Function(String error)? getPollsFailure,
    TResult Function()? getCommentsLoading,
    TResult Function(dynamic response)? getCommentsSuccess,
    TResult Function(String error)? getCommentsFailure,
    TResult Function()? getACommentLoading,
    TResult Function(dynamic response)? getACommentSuccess,
    TResult Function(String error)? getACommentFailure,
    TResult Function()? saveACommentLoading,
    TResult Function()? saveACommentSuccess,
    TResult Function(String error)? saveACommentFailure,
    TResult Function()? deleteCommentLoading,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String error)? deleteCommentFailure,
    TResult Function()? commentReactionLoading,
    TResult Function()? commentReactionSuccess,
    TResult Function(String error)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (commentReactionFailure != null) {
      return commentReactionFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(GetCategoriesLoadingState value)
        getCategoriesLoading,
    required TResult Function(GetCategoriesSuccessState value)
        getCategoriesSuccess,
    required TResult Function(GetCategoriesFailureState value)
        getCategoriesFailure,
    required TResult Function(GetPostsLoadingState value) getPostsLoading,
    required TResult Function(GetPostsSuccessState value) getPostsSuccess,
    required TResult Function(GetPostsFailureState value) getPostsFailure,
    required TResult Function(CreatePostLoadingState value) createPostLoading,
    required TResult Function(CreatePostSuccessState value) createPostSuccess,
    required TResult Function(CreatePostFailureState value) createPostFailure,
    required TResult Function(GetPostDetailsLoadingState value)
        getPostDetailsLoading,
    required TResult Function(GetPostDetailsSuccessState value)
        getPostDetailsSuccess,
    required TResult Function(GetPostDetailsFailureState value)
        getPostDetailsFailure,
    required TResult Function(DeletePostLoadingState value) deletePostLoading,
    required TResult Function(DeletePostSuccessState value) deletePostSuccess,
    required TResult Function(DeletePostFailureState value) deletePostFailure,
    required TResult Function(PostReactionLoadingState value)
        postReactionLoading,
    required TResult Function(PostReactionSuccessState value)
        postReactionSuccess,
    required TResult Function(PostReactionFailureState value)
        postReactionFailure,
    required TResult Function(ReportPostLoadingState value) reportPostLoading,
    required TResult Function(ReportPostSuccessState value) reportPostSuccess,
    required TResult Function(ReportPostFailureState value) reportPostFailure,
    required TResult Function(GetPollsLoadingState value) getPollsLoading,
    required TResult Function(GetPollsSuccessState value) getPollsSuccess,
    required TResult Function(GetPollsFailureState value) getPollsFailure,
    required TResult Function(GetCommentsLoadingState value) getCommentsLoading,
    required TResult Function(GetCommentsSuccessState value) getCommentsSuccess,
    required TResult Function(GetCommentsFailureState value) getCommentsFailure,
    required TResult Function(GetACommentLoadingState value) getACommentLoading,
    required TResult Function(GetACommentSuccessState value) getACommentSuccess,
    required TResult Function(GetACommentFailureState value) getACommentFailure,
    required TResult Function(SaveACommentLoadingState value)
        saveACommentLoading,
    required TResult Function(SaveACommentSuccessState value)
        saveACommentSuccess,
    required TResult Function(SaveACommentFailureState value)
        saveACommentFailure,
    required TResult Function(DeleteCommentLoadingState value)
        deleteCommentLoading,
    required TResult Function(DeleteCommentSuccessState value)
        deleteCommentSuccess,
    required TResult Function(DeleteCommentFailureState value)
        deleteCommentFailure,
    required TResult Function(CommentReactionLoadingState value)
        commentReactionLoading,
    required TResult Function(CommentReactionSuccessState value)
        commentReactionSuccess,
    required TResult Function(CommentReactionFailureState value)
        commentReactionFailure,
  }) {
    return commentReactionFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult? Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult? Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult? Function(GetPostsLoadingState value)? getPostsLoading,
    TResult? Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult? Function(GetPostsFailureState value)? getPostsFailure,
    TResult? Function(CreatePostLoadingState value)? createPostLoading,
    TResult? Function(CreatePostSuccessState value)? createPostSuccess,
    TResult? Function(CreatePostFailureState value)? createPostFailure,
    TResult? Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult? Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult? Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult? Function(DeletePostLoadingState value)? deletePostLoading,
    TResult? Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult? Function(DeletePostFailureState value)? deletePostFailure,
    TResult? Function(PostReactionLoadingState value)? postReactionLoading,
    TResult? Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult? Function(PostReactionFailureState value)? postReactionFailure,
    TResult? Function(ReportPostLoadingState value)? reportPostLoading,
    TResult? Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult? Function(ReportPostFailureState value)? reportPostFailure,
    TResult? Function(GetPollsLoadingState value)? getPollsLoading,
    TResult? Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult? Function(GetPollsFailureState value)? getPollsFailure,
    TResult? Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult? Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult? Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult? Function(GetACommentLoadingState value)? getACommentLoading,
    TResult? Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult? Function(GetACommentFailureState value)? getACommentFailure,
    TResult? Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult? Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult? Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult? Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult? Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult? Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult? Function(CommentReactionLoadingState value)?
        commentReactionLoading,
    TResult? Function(CommentReactionSuccessState value)?
        commentReactionSuccess,
    TResult? Function(CommentReactionFailureState value)?
        commentReactionFailure,
  }) {
    return commentReactionFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(GetCategoriesLoadingState value)? getCategoriesLoading,
    TResult Function(GetCategoriesSuccessState value)? getCategoriesSuccess,
    TResult Function(GetCategoriesFailureState value)? getCategoriesFailure,
    TResult Function(GetPostsLoadingState value)? getPostsLoading,
    TResult Function(GetPostsSuccessState value)? getPostsSuccess,
    TResult Function(GetPostsFailureState value)? getPostsFailure,
    TResult Function(CreatePostLoadingState value)? createPostLoading,
    TResult Function(CreatePostSuccessState value)? createPostSuccess,
    TResult Function(CreatePostFailureState value)? createPostFailure,
    TResult Function(GetPostDetailsLoadingState value)? getPostDetailsLoading,
    TResult Function(GetPostDetailsSuccessState value)? getPostDetailsSuccess,
    TResult Function(GetPostDetailsFailureState value)? getPostDetailsFailure,
    TResult Function(DeletePostLoadingState value)? deletePostLoading,
    TResult Function(DeletePostSuccessState value)? deletePostSuccess,
    TResult Function(DeletePostFailureState value)? deletePostFailure,
    TResult Function(PostReactionLoadingState value)? postReactionLoading,
    TResult Function(PostReactionSuccessState value)? postReactionSuccess,
    TResult Function(PostReactionFailureState value)? postReactionFailure,
    TResult Function(ReportPostLoadingState value)? reportPostLoading,
    TResult Function(ReportPostSuccessState value)? reportPostSuccess,
    TResult Function(ReportPostFailureState value)? reportPostFailure,
    TResult Function(GetPollsLoadingState value)? getPollsLoading,
    TResult Function(GetPollsSuccessState value)? getPollsSuccess,
    TResult Function(GetPollsFailureState value)? getPollsFailure,
    TResult Function(GetCommentsLoadingState value)? getCommentsLoading,
    TResult Function(GetCommentsSuccessState value)? getCommentsSuccess,
    TResult Function(GetCommentsFailureState value)? getCommentsFailure,
    TResult Function(GetACommentLoadingState value)? getACommentLoading,
    TResult Function(GetACommentSuccessState value)? getACommentSuccess,
    TResult Function(GetACommentFailureState value)? getACommentFailure,
    TResult Function(SaveACommentLoadingState value)? saveACommentLoading,
    TResult Function(SaveACommentSuccessState value)? saveACommentSuccess,
    TResult Function(SaveACommentFailureState value)? saveACommentFailure,
    TResult Function(DeleteCommentLoadingState value)? deleteCommentLoading,
    TResult Function(DeleteCommentSuccessState value)? deleteCommentSuccess,
    TResult Function(DeleteCommentFailureState value)? deleteCommentFailure,
    TResult Function(CommentReactionLoadingState value)? commentReactionLoading,
    TResult Function(CommentReactionSuccessState value)? commentReactionSuccess,
    TResult Function(CommentReactionFailureState value)? commentReactionFailure,
    required TResult orElse(),
  }) {
    if (commentReactionFailure != null) {
      return commentReactionFailure(this);
    }
    return orElse();
  }
}

abstract class CommentReactionFailureState implements PostState {
  const factory CommentReactionFailureState(final String error) =
      _$CommentReactionFailureStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$CommentReactionFailureStateImplCopyWith<_$CommentReactionFailureStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
