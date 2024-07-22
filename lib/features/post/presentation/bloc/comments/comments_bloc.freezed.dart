// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comments_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CommentsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(PostComment? comment) selectCommentForReply,
    required TResult Function(String postId, bool? reload) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(PostComment? comment)? selectCommentForReply,
    TResult? Function(String postId, bool? reload)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(PostComment? comment)? selectCommentForReply,
    TResult Function(String postId, bool? reload)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_SelectCommentEvent value) selectCommentForReply,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_SelectCommentEvent value)? selectCommentForReply,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_SelectCommentEvent value)? selectCommentForReply,
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
abstract class $CommentsEventCopyWith<$Res> {
  factory $CommentsEventCopyWith(
          CommentsEvent value, $Res Function(CommentsEvent) then) =
      _$CommentsEventCopyWithImpl<$Res, CommentsEvent>;
}

/// @nodoc
class _$CommentsEventCopyWithImpl<$Res, $Val extends CommentsEvent>
    implements $CommentsEventCopyWith<$Res> {
  _$CommentsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$CommentsEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'CommentsEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(PostComment? comment) selectCommentForReply,
    required TResult Function(String postId, bool? reload) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(PostComment? comment)? selectCommentForReply,
    TResult? Function(String postId, bool? reload)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(PostComment? comment)? selectCommentForReply,
    TResult Function(String postId, bool? reload)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_SelectCommentEvent value) selectCommentForReply,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_SelectCommentEvent value)? selectCommentForReply,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_SelectCommentEvent value)? selectCommentForReply,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements CommentsEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$SelectCommentEventImplCopyWith<$Res> {
  factory _$$SelectCommentEventImplCopyWith(_$SelectCommentEventImpl value,
          $Res Function(_$SelectCommentEventImpl) then) =
      __$$SelectCommentEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PostComment? comment});
}

/// @nodoc
class __$$SelectCommentEventImplCopyWithImpl<$Res>
    extends _$CommentsEventCopyWithImpl<$Res, _$SelectCommentEventImpl>
    implements _$$SelectCommentEventImplCopyWith<$Res> {
  __$$SelectCommentEventImplCopyWithImpl(_$SelectCommentEventImpl _value,
      $Res Function(_$SelectCommentEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comment = freezed,
  }) {
    return _then(_$SelectCommentEventImpl(
      freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as PostComment?,
    ));
  }
}

/// @nodoc

class _$SelectCommentEventImpl implements _SelectCommentEvent {
  const _$SelectCommentEventImpl(this.comment);

  @override
  final PostComment? comment;

  @override
  String toString() {
    return 'CommentsEvent.selectCommentForReply(comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectCommentEventImpl &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectCommentEventImplCopyWith<_$SelectCommentEventImpl> get copyWith =>
      __$$SelectCommentEventImplCopyWithImpl<_$SelectCommentEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(PostComment? comment) selectCommentForReply,
    required TResult Function(String postId, bool? reload) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return selectCommentForReply(comment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(PostComment? comment)? selectCommentForReply,
    TResult? Function(String postId, bool? reload)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return selectCommentForReply?.call(comment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(PostComment? comment)? selectCommentForReply,
    TResult Function(String postId, bool? reload)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (selectCommentForReply != null) {
      return selectCommentForReply(comment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_SelectCommentEvent value) selectCommentForReply,
    required TResult Function(_GetCommentsEvent value) getComments,
    required TResult Function(_GetACommentEvent value) getAComment,
    required TResult Function(_SaveACommentEvent value) saveAComment,
    required TResult Function(_DeleteCommentEvent value) deleteComment,
    required TResult Function(_CommentReactionEvent value) commentReaction,
  }) {
    return selectCommentForReply(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_SelectCommentEvent value)? selectCommentForReply,
    TResult? Function(_GetCommentsEvent value)? getComments,
    TResult? Function(_GetACommentEvent value)? getAComment,
    TResult? Function(_SaveACommentEvent value)? saveAComment,
    TResult? Function(_DeleteCommentEvent value)? deleteComment,
    TResult? Function(_CommentReactionEvent value)? commentReaction,
  }) {
    return selectCommentForReply?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_SelectCommentEvent value)? selectCommentForReply,
    TResult Function(_GetCommentsEvent value)? getComments,
    TResult Function(_GetACommentEvent value)? getAComment,
    TResult Function(_SaveACommentEvent value)? saveAComment,
    TResult Function(_DeleteCommentEvent value)? deleteComment,
    TResult Function(_CommentReactionEvent value)? commentReaction,
    required TResult orElse(),
  }) {
    if (selectCommentForReply != null) {
      return selectCommentForReply(this);
    }
    return orElse();
  }
}

