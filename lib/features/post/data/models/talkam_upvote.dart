class TalkamUpvote {
  final int id;
  final DateTime createdAt;
  final String title;
  final String body;
  final List<String> tags;
  final int? categoryId;
  final String? categoryName;
  final String? categoryDesc;
  final String? categoryIconImage;

  TalkamUpvote({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
    this.tags = const [],
    this.categoryId,
    this.categoryDesc,
    this.categoryIconImage,
    this.categoryName,
  });

  factory TalkamUpvote.fromJson(Map<String, dynamic> json) {
    return TalkamUpvote(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      title: json['title'],
      body: json['body'],
      categoryId: json['category'] != null ? json['category']['id'] : null,
      categoryName: json['category'] != null ? json['category']['name'] : null,
      categoryIconImage: json['category'] != null ? json['category']['icon_image'] : null,
      categoryDesc: json['category'] != null ? json['category']['description'] : null,
    );
  }
}
