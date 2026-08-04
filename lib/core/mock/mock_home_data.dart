import 'package:talkam/features/authentication/data/models/auth_response.dart'
    hide Data;
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart'
    show Attachment;
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/get_guidlines_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_test_models.dart';
import 'package:talkam/features/group/data/models/get_group_members_response.dart' as gm;

/// Hardcoded placeholder content for the home shell (feed, drawer profile,
/// following/private groups) while the staging backend has no seed data.
/// Deliberately unconditional — screens render this instead of whatever the
/// real API returns, so remove these call sites once real data exists.
class MockHomeData {
  MockHomeData._();

  static final TalkamUser user = TalkamUser(
    id: 1,
    avatar: "https://i.pravatar.cc/150?img=12",
    name: "David Mark",
    email: "david.mark@example.com",
    role: "user",
    age: null,
    dob: null,
    gender: null,
    state: null,
    country: null,
    currency: null,
    username: "Dipps",
    status: "active",
    interests: followingTopics,
    createdAt: DateTime(2025, 1, 10),
    shouldDisplayAd: false,
    emailVerifiedAt: DateTime(2025, 1, 10),
    updatedAt: DateTime(2025, 1, 10),
    googleId: null,
    facebookId: null,
    tiktokId: null,
    appleId: null,
    isBlocked: false,
    iamBlocked: false,
  );

  static const int followingCount = 52;
  static const int followersCount = 23;

  static PostCategory _category(int id, String name) => PostCategory(
        id: id,
        name: name,
        uuid: "category-$id",
        description: "$name discussions and support",
        backgroundImage: null,
        followersCount: 0,
        iconImage: null,
        createdAt: DateTime(2025, 1, 1),
        updatedAt: DateTime(2025, 1, 1),
        isFollowing: true,
        parentCategory: null,
        type: "Category",
        isSuspended: null,
        groupAccess: '',
      );

  static List<PostCategory> get followingTopics => [
        _category(1, "Anxiety"),
      ];

  static List<PostCategory> get privateGroups => [
        _category(2, "Anxiety"),
      ];

  /// Full mock content for each Group screen — staging has no real groups
  /// seeded yet, so every field a `CategoriesScreen` renders (hero image,
  /// description, member count/avatars, creator) is filled in here per
  /// group rather than sharing one generic placeholder.
  static final Map<int, _MockGroupInfo> _groupInfoById = {
    1: _MockGroupInfo(
      name: "Anxiety",
      description:
          "A safe space to share anxious thoughts, coping strategies, and support each other through panic, worry, and overwhelm.",
      backgroundImage: "https://picsum.photos/id/1015/800/500",
      memberCount: 46200,
      avatarSeeds: const [15, 32, 41, 51],
      creatorId: 301,
      creatorName: "Dr Adebayo",
      creatorUsername: "dr_adebayo",
      creatorAvatarSeed: 51,
    ),
    2: _MockGroupInfo(
      name: "Anxiety (Private)",
      description:
          "A private and secure space to share anxious thoughts, coping strategies, and support each other through panic, worry, and overwhelm.",
      backgroundImage: "https://picsum.photos/id/1015/800/500",
      memberCount: 1200,
      avatarSeeds: const [15, 32, 41, 51],
      creatorId: 301,
      creatorName: "Dr Adebayo",
      creatorUsername: "dr_adebayo",
      creatorAvatarSeed: 51,
    ),
    3: _MockGroupInfo(
      name: "Depression",
      description:
          "Connect with others navigating depression — share what's helping, what's hard, and a reminder that recovery isn't linear.",
      backgroundImage: "https://picsum.photos/id/1016/800/500",
      memberCount: 38700,
      avatarSeeds: const [5, 32, 22, 41],
      creatorId: 401,
      creatorName: "Dr. Chioma",
      creatorUsername: "dr_chioma",
      creatorAvatarSeed: 47,
    ),
    4: _MockGroupInfo(
      name: "OCD",
      description:
          "Support and understanding for people living with obsessive-compulsive disorder, from intrusive thoughts to exposure therapy.",
      backgroundImage: "https://picsum.photos/id/1018/800/500",
      memberCount: 21400,
      avatarSeeds: const [15, 5, 53, 32],
      creatorId: 402,
      creatorName: "Dr. Bello",
      creatorUsername: "dr_bello",
      creatorAvatarSeed: 33,
    ),
    5: _MockGroupInfo(
      name: "Fear",
      description:
          "Talk through phobias, panic, and grounding techniques with people who understand what fear really feels like.",
      backgroundImage: "https://picsum.photos/id/1024/800/500",
      memberCount: 15300,
      avatarSeeds: const [41, 51, 22, 5],
      creatorId: 403,
      creatorName: "Dr. Grace",
      creatorUsername: "dr_grace",
      creatorAvatarSeed: 44,
    ),
    6: _MockGroupInfo(
      name: "Psychosis",
      description:
          "A judgment-free space to talk about psychosis, hallucinations, and staying connected to reality and support.",
      backgroundImage: "https://picsum.photos/id/1035/800/500",
      memberCount: 8100,
      avatarSeeds: const [53, 15, 41, 22],
      creatorId: 404,
      creatorName: "Dr. Tunde",
      creatorUsername: "dr_tunde",
      creatorAvatarSeed: 12,
    ),
    7: _MockGroupInfo(
      name: "Eating Disorder",
      description:
          "Support for anyone navigating disordered eating, body image struggles, and the road to recovery.",
      backgroundImage: "https://picsum.photos/id/1039/800/500",
      memberCount: 12600,
      avatarSeeds: const [32, 53, 5, 51],
      creatorId: 405,
      creatorName: "Dr. Ngozi",
      creatorUsername: "dr_ngozi",
      creatorAvatarSeed: 29,
    ),
    8: _MockGroupInfo(
      name: "Relationships",
      description:
          "Boundaries, breakups, family, and everything in between — talk relationships with people who get it.",
      backgroundImage: "https://picsum.photos/id/1041/800/500",
      memberCount: 29800,
      avatarSeeds: const [22, 41, 32, 15],
      creatorId: 406,
      creatorName: "Dr. Efe",
      creatorUsername: "dr_efe",
      creatorAvatarSeed: 36,
    ),
  };