abstract class _SelectCommentEvent implements CommentsEvent {
  const factory _SelectCommentEvent(final PostComment? comment) =
      _$SelectCommentEventImpl;

  PostComment? get comment;
  @JsonKey(ignore: true)
  _$$SelectCommentEventImplCopyWith<_$SelectCommentEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetCommentsEventImplCopyWith<$Res> {
  factory _$$GetCommentsEventImplCopyWith(_$GetCommentsEventImpl value,
          $Res Function(_$GetCommentsEventImpl) then) =
      __$$GetCommentsEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId, bool? reload});
}

/// @nodoc
class __$$GetCommentsEventImplCopyWithImpl<$Res>
    extends _$CommentsEventCopyWithImpl<$Res, _$GetCommentsEventImpl>
    implements _$$GetCommentsEventImplCopyWith<$Res> {
  __$$GetCommentsEventImplCopyWithImpl(_$GetCommentsEventImpl _value,
      $Res Function(_$GetCommentsEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? reload = freezed,
  }) {
    return _then(_$GetCommentsEventImpl(
      null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      reload: freezed == reload
          ? _value.reload
          : reload // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$GetCommentsEventImpl implements _GetCommentsEvent {
  const _$GetCommentsEventImpl(this.postId, {this.reload});

  @override
  final String postId;
  @override
  final bool? reload;

  @override
  String toString() {
    return 'CommentsEvent.getComments(postId: $postId, reload: $reload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCommentsEventImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.reload, reload) || other.reload == reload));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, reload);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCommentsEventImplCopyWith<_$GetCommentsEventImpl> get copyWith =>
      __$$GetCommentsEventImplCopyWithImpl<_$GetCommentsEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(PostComment? comment) selectCommentForReply,
    required TResult Function(String postId, bool? reload) getComments,
    required TResult Function(String commentId) getAComment,
    required TResult Function(SaveCommentPayload payload) saveAComment,
    required TResult Function(String commentId) deleteComment,
    required TResult Function(String commentId, String action) commentReaction,
  }) {
    return getComments(postId, reload);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(PostComment? comment)? selectCommentForReply,
    TResult? Function(String postId, bool? reload)? getComments,
    TResult? Function(String commentId)? getAComment,
    TResult? Function(SaveCommentPayload payload)? saveAComment,
    TResult? Function(String commentId)? deleteComment,
    TResult? Function(String commentId, String action)? commentReaction,
  }) {
    return getComments?.call(postId, reload);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(PostComment? comment)? selectCommentForReply,
    TResult Function(String postId, bool? reload)? getComments,
    TResult Function(String commentId)? getAComment,
    TResult Function(SaveCommentPayload payload)? saveAComment,
    TResult Function(String commentId)? deleteComment,
    TResult Function(String commentId, String action)? commentReaction,
    required TResult orElse(),
  }) {
    if (getComments != null) {
      return getComments(postId, reload);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_SelectCommentEvent value) selectCommentForReply,
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
    TResult? Function(_Started value)? started,
    TResult? Function(_SelectCommentEvent value)? selectCommentForReply,
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
    TResult Function(_Started value)? started,
    TResult Function(_SelectCommentEvent value)? selectCommentForReply,
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

abstract class _GetCommentsEvent implements CommentsEvent {
  const factory _GetCommentsEvent(final String postId, {final bool? reload}) =
      _$GetCommentsEventImpl;

  String get postId;
  bool? get reload;
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
    extends _$CommentsEventCopyWithImpl<$Res, _$GetACommentEventImpl>
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
    return 'CommentsEvent.getAComment(commentId: $commentId)';
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
    required TResult Function() started,
    required TResult Function(PostComment? comment) selectCommentForReply,
    required TResult Function(String postId, bool? reload) getComments,
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
    TResult? Function()? started,
    TResult? Function(PostComment? comment)? selectCommentForReply,
    TResult? Function(String postId, bool? reload)? getComments,
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
    TResult Function()? started,
    TResult Function(PostComment? comment)? selectCommentForReply,
    TResult Function(String postId, bool? reload)? getComments,
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
    required TResult Function(_Started value) started,
    required TResult Function(_SelectCommentEvent value) selectCommentForReply,
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
    TResult? Function(_Started value)? started,
    TResult? Function(_SelectCommentEvent value)? selectCommentForReply,
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
    TResult Function(_Started value)? started,
    TResult Function(_SelectCommentEvent value)? selectCommentForReply,
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

abstract class _GetACommentEvent implements CommentsEvent {
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
    extends _$CommentsEventCopyWithImpl<$Res, _$SaveACommentEventImpl>
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
    return 'CommentsEvent.saveAComment(payload: $payload)';
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
    required TResult Function() started,
    required TResult Function(PostComment? comment) selectCommentForReply,
    required TResult Function(String postId, bool? reload) getComments,
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
    TResult? Function()? started,
    TResult? Function(PostComment? comment)? selectCommentForReply,
    TResult? Function(String postId, bool? reload)? getComments,
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
    TResult Function()? started,
    TResult Function(PostComment? comment)? selectCommentForReply,
    TResult Function(String postId, bool? reload)? getComments,
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
    required TResult Function(_Started value) started,
    required TResult Function(_SelectCommentEvent value) selectCommentForReply,
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
    TResult? Function(_Started value)? started,
    TResult? Function(_SelectCommentEvent value)? selectCommentForReply,
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
    TResult Function(_Started value)? started,
    TResult Function(_SelectCommentEvent value)? selectCommentForReply,
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

abstract class _SaveACommentEvent implements CommentsEvent {
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
    extends _$CommentsEventCopyWithImpl<$Res, _$DeleteCommentEventImpl>
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
    return 'CommentsEvent.deleteComment(commentId: $commentId)';
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
    required TResult Function() started,
    required TResult Function(PostComment? comment) selectCommentForReply,
    required TResult Function(String postId, bool? reload) getComments,
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
    TResult? Function()? started,
    TResult? Function(PostComment? comment)? selectCommentForReply,
    TResult? Function(String postId, bool? reload)? getComments,
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
    TResult Function()? started,
    TResult Function(PostComment? comment)? selectCommentForReply,
    TResult Function(String postId, bool? reload)? getComments,
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
    required TResult Function(_Started value) started,
    required TResult Function(_SelectCommentEvent value) selectCommentForReply,
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
    TResult? Function(_Started value)? started,
    TResult? Function(_SelectCommentEvent value)? selectCommentForReply,
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
    TResult Function(_Started value)? started,
    TResult Function(_SelectCommentEvent value)? selectCommentForReply,
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

abstract class _DeleteCommentEvent implements CommentsEvent {
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
    extends _$CommentsEventCopyWithImpl<$Res, _$CommentReactionEventImpl>
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
    return 'CommentsEvent.commentReaction(commentId: $commentId, action: $action)';
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
    required TResult Function() started,
    required TResult Function(PostComment? comment) selectCommentForReply,
    required TResult Function(String postId, bool? reload) getComments,
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
    TResult? Function()? started,
    TResult? Function(PostComment? comment)? selectCommentForReply,
    TResult? Function(String postId, bool? reload)? getComments,
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
    TResult Function()? started,
    TResult Function(PostComment? comment)? selectCommentForReply,
    TResult Function(String postId, bool? reload)? getComments,
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
    required TResult Function(_Started value) started,
    required TResult Function(_SelectCommentEvent value) selectCommentForReply,
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
    TResult? Function(_Started value)? started,
    TResult? Function(_SelectCommentEvent value)? selectCommentForReply,
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
    TResult Function(_Started value)? started,
    TResult Function(_SelectCommentEvent value)? selectCommentForReply,
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

abstract class _CommentReactionEvent implements CommentsEvent {
  const factory _CommentReactionEvent(
      final String commentId, final String action) = _$CommentReactionEventImpl;

  String get commentId;
  String get action;
  @JsonKey(ignore: true)
  _$$CommentReactionEventImplCopyWith<_$CommentReactionEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CommentsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentsStateCopyWith<$Res> {
  factory $CommentsStateCopyWith(
          CommentsState value, $Res Function(CommentsState) then) =
      _$CommentsStateCopyWithImpl<$Res, CommentsState>;
}

/// @nodoc
class _$CommentsStateCopyWithImpl<$Res, $Val extends CommentsState>
    implements $CommentsStateCopyWith<$Res> {
  _$CommentsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$CommentsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'CommentsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements CommentsState {
  const factory _Initial() = _$InitialImpl;
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
    extends _$CommentsStateCopyWithImpl<$Res, _$GetCommentsLoadingStateImpl>
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
    return 'CommentsState.getCommentsLoading()';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return getCommentsLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return getCommentsLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return getCommentsLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return getCommentsLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (getCommentsLoading != null) {
      return getCommentsLoading(this);
    }
    return orElse();
  }
}

abstract class GetCommentsLoadingState implements CommentsState {
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
    extends _$CommentsStateCopyWithImpl<$Res, _$GetCommentsSuccessStateImpl>
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
    return 'CommentsState.getCommentsSuccess(response: $response)';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return getCommentsSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return getCommentsSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return getCommentsSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return getCommentsSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (getCommentsSuccess != null) {
      return getCommentsSuccess(this);
    }
    return orElse();
  }
}

abstract class GetCommentsSuccessState implements CommentsState {
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
    extends _$CommentsStateCopyWithImpl<$Res, _$GetCommentsFailureStateImpl>
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
    return 'CommentsState.getCommentsFailure(error: $error)';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return getCommentsFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return getCommentsFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return getCommentsFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return getCommentsFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (getCommentsFailure != null) {
      return getCommentsFailure(this);
    }
    return orElse();
  }
}

abstract class GetCommentsFailureState implements CommentsState {
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
    extends _$CommentsStateCopyWithImpl<$Res, _$GetACommentLoadingStateImpl>
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
    return 'CommentsState.getACommentLoading()';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return getACommentLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return getACommentLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return getACommentLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return getACommentLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (getACommentLoading != null) {
      return getACommentLoading(this);
    }
    return orElse();
  }
}

abstract class GetACommentLoadingState implements CommentsState {
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
    extends _$CommentsStateCopyWithImpl<$Res, _$GetACommentSuccessStateImpl>
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
    return 'CommentsState.getACommentSuccess(response: $response)';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return getACommentSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return getACommentSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return getACommentSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return getACommentSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (getACommentSuccess != null) {
      return getACommentSuccess(this);
    }
    return orElse();
  }
}

abstract class GetACommentSuccessState implements CommentsState {
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
    extends _$CommentsStateCopyWithImpl<$Res, _$GetACommentFailureStateImpl>
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
    return 'CommentsState.getACommentFailure(error: $error)';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return getACommentFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return getACommentFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return getACommentFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return getACommentFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (getACommentFailure != null) {
      return getACommentFailure(this);
    }
    return orElse();
  }
}

abstract class GetACommentFailureState implements CommentsState {
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
    extends _$CommentsStateCopyWithImpl<$Res, _$SaveACommentLoadingStateImpl>
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
    return 'CommentsState.saveACommentLoading()';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return saveACommentLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return saveACommentLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return saveACommentLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return saveACommentLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (saveACommentLoading != null) {
      return saveACommentLoading(this);
    }
    return orElse();
  }
}

