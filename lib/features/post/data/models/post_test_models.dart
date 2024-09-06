import 'dart:convert';
import 'dart:math';
import 'package:talkam/features/group/dormain/model/group_overview_data.dart';
import 'package:talkam/features/group/presentation/screens/group_details_screen.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';
import 'package:uuid/uuid.dart';

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
      group: null,
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
      parentCategory: null,
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

  static GroupOverViewData createDummyGroupOverview() {
    return GroupOverViewData(
      id: "dummy_id",
      name: "Dummy Group Name",
      status: "active",
      category: PostCategory(
          id: 1,
          name: "Dummy Category",
          description: 'FD',
          backgroundImage: null,
          followersCount: null,
          iconImage: null,
          createdAt: null,
          updatedAt: null,
          isFollowing: false,
          parentCategory: null),
      owner: GroupOwner(id: Random().nextInt(5), username: "Dummy Owner"),
      about: "This is a dummy group about something interesting.",
      totalMembers: 123,
    );
  }

  static GroupGuidlineTabData createDummyGroupGuidelines() {
    return GroupGuidlineTabData(
      groupDescription: "Welcome to this dummy group!",
      guidlines: [],
    );
  }

  // static GroupMembersTabData createDummyGroupMembers() {
  //   TalkamGroupMemberInfo dummyAdmin =
  //       TalkamGroupMemberInfo(id: Random().nextInt(5), username: "Admin User");
  //   TalkamGroupMemberInfo dummyMember = TalkamGroupMemberInfo(
  //       id: Random().nextInt(5), username: "Regular Member");
  //
  //   return GroupMembersTabData(
  //     admin: [dummyAdmin],
  //     members: [dummyMember],
  //     owner: [],
  //     groupId: '0001',
  //     iPreview: false, // Assuming owner is also an admin here
  //   );
  // }

  static GroupAboutData createDummyGroupAbout() {
    GroupOwner dummyCreator =
        GroupOwner(id: Random().nextInt(5), username: "Group Creator");

    return GroupAboutData(
      about: createDummyGroupOverview().about,
      creator: dummyCreator,
      isPublic: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      accesibility: "Anyone can join",
    );
  }

  // static GroupDetailsScreenParam createDummyGroupDetails() {
  //   return GroupDetailsScreenParam(
  //     isPreview: false,
  //     // Adjust as needed
  //     rulesData: createDummyGroupGuidelines(),
  //     membersData: createDummyGroupMembers(),
  //     overview: createDummyGroupOverview(),
  //     about: createDummyGroupAbout(),
  //   );
  // }

  static GroupAppBarData createDummyGroupAppBarData() {
    return GroupAppBarData(
      id: "dummy_group_id",
      isPreview: false, // Adjust as needed
      banner: Assets.images.jpegs.football.path, // Adjust as needed
      name: "Dummy Group",
    );
  }
  //
  // static GroupDetailsScreenParam createDummyGroupDetailsScreenParam() {
  //   return GroupDetailsScreenParam(
  //     isPreview: false,
  //     rulesData: createDummyGroupGuidelines(),
  //     membersData: createDummyGroupMembers(),
  //     overview: createDummyGroupOverview(),
  //     about: createDummyGroupAbout(),
  //   );
  // }

  static TalkamGroup emptyGroup = TalkamGroup(
    id: 1,
    name: 'null',
    uuid: 'null',
    userRole: null,
    status: null,
    groupAccess: null,
    image: null,
    isFollowing: null,
    hasRequested: null,
    isSuspended: null,
    totalMembers: null,
    category: null,
    guidelines: null,
    description: null,
    owner: null,
    about: null,
    createdAt: null,
    updatedAt: null,
  );
}
