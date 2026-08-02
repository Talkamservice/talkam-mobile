import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/data/repository/post_repository_impl.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/post/presentation/screens/trending_post_by_category_screen.dart';
import 'package:talkam/features/post/presentation/widgets/categories_screen_header.dart';
import 'package:talkam/features/post/presentation/widgets/category_about_tab.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key, required this.category});

  PostCategory category;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late TabController _tabController;

  final tabTitles = const ["Trending", "About"];

  int selecteIndex = 0;

  final bloc = PostBloc(PostRepositoryImpl(NetworkService()));

  @override
  void initState() {
    _tabController = TabController(length: tabTitles.length, vsync: this);
    bloc.add(
        PostEvent.getCategoryById(categoryId: widget.category.uuid.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            getCategoryLoading: () {},
            getCategorySuccess: (category) {
              widget.category = widget.category
                  .copyWith(followersCount: category.followersCount);
              setState(() {});

              logger.d("Follow updated${category.followersCount}");
            },
            getCategoriesFailure: (error) {});
      },
      builder: (context, state) {
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      CategoriesScreenHeader(
                        category: widget.category,
                        onFollowUpdated: () {
                          bloc.add(PostEvent.getCategoryById(
                              categoryId: widget.category.uuid.toString()));
                        },
                      ),
                      Container(
                        color: Pallets.grey90,
                        height: 1,
                      ),
                      Container(
                        color: context.colorScheme.surface,
                        width: 1.sw,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 4,
                              bottom: 0,
                            ),
                            child: TabBar(
                                tabAlignment: TabAlignment.center,
                                indicatorColor: context.colorScheme.primary,
                                controller: _tabController,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorWeight: 3,
                                onTap: (value) {
                                  selecteIndex = value;
                                  _pageController.jumpToPage(value);
                                  setState(() {});
                                },
                                tabs: List.generate(
                                  tabTitles.length,
                                  (index) => Tab(
                                    child: TextView(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      text: tabTitles[index],
                                      color: selecteIndex == index
                                          ? context.colorScheme.onSurface
                                          : Pallets.grey60,
                                    ),
                                  ),
                                ).toList()),
                          ),
                        ),
                      ),
                      4.verticalSpace,
                    ],
                  ),
                )
              ];
            },
            body: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int index) {
                      _tabController.animateTo(index);
                      selecteIndex = index;

                      setState(() {});
                    },
                    children: [
                      TrendingPostByCategoryScreen(
                        categoryId: widget.category.id.toString(),
                      ),
                      CategoryAboutTab(category: widget.category),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