abstract class SaveACommentLoadingState implements CommentsState {
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
    extends _$CommentsStateCopyWithImpl<$Res, _$SaveACommentSuccessStateImpl>
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
    return 'CommentsState.saveACommentSuccess()';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return saveACommentSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return saveACommentSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return saveACommentSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return saveACommentSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (saveACommentSuccess != null) {
      return saveACommentSuccess(this);
    }
    return orElse();
  }
}

abstract class SaveACommentSuccessState implements CommentsState {
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
    extends _$CommentsStateCopyWithImpl<$Res, _$SaveACommentFailureStateImpl>
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
    return 'CommentsState.saveACommentFailure(error: $error)';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return saveACommentFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return saveACommentFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return saveACommentFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return saveACommentFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (saveACommentFailure != null) {
      return saveACommentFailure(this);
    }
    return orElse();
  }
}

abstract class SaveACommentFailureState implements CommentsState {
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
    extends _$CommentsStateCopyWithImpl<$Res, _$DeleteCommentLoadingStateImpl>
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
    return 'CommentsState.deleteCommentLoading()';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return deleteCommentLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return deleteCommentLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return deleteCommentLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return deleteCommentLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (deleteCommentLoading != null) {
      return deleteCommentLoading(this);
    }
    return orElse();
  }
}