  static List<PostCategory> get groups => _groupInfoById.entries
      .map((entry) => _category(entry.key, entry.value.name).copyWith(
            description: entry.value.description,
            backgroundImage: entry.value.backgroundImage,
            followersCount: entry.value.memberCount,
          ))
      .toList();

  static TalkamGroup? getTalkamGroup(String id) {
    final intId = int.tryParse(id);
    if (intId == null) return null;
    final info = _groupInfoById[intId];
    if (info == null) return null;

    return TalkamGroup(
      id: intId,
      name: info.name,
      uuid: "group-$intId",
      description: info.description,
      about: "${info.description}\n\nThis group is a dedicated community for members to share experiences, ask questions, and offer advice. We welcome everyone to participate and grow together. Make sure to check the rules and respect fellow members. Feel free to start a new discussion or join an existing one!",
      image: info.backgroundImage,
      category: _category(intId, info.name),
      totalMembers: info.memberCount,
      isFollowing: true,
      hasRequested: false,
      isReported: false,
      isSuspended: false,
      groupAccess: intId == 2 ? "Closed" : "Opened",
      status: "Active",
      owner: GroupOwner(
        id: info.creatorId,
        name: info.creatorName,
        username: info.creatorUsername,
        avatar: "https://i.pravatar.cc/150?img=${info.creatorAvatarSeed}",
        email: "${info.creatorUsername}@example.com",
      ),
      guidelines: [
        GroupGuideline(
          id: 1,
          title: "Be Kind and Respectful",
          description: "Treat everyone with respect. Healthy debates are natural, but kindness is required.",
          status: "active",
        ),
        GroupGuideline(
          id: 2,
          title: "No Hate Speech or Bullying",
          description: "Make sure everyone feels safe. Bullying of any kind isn't allowed, and degrading comments about things like race, religion, culture, sexual orientation, gender or identity will not be tolerated.",
          status: "active",
        ),
        GroupGuideline(
          id: 3,
          title: "Respect Privacy",
          description: "Being part of this group requires mutual trust. Authentic, expressive discussions make groups great, but may also be sensitive and private.",
          status: "active",
        ),
      ],
      createdAt: DateTime(2022, 2, 15),
      updatedAt: DateTime(2022, 2, 15),
    );
  }

