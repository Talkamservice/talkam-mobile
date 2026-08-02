import 'package:talkam/features/authentication/data/models/auth_response.dart'
    hide Data;
import 'package:talkam/features/post/data/models/create_post_payload.dart'
    show Attachment;
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/get_guidlines_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_test_models.dart';

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

  static List<PostCategory> get groups => [
        _category(1, "Anxiety"),
        _category(3, "Depression"),
        _category(4, "OCD"),
        _category(5, "Fear"),
        _category(6, "Psychosis"),
        _category(7, "Eating Disorder"),
        _category(8, "Relationships"),
      ];

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
}
