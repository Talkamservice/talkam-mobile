
class GroupsFilterModel {
  String? tab;
  String? category;
  int? limit;
  String? search;
  String? target;

  factory GroupsFilterModel.all() =>  GroupsFilterModel();

  factory GroupsFilterModel.featuredPost({String? category}) =>
      GroupsFilterModel(tab: 'featured', category: category);

  factory GroupsFilterModel.recommended({
    String? category,
  }) =>
      GroupsFilterModel(
        tab: 'popular',
        category: category,
      );

  factory GroupsFilterModel.trendingPost({String? category}) =>
      GroupsFilterModel(tab: 'trending', category: category);

  factory GroupsFilterModel.category(
          {required String categoryId, required String tab}) =>
      GroupsFilterModel(tab: 'featured', category: categoryId);

  GroupsFilterModel(
      {this.tab, this.category, this.limit, this.search, this.target});

  Map<String, dynamic> toJson() => {
        'tab': tab,
        'category_id': category,
        'limit': limit,
        'search': search,
        if (target != null) 'target': target,
      };
}