  /// Member avatars for a category's or group's screen — falls back to the
  /// Anxiety group's set for any category not in [_groupInfoById].
  static List<String> groupMemberAvatars(dynamic item) {
    final id = item is PostCategory ? item.id : (item as TalkamGroup).id;
    final seeds =
        _groupInfoById[id]?.avatarSeeds ?? const [15, 32, 41, 51];
    return seeds.map((seed) => "https://i.pravatar.cc/150?img=$seed").toList();
  }

  /// Falls back to a large placeholder count when the real followers count
  /// isn't seeded yet, matching the "46K Members" reference design.
  static int groupMemberCount(dynamic item) {
    final real = item is PostCategory ? item.followersCount : (item as TalkamGroup).totalMembers;
    if (real is num && real > 0) return real.toInt();
    return 46200;
  }

  /// "Created by" persona shown on a Group screen's About tab.
  static PostCreator groupCreator(PostCategory category) {
    final info = _groupInfoById[category.id];
    if (info == null) return _creator(301, "Dr Adebayo", "dr_adebayo", 51);
    return _creator(info.creatorId, info.creatorName, info.creatorUsername,
        info.creatorAvatarSeed);
  }

  /// True if [id] belongs to one of [posts] — these don't exist on the real
  /// backend, so the post-detail screen must not fetch them over the network.
  static bool isMockPostId(int id) => posts.any((post) => post.id == id);

  /// Category filter chips shown above the "For You"/Trending feed.
  static List<PostCategory> get feedCategories => [
        _category(1, "Anxiety"),
        _category(3, "Depression"),
        _category(8, "Relationships"),
        _category(9, "Work"),
        _category(5, "Fear"),
      ];

  static PostCreator _creator(
          int id, String name, String username, int avatarSeed) =>
      PostCreator(
        id: id,
        avatar: "https://i.pravatar.cc/150?img=$avatarSeed",
        name: name,
        username: username,
        email: "$username@example.com",
      );

  static List<TalkamPost> get posts {
    final base = TestFactories.createTalkamPost();
    final now = DateTime(2026, 8, 1, 9);

    final entries = [
      (
        title: "Small wins today",
        body:
            "Made it out of bed and went for a short walk. Some days that's enough. "
            "I used to beat myself up for not doing more, but my therapist keeps reminding me "
            "that recovery isn't linear and small, consistent steps count for a lot. Today the win "
            "was just getting outside and feeling the sun for ten minutes without spiraling into "
            "everything I still need to do. I'm trying to hold onto that instead of the guilt.",
        category: "Anxiety",
        creator: _creator(101, "Amaka Obi", "amaka_o", 5),
        likes: 34,
        comments: 6,
        hoursAgo: 1,
        image: "https://picsum.photos/id/1011/800/500",
      ),
      (
        title: "Anyone else struggle with intrusive thoughts?",
        body:
            "Looking for coping strategies that have actually worked for you. Mine tend to show up "
            "at night right when I'm trying to sleep, and the more I try to push them away the louder "
            "they get. I've tried journaling before bed and it helps a little, but I still end up lying "
            "there replaying the same worries over and over. My therapist suggested naming the thought "
            "out loud instead of arguing with it, which sounds strange but has taken some of the power "
            "out of it. Would love to hear what's worked for other people dealing with this.",
        category: "OCD",
        creator: _creator(102, "Tunde Bello", "tundeb", 15),
        likes: 21,
        comments: 12,
        hoursAgo: 3,
        image: null,
      ),
      (
        title: "Therapy update: 6 months in",
        body:
            "Started EMDR last month and it's been rough but worth it. Happy to answer questions. "
            "The first couple of sessions left me completely drained, way more than talk therapy ever "
            "did, and I wasn't expecting old memories to resurface as vividly as they did. My therapist "
            "warned me it would get harder before it got easier, and she wasn't wrong, but I'm already "
            "noticing I react differently to things that used to set me off instantly. If you're on the "
            "fence about trying it, I'd say give it a real chance before deciding it's not for you.",
        category: "Depression",
        creator: _creator(
          103,
          "Grace Ilori",
          "grace_i",
          32,
        ),
        likes: 58,
        comments: 19,
        hoursAgo: 6,
        image: "https://picsum.photos/id/1027/800/500",
      ),
      (
        title: "Setting boundaries with family",
        body:
            "Finally told my parents I need space during exam season. Felt terrifying but freeing. "
            "I've spent years feeling guilty for saying no to family obligations, especially around "
            "exam periods when I genuinely need to focus, and I always caved because I hated the "
            "disappointed silence on the other end of the phone. This time I practiced what I wanted "
            "to say with my therapist beforehand, and even though my mum wasn't thrilled, the "
            "conversation went better than I expected. Small step, but it felt like a big one for me.",
        category: "Relationships",
        creator: _creator(104, "Segun Adeyemi", "segun_a", 22),
        likes: 40,
        comments: 8,
        hoursAgo: 10,
        image: "https://picsum.photos/id/1043/800/500",
      ),
      (
        title: "Grounding technique that helps me",
        body:
            "5-4-3-2-1 senses exercise talks me down from panic almost every time. When I feel a wave "
            "coming on, I start naming five things I can see, four I can touch, three I can hear, two I "
            "can smell, and one I can taste, and by the time I get through the list my breathing has "
            "usually slowed down on its own. It doesn't make the fear disappear completely, but it gives "
            "my brain something concrete to focus on instead of spiraling further into the panic. "
            "Sharing this in case it helps someone else who's still looking for something that works.",
        category: "Fear",
        creator: _creator(105, "Bisi Okafor", "bisi_ok", 41),
        likes: 76,
        comments: 14,
        hoursAgo: 20,
        image: "https://picsum.photos/id/1062/800/500",
      ),
    ];

    return List.generate(entries.length, (index) {
      final e = entries[index];
      return base.copyWith(
        id: index + 1,
        title: e.title,
        body: e.body,
        category: _category(index + 10, e.category),
        user: e.creator,
        likesCount: e.likes,
        commentsCount: e.comments,
        viewsCount: e.likes * 3,
        attachments:
            e.image == null ? [] : [Attachment(url: e.image!, type: "image")],
        polls: [],
        createdAt: now.subtract(Duration(hours: e.hoursAgo)),
        updatedAt: now.subtract(Duration(hours: e.hoursAgo)),
      );
    });
  }

