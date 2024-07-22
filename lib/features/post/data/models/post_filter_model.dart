import 'package:freezed_annotation/freezed_annotation.dart';

class PostFilterModel {
  String? tab;
  String? category;
  int? limit;
  String? search;

  factory PostFilterModel.all() => PostFilterModel();

  factory PostFilterModel.featuredPost() => PostFilterModel(tab: 'featured');

  factory PostFilterModel.recentPost() => PostFilterModel(tab: 'latest');

  factory PostFilterModel.trendingPost() => PostFilterModel(tab: 'trending');

  factory PostFilterModel.category(
          {required String categoryId, required String tab}) =>
      PostFilterModel(tab: 'featured');

  PostFilterModel({this.tab, this.category, this.limit, this.search});

  Map<String, dynamic> toJson() => {
        'tab': tab,
        'category': category,
        'limit': limit,
        'search': search,
      };
}