abstract class DeleteCommentLoadingState implements CommentsState {
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
    extends _$CommentsStateCopyWithImpl<$Res, _$DeleteCommentSuccessStateImpl>
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
    return 'CommentsState.deleteCommentSuccess()';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return deleteCommentSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return deleteCommentSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return deleteCommentSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return deleteCommentSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (deleteCommentSuccess != null) {
      return deleteCommentSuccess(this);
    }
    return orElse();
  }
}

abstract class DeleteCommentSuccessState implements CommentsState {
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
    extends _$CommentsStateCopyWithImpl<$Res, _$DeleteCommentFailureStateImpl>
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
    return 'CommentsState.deleteCommentFailure(error: $error)';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return deleteCommentFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return deleteCommentFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return deleteCommentFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return deleteCommentFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (deleteCommentFailure != null) {
      return deleteCommentFailure(this);
    }
    return orElse();
  }
}

abstract class DeleteCommentFailureState implements CommentsState {
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
    extends _$CommentsStateCopyWithImpl<$Res, _$CommentReactionLoadingStateImpl>
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
    return 'CommentsState.commentReactionLoading()';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return commentReactionLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return commentReactionLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return commentReactionLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return commentReactionLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (commentReactionLoading != null) {
      return commentReactionLoading(this);
    }
    return orElse();
  }
}