  /// Fallback for the "TalkAM Rules & Guidelines" sheet — staging has no
  /// guidelines seeded yet, so the real endpoint comes back empty.
  static List<TalkamGuidelineModel> get guidelines {
    final entries = [
      ("Respect others", "Treat fellow members with kindness and courtesy."),
      (
        "No hate speech",
        "Avoid discriminatory or offensive language based on race, ethnicity, gender, religion, etc."
      ),
      (
        "No harassment",
        "Do not engage in bullying, threats, or intimidation of others."
      ),
      ("No spamming", "Refrain from posting repetitive or irrelevant content."),
      (
        "Protect privacy",
        "Avoid sharing personal information or violating others' privacy."
      ),
      (
        "No illegal activities",
        "Do not promote or engage in illegal activities."
      ),
      (
        "Respect copyright",
        "Do not post copyrighted material without permission."
      ),
      (
        "Stay on topic",
        "Keep discussions relevant to the community's theme or purpose."
      ),
      (
        "Report violations",
        "Report any violations of the rules to moderators for review and action."
      ),
    ];

    final now = DateTime(2026, 1, 1);
    return List.generate(
      entries.length,
      (index) => TalkamGuidelineModel(
        id: index + 1,
        title: entries[index].$1,
        description: entries[index].$2,
        status: "Active",
        group: null,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  static PostComment _comment({
    required int id,
    required PostCreator user,
    required String comment,
    int likes = 0,
    int unlikes = 0,
    int hoursAgo = 1,
    List<PostComment> children = const [],
  }) {
    return PostComment(
      id: id,
      user: user,
      comment: comment,
      isAnonymous: 0,
      likes: likes,
      unlikes: unlikes,
      replyTo: null,
      attachment: null,
      reaction: null,
      children: children,
      createdAt: DateTime(2026, 8, 1, 9).subtract(Duration(hours: hoursAgo)),
      updatedAt: DateTime(2026, 8, 1, 9).subtract(Duration(hours: hoursAgo)),
    );
  }

  /// Mock commenter personas, distinct from the mock post authors so a
  /// post's own comment section doesn't just look like the author replying
  /// to themselves.
  static PostCreator get _davidChen =>
      _creator(201, "David Chen", "david_c", 51);
  static PostCreator get _efeOkonkwo =>
      _creator(202, "Efe Okonkwo", "efe_o", 52);
  static PostCreator get _ngoziEze => _creator(203, "Ngozi Eze", "ngozi_e", 53);

  /// Seed comments for a mock post's detail screen — keyed by the post's
  /// index in [posts] (1-based, matching each entry's `id`).
  static List<PostComment> commentsForPost(int postId) {
    switch (postId) {
      case 1: // "Small wins today" — Amaka Obi
        return [
          _comment(
            id: 1001,
            user: _davidChen,
            comment:
                "This resonates so much. Some days getting out of bed IS the win. Proud of you 💙",
            likes: 12,
            hoursAgo: 1,
            children: [
              _comment(
                id: 1002,
                user: _creator(101, "Amaka Obi", "amaka_o", 5),
                comment: "Thank you David, that really means a lot right now.",
                likes: 4,
                hoursAgo: 1,
              ),
            ],
          ),
          _comment(
            id: 1003,
            user: _efeOkonkwo,
            comment: "Following this thread, needed to see this today.",
            likes: 3,
            hoursAgo: 1,
          ),
        ];
      case 2: // "Anyone else struggle with intrusive thoughts?" — Tunde Bello
        return [
          _comment(
            id: 2001,
            user: _creator(103, "Grace Ilori", "grace_i", 32),
            comment:
                "Naming the thought out loud helped me too, especially with OCD-related intrusive "
                "thoughts. ERP therapy also helped a lot if you haven't looked into it.",
            likes: 9,
            hoursAgo: 2,
            children: [
              _comment(
                id: 2002,
                user: _creator(102, "Tunde Bello", "tundeb", 15),
                comment: "Thank you, I'll bring up ERP with my therapist.",
                likes: 2,
                hoursAgo: 2,
              ),
            ],
          ),
          _comment(
            id: 2003,
            user: _ngoziEze,
            comment: "You're not alone in this, sending support.",
            likes: 5,
            hoursAgo: 2,
          ),
        ];
      case 3: // "Therapy update: 6 months in" — Grace Ilori
        return [
          _comment(
            id: 3001,
            user: _creator(104, "Segun Adeyemi", "segun_a", 22),
            comment:
                "6 months of EMDR is huge. Thank you for sharing your journey so openly.",
            likes: 15,
            hoursAgo: 5,
          ),
          _comment(
            id: 3002,
            user: _creator(105, "Bisi Okafor", "bisi_ok", 41),
            comment:
                "How did you find a therapist who does EMDR? Been looking for one for months.",
            likes: 6,
            hoursAgo: 4,
            children: [
              _comment(
                id: 3003,
                user: _creator(103, "Grace Ilori", "grace_i", 32),
                comment:
                    "I found mine through the TalkAM directory, happy to share more if it helps.",
                likes: 8,
                hoursAgo: 4,
              ),
            ],
          ),
        ];
      case 4: // "Setting boundaries with family" — Segun Adeyemi
        return [
          _comment(
            id: 4001,
            user: _creator(101, "Amaka Obi", "amaka_o", 5),
            comment:
                "This is so relatable, family boundaries during exams are the hardest.",
            likes: 10,
            hoursAgo: 9,
          ),
          _comment(
            id: 4002,
            user: _davidChen,
            comment:
                "Proud of you for having that conversation, it's not easy.",
            likes: 7,
            hoursAgo: 8,
          ),
        ];
      case 5: // "Grounding technique that helps me" — Bisi Okafor
        return [
          _comment(
            id: 5001,
            user: _creator(102, "Tunde Bello", "tundeb", 15),
            comment:
                "Going to try this next time I feel a panic attack coming on, thank you!",
            likes: 11,
            hoursAgo: 18,
            children: [
              _comment(
                id: 5002,
                user: _creator(105, "Bisi Okafor", "bisi_ok", 41),
                comment: "Let me know how it goes!",
                likes: 3,
                hoursAgo: 17,
              ),
            ],
          ),
          _comment(
            id: 5003,
            user: _creator(103, "Grace Ilori", "grace_i", 32),
            comment:
                "This is one of the first things my therapist taught me too.",
            likes: 6,
            hoursAgo: 16,
          ),
        ];
      default:
        return [];
    }
  }

  static PostsPaginationData get _pagination => PostsPaginationData(
        currentPage: 1,
        firstPageUrl: null,
        from: 1,
        lastPage: 1,
        lastPageUrl: null,
        nextPageUrl: null,
        path: "",
        perPage: posts.length,
        prevPageUrl: null,
        to: posts.length,
        total: posts.length,
        canLoadMore: false,
      );

  static GetPostsResponse get postsResponse => GetPostsResponse(
        message: "OK",
        data: Data(paginationMeta: _pagination, data: posts),
        success: true,
        code: 200,
      );

  /// The signed-in "me" placeholder used as the second member of every mock
  /// conversation — never rendered directly (TalkamConversation.otherUser
  /// always resolves to the other, non-me member).
  static final ConversationUser _me = ConversationUser(
    id: -1,
    name: user.name, 
    username: user.username,
    email: user.email,
    avatar: user.avatar,
  );

  static ConversationUser _contact(int id, String name, int avatarSeed) =>
      ConversationUser(
        id: id,
        name: name,
        username: name.toLowerCase().replaceAll(' ', '_'),
        email: "${name.toLowerCase().replaceAll(' ', '.')}@example.com",
        avatar: "https://i.pravatar.cc/150?img=$avatarSeed",
      );

  /// Contact ids that should show the verified badge next to their name.
  static const Set<int> verifiedContactIds = {301};

  static LastMessage _lastMessage({
    required int conversationId,
    required int senderId,
    required String message,
    required int minutesAgo,
  }) {
    final createdAt =
        DateTime(2026, 8, 1, 9, 41).subtract(Duration(minutes: minutesAgo));
    return LastMessage(
      id: conversationId * 10,
      senderId: senderId,
      receiverId: _me.id,
      conversationId: conversationId,
      message: message,
      messageType: "Text",
      assetUrl: "",
      read: false,
      createdAt: createdAt,
      updatedAt: createdAt,
    );
  }

  /// True if [id] belongs to one of [conversations] — these don't exist on
  /// the real backend, so opening one must not hit the real chat/socket infra.
  static bool isMockConversationId(int id) =>
      conversations.any((c) => c.id == id);

  /// Conversation list shown on the Messages screen — staging has no real
  /// conversations yet, so this is the fallback when the real list is empty.
  static List<TalkamConversation> get conversations {
    final entries = [
      (
        id: 301,
        name: "Dr Adebayo",
        avatarSeed: 51,
        message: "I missed it. Heard it was a close one though. Wh...",
        minutesAgo: 12,
      ),
      (
        id: 302,
        name: "Bhandari",
        avatarSeed: 54,
        message: "It was an incredible match! The home team clinc...",
        minutesAgo: 10,
      ),
      (
        id: 303,
        name: "Chen",
        avatarSeed: 56,
        message: "I can't believe I missed it! Was it as thrilling as l...",
        minutesAgo: 9,
      ),
      (
        id: 304,
        name: "Patel",
        avatarSeed: 58,
        message: "Absolutely! The last-minute goal had everyone...",
        minutesAgo: 8,
      ),
      (
        id: 305,
        name: "Dr Smith",
        avatarSeed: 60,
        message: "I heard the referee made some controversial call...",
        minutesAgo: 7,
      ),
      (
        id: 306,
        name: "Kim",
        avatarSeed: 62,
        message: "It was wild! The atmosphere in the stadium was...",
        minutesAgo: 6,
      ),
    ];

    return entries.map((e) {
      final contact = _contact(e.id, e.name, e.avatarSeed);
      return TalkamConversation(
        id: e.id,
        members: [contact, _me],
        lastMessage: _lastMessage(
          conversationId: e.id,
          senderId: e.id,
          message: e.message,
          minutesAgo: e.minutesAgo,
        ),
        numberOfUnread: 1,
        notificationStatus: true,
        isAnonymous: false,
        requestedBy: contact,
        userBlocked: false,
        userBanned: false,
        status: "Accepted",
      );
    }).toList();
  }

  /// The mock chat thread for a conversation from [conversations] — keyed by
  /// conversation id. Dr Adebayo's thread matches the reference design
  /// exactly; everyone else gets a short generic thread built from their
  /// list preview so every mock conversation is still tappable.
  static List<AppMessageModel> chatThread(TalkamConversation conversation) {
    final other = conversation.otherUser;
    final now = DateTime(2026, 8, 2, 11, 53);

    if (other.id == 301) {
      const sent =
          'I saw "Galactic Odyssey." It was an incredible journey reminding me to care.';
      const received =
          'Yeah, I watched that new sci-fi movie "Galactic Odyssey". It was epic!';
      return [
        AppMessageModel(
          content: sent,
          iAmSender: true,
          sendingState: SendingState.success,
          time: now,
          receiverId: other.id.toString(),
          messageType: "Text",
          conversationId: conversation.id.toString(),
        ),
        AppMessageModel(
          content: received,
          iAmSender: false,
          sendingState: SendingState.success,
          time: now,
          receiverId: _me.id.toString(),
          messageType: "Text",
          conversationId: conversation.id.toString(),
        ),
        AppMessageModel(
          content: sent,
          iAmSender: true,
          sendingState: SendingState.success,
          time: now,
          receiverId: other.id.toString(),
          messageType: "Text",
          conversationId: conversation.id.toString(),
        ),
        AppMessageModel(
          content: received,
          iAmSender: false,
          sendingState: SendingState.success,
          time: now,
          receiverId: _me.id.toString(),
          messageType: "Text",
          conversationId: conversation.id.toString(),
        ),
      ];
    }

    return [
      AppMessageModel(
        content: conversation.lastMessage?.message ?? "Hey!",
        iAmSender: false,
        sendingState: SendingState.success,
        time: now.subtract(const Duration(minutes: 5)),
        receiverId: _me.id.toString(),
        messageType: "Text",
        conversationId: conversation.id.toString(),
      ),
      AppMessageModel(
        content: "Tell me more!",
        iAmSender: true,
        sendingState: SendingState.success,
        time: now,
        receiverId: other.id.toString(),
        messageType: "Text",
        conversationId: conversation.id.toString(),
      ),
    ];
  }

  static gm.GetGroupMembersResponse get mockGroupMembersResponse {
    final now = DateTime.now();
    
    gm.GroupMemberDetails createMockMember(int id, String role, String name, String username, int avatarSeed) {
      return gm.GroupMemberDetails(
        id: id,
        role: role,
        status: "active",
        isSuspended: false,
        isBanned: false,
        user: gm.GroupUser(
          id: id + 1000,
          name: name,
          username: username,
          avatar: "https://i.pravatar.cc/150?img=$avatarSeed",
          email: "$username@example.com",
        ),
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now,
      );
    }
    
    return gm.GetGroupMembersResponse(
      message: "Members fetched successfully",
      success: true,
      code: 200,
      data: gm.Data(
        owner: [
          createMockMember(1, "Owner", "Dr Adebayo", "dr_adebayo", 51),
        ],
        admin: [
          createMockMember(2, "Admin", "Dr. Chioma", "dr_chioma", 47),
        ],
        member: [
          createMockMember(3, "Member", "Alice", "alice_w", 12),
          createMockMember(4, "Member", "Bob", "bob_b", 15),
          createMockMember(5, "Member", "Charlie", "charlie_d", 32),
          createMockMember(6, "Member", "Diana", "diana_s", 41),
        ],
      )
    );
  }

  /// The Notification screen's unified feed — staging has no seed data, so
  /// this is what renders whenever the real feed comes back empty.
  static List<MockNotificationGroup> get notificationGroups => [
        MockNotificationGroup(label: "Today", items: [
          MockNotificationItem(
            type: MockNotificationType.session,
            title: "Session in 30 minutes",
            body: "Dr. Chioma • Video • 2:00 PM",
            timeAgo: "30m",
            actionLabel: "Open Session",
          ),
          MockNotificationItem(
            type: MockNotificationType.comment,
            title: "calm_water replied to your post",
            body: '"What helped me was a consistent...',
            timeAgo: "1h",
          ),
          MockNotificationItem(
            type: MockNotificationType.like,
            title: "48 people cared about your post",
            body: '"Been walking up 3am with racing th...',
            timeAgo: "2h",
          ),
          MockNotificationItem(
            type: MockNotificationType.message,
            title: "Dr. Chioma sent you message",
            body: '"Looking forward to our session t...',
            timeAgo: "3h",
          ),
        ]),
        MockNotificationGroup(label: "Yesterday", items: [
          MockNotificationItem(
            type: MockNotificationType.wellness,
            title: "TalkAM Wellness check-in",
            body: '"You haven\'t logged your moo...',
            timeAgo: "3h",
          ),
        ]),
      ];
}

/// Simple data holder for People search results (mock only).
class MockSearchUser {
  const MockSearchUser({
    required this.id,
    required this.name,
    required this.username,
    this.avatar,
    required this.bio,
    this.isVerified = true,
    this.isFollowing = false,
  });

  final int id;
  final String name;
  final String username;
  final String? avatar;
  final String bio;
  final bool isVerified;
  final bool isFollowing;
}

class MockSearchData {
  MockSearchData._();

  static const List<String> relatedTopics = [
    "Anxiety",
    "Depression",
    "Fear",
    "Grief",
    "Bipolar",
    "OCD",
  ];

  static List<MockSearchUser> get searchPeople => const [
    MockSearchUser(
      id: 1,
      name: "Dr Adebayo",
      username: "Dr Adebayo",
      avatar: "https://i.pravatar.cc/150?img=51",
      bio: "I'm a licensed therapist dedicated to helping individuals navigate life's challenges and achieve personal growth. With a compassionate...",
      isVerified: true,
    ),
    MockSearchUser(
      id: 2,
      name: "Dr Linda",
      username: "DrLinda",
      avatar: "https://i.pravatar.cc/150?img=47",
      bio: "As a clinical psychologist, I focus on cognitive-behavioral therapy for children and adolescents. My passion lies in fostering resilience and...",
      isVerified: true,
    ),
    MockSearchUser(
      id: 3,
      name: "Prof. James",
      username: "ProfJames",
      avatar: "https://i.pravatar.cc/150?img=33",
      bio: "I am a psychiatrist with over 20 years of experience in treating mood disorders. My approach combines medication management with the...",
      isVerified: true,
    ),
    MockSearchUser(
      id: 4,
      name: "Ms. Clara",
      username: "MsClara",
      avatar: null,
      bio: "As a licensed social worker, I provide counseling services that empower clients to overcome trauma and find support in their com...",
      isVerified: false,
    ),
    MockSearchUser(
      id: 5,
      name: "Dr. Samuel",
      username: "DrSamuel",
      avatar: "https://i.pravatar.cc/150?img=12",
      bio: "I am a family therapist specializing in systemic therapy. I work with families to enhance communication, resolve conflicts, and strengthe...",
      isVerified: true,
    ),
  ];

  static List<MockGroupSearchEntry> get searchGroupEntries => const [
    MockGroupSearchEntry(id: 1, name: "Anxiety", memberCount: 3200, image: "https://picsum.photos/id/1015/200/120", isJoined: true),
    MockGroupSearchEntry(id: 3, name: "Depression", memberCount: 2500, image: "https://picsum.photos/id/1016/200/120", isJoined: false),
    MockGroupSearchEntry(id: 9, name: "Mindfulness", memberCount: 4100, image: "https://picsum.photos/id/1024/200/120", isJoined: false),
  ];
}

class MockGroupSearchEntry {
  final int id;
  final String name;
  final int memberCount;
  final String image;
  final bool isJoined;

  const MockGroupSearchEntry({
    required this.id,
    required this.name,
    required this.memberCount,
    required this.image,
    required this.isJoined,
  });
}


enum MockNotificationType { session, comment, like, message, wellness }

class MockNotificationGroup {
  const MockNotificationGroup({required this.label, required this.items});

  final String label;
  final List<MockNotificationItem> items;
}

class MockNotificationItem {
  const MockNotificationItem({
    required this.type,
    required this.title,
    required this.body,
    required this.timeAgo,
    this.actionLabel,
  });

  final MockNotificationType type;
  final String title;
  final String body;
  final String timeAgo;

  /// e.g. "Open Session" — only the session-reminder card has one.
  final String? actionLabel;
}

/// Backing content for one entry in [MockHomeData._groupInfoById].
class _MockGroupInfo {
  const _MockGroupInfo({
    required this.name,
    required this.description,
    required this.backgroundImage,
    required this.memberCount,
    required this.avatarSeeds,
    required this.creatorId,
    required this.creatorName,
    required this.creatorUsername,
    required this.creatorAvatarSeed,
  });

  final String name;
  final String description;
  final String backgroundImage;
  final int memberCount;
  final List<int> avatarSeeds;
  final int creatorId;
  final String creatorName;
  final String creatorUsername;
  final int creatorAvatarSeed;
}
