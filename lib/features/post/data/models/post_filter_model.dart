import 'package:freezed_annotation/freezed_annotation.dart';

class PostFilterModel {
  String? tab;
  String? category;
  int? limit;
  String? search;

  factory PostFilterModel.all() => PostFilterModel();

  factory PostFilterModel.featuredPost({String? category}) =>
      PostFilterModel(tab: 'featured', category: category);

  factory PostFilterModel.recentPost({String? category}) =>
      PostFilterModel(tab: 'latest', category: category);

  factory PostFilterModel.trendingPost({String? category}) =>
      PostFilterModel(tab: 'trending', category: category);

  factory PostFilterModel.category(
          {required String categoryId, required String tab}) =>
      PostFilterModel(tab: 'featured', category: categoryId);

  PostFilterModel({this.tab, this.category, this.limit, this.search});

  Map<String, dynamic> toJson() => {
        'tab': tab,
        'category_id': category,
        'limit': limit,
        'search': search,
      };
}