abstract class CommentReactionLoadingState implements CommentsState {
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
    extends _$CommentsStateCopyWithImpl<$Res, _$CommentReactionSuccessStateImpl>
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
    return 'CommentsState.commentReactionSuccess()';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return commentReactionSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return commentReactionSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return commentReactionSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return commentReactionSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (commentReactionSuccess != null) {
      return commentReactionSuccess(this);
    }
    return orElse();
  }
}

abstract class CommentReactionSuccessState implements CommentsState {
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
    extends _$CommentsStateCopyWithImpl<$Res, _$CommentReactionFailureStateImpl>
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
    return 'CommentsState.commentReactionFailure(error: $error)';
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return commentReactionFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return commentReactionFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
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
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return commentReactionFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return commentReactionFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (commentReactionFailure != null) {
      return commentReactionFailure(this);
    }
    return orElse();
  }
}

abstract class CommentReactionFailureState implements CommentsState {
  const factory CommentReactionFailureState(final String error) =
      _$CommentReactionFailureStateImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$CommentReactionFailureStateImplCopyWith<_$CommentReactionFailureStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CommentStaggedStateImplCopyWith<$Res> {
  factory _$$CommentStaggedStateImplCopyWith(_$CommentStaggedStateImpl value,
          $Res Function(_$CommentStaggedStateImpl) then) =
      __$$CommentStaggedStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PostComment? comment});
}

