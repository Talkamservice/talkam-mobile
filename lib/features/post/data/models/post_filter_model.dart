import 'package:freezed_annotation/freezed_annotation.dart';

class PostFilterModel {
  String? tab;
  String? type;
  String? category;
  int? limit;
  String? search;
  String? sort;
  String? target;
  String? groupId;
  int? page;

  factory PostFilterModel.all() => PostFilterModel();

  factory PostFilterModel.featuredPost({String? category}) => PostFilterModel(tab: 'featured', category: category);

  factory PostFilterModel.groupPost({bool? isMedia = false, required String groupId, int? page}) =>
      PostFilterModel(groupId: groupId, sort: isMedia! ? "media" : "", page: page, type: isMedia ? "Media" : null);



  factory PostFilterModel.recentPost({String? category, bool? isGroup = false}) =>
      PostFilterModel(tab: 'latest', category: category, target: isGroup! ? "group" : null);

  factory PostFilterModel.trendingPost({String? category}) => PostFilterModel(tab: 'trending', category: category);

  factory PostFilterModel.category({required String categoryId, required String tab}) => PostFilterModel(tab: 'featured', category: categoryId);

  PostFilterModel({this.tab, this.category, this.limit, this.type, this.search, this.target, this.sort, this.page, this.groupId});

  Map<String, dynamic> toJson() => {
        if (tab != null) 'tab': tab,
        'category_id': category,
        'limit': limit,
        if (search != null) 'search': search,
        'group_id': groupId,
        if (type != null) 'type': type,
        if (page != null) 'page': page.toString(),
        'sort': sort,
        if (target != null) 'target': target,
      };
}
