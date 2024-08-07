import 'dart:convert';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';

import 'get_posts_response.dart';

class TestFactories {
  static TalkamPost createTalkamPost() {
    return TalkamPost(
      id: 1,
      title: "Sample Title",
      body: "Sample body content.",
      type: "text",
      isReported: false,
      uuid: "sample-uuid",
      category: createPostCategory(),
      user: createPostCreator(),
      canComment: 1,
      isAnonymous: 0,
      tags: ["sample", "test"],
      viewsCount: 0,
      commentsCount: 0,
      likesCount: 0,
      status: "published",
      publishAt: null,
      attachments: [],
      polls: [],
      reaction: createPostReaction(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static PostCategory createPostCategory() {
    return PostCategory(
      id: 1,
      name: "Sample Category",
      description: "Sample description",
      backgroundImage: "",
      followersCount: 2,
      iconImage: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isFollowing: false,
    );
  }

  static PostCreator createPostCreator() {
    return PostCreator(
      id: 1,
      avatar: "sample-avatar-url",
      name: "Sample User",
      username: "sampleuser",
      email: "sampleuser@example.com",
    );
  }

  static PostReaction createPostReaction() {
    return PostReaction(
      id: 1,
      action: "Like",
      status: true,
      createdAt: DateTime.now(),
    );
  }

  static Attachment createAttachment() {
    return Attachment(
      url: "sample-url",
      type: "image",
    );
  }

  static TalkamPoll createTalkamPoll() {
    return TalkamPoll(
      id: 1,
      option: "Sample Option",
      type: "text",
      duration: null,
      selected: false,
      count: 0,
      percentage: 0,
      anonymous: null,
      expiresAt: DateTime.now().add(Duration(days: 1)),
      createdAt: DateTime.now(),
    );
  }
}