/// @nodoc
class __$$CommentStaggedStateImplCopyWithImpl<$Res>
    extends _$CommentsStateCopyWithImpl<$Res, _$CommentStaggedStateImpl>
    implements _$$CommentStaggedStateImplCopyWith<$Res> {
  __$$CommentStaggedStateImplCopyWithImpl(_$CommentStaggedStateImpl _value,
      $Res Function(_$CommentStaggedStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comment = freezed,
  }) {
    return _then(_$CommentStaggedStateImpl(
      freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as PostComment?,
    ));
  }
}

/// @nodoc

class _$CommentStaggedStateImpl implements CommentStaggedState {
  const _$CommentStaggedStateImpl(this.comment);

  @override
  final PostComment? comment;

  @override
  String toString() {
    return 'CommentsState.commentStaged(comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentStaggedStateImpl &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentStaggedStateImplCopyWith<_$CommentStaggedStateImpl> get copyWith =>
      __$$CommentStaggedStateImplCopyWithImpl<_$CommentStaggedStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return commentStaged(comment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return commentStaged?.call(comment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (commentStaged != null) {
      return commentStaged(comment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return commentStaged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return commentStaged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (commentStaged != null) {
      return commentStaged(this);
    }
    return orElse();
  }
}

abstract class CommentStaggedState implements CommentsState {
  const factory CommentStaggedState(final PostComment? comment) =
      _$CommentStaggedStateImpl;

  PostComment? get comment;
  @JsonKey(ignore: true)
  _$$CommentStaggedStateImplCopyWith<_$CommentStaggedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StaggedCommentRemovedImplCopyWith<$Res> {
  factory _$$StaggedCommentRemovedImplCopyWith(
          _$StaggedCommentRemovedImpl value,
          $Res Function(_$StaggedCommentRemovedImpl) then) =
      __$$StaggedCommentRemovedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StaggedCommentRemovedImplCopyWithImpl<$Res>
    extends _$CommentsStateCopyWithImpl<$Res, _$StaggedCommentRemovedImpl>
    implements _$$StaggedCommentRemovedImplCopyWith<$Res> {
  __$$StaggedCommentRemovedImplCopyWithImpl(_$StaggedCommentRemovedImpl _value,
      $Res Function(_$StaggedCommentRemovedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StaggedCommentRemovedImpl implements StaggedCommentRemoved {
  const _$StaggedCommentRemovedImpl();

  @override
  String toString() {
    return 'CommentsState.stagedCommentRemoved()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaggedCommentRemovedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
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
    required TResult Function(PostComment? comment) commentStaged,
    required TResult Function() stagedCommentRemoved,
  }) {
    return stagedCommentRemoved();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
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
    TResult? Function(PostComment? comment)? commentStaged,
    TResult? Function()? stagedCommentRemoved,
  }) {
    return stagedCommentRemoved?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    TResult Function(PostComment? comment)? commentStaged,
    TResult Function()? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (stagedCommentRemoved != null) {
      return stagedCommentRemoved();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
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
    required TResult Function(CommentStaggedState value) commentStaged,
    required TResult Function(StaggedCommentRemoved value) stagedCommentRemoved,
  }) {
    return stagedCommentRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
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
    TResult? Function(CommentStaggedState value)? commentStaged,
    TResult? Function(StaggedCommentRemoved value)? stagedCommentRemoved,
  }) {
    return stagedCommentRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
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
    TResult Function(CommentStaggedState value)? commentStaged,
    TResult Function(StaggedCommentRemoved value)? stagedCommentRemoved,
    required TResult orElse(),
  }) {
    if (stagedCommentRemoved != null) {
      return stagedCommentRemoved(this);
    }
    return orElse();
  }
}

abstract class StaggedCommentRemoved implements CommentsState {
  const factory StaggedCommentRemoved() = _$StaggedCommentRemovedImpl;
}
