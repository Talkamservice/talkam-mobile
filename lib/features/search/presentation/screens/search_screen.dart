import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/common/widgets/typeahead_widget.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/search/data/models/get_search_response.dart';
import 'package:talkam/features/search/dormain/repository%20/search_repository_impl.dart';
import 'package:talkam/features/search/presentation/blocs/search/search_cubit.dart';
import 'package:talkam/gen/assets.gen.dart';

import '../../data/repository/search_repository.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    injector.get<SearchCubit>().loadSearchScreen();
    super.initState();
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            injector.get<SearchCubit>().loadSearchScreen();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchAppBar(),
                8.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GenericTypeAheadField<SearchResponse>(
                    labelText: "Search talKAM",
                    suggestionsCallback: (query) async {
                      logger.w(query);
                      return (await injector
                              .get<SearchRepository>()
                              .fetchSearchSuggestions(query))
                          .data;
                    },
                    itemBuilder: (context, suggestion) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 5),
                        child: TextView(text: suggestion.word),
                      );
                    },
                    builder: (p0, p1, p2) {
                      return SearchField(
                        controller: p1,
                        focusNode: p2,
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      injector.get<SearchCubit>().fetchRecentSearches();
                      context
                          .pushNamed(PageUrl.searchResultScreen,
                              extra: suggestion.word)
                          .then(
                        (value) {
                          FocusScope.of(context).unfocus();
                          injector
                              .get<SearchCubit>()
                              .fetchRecentSearches(reload: false);
                        },
                      );
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //   child: GenericTypeAheadField<SearchResponse>(
                //     labelText: "Search talKAM",
                //     suggestionsCallback: (query) async {
                //
                //       logger.w(query);
                //       return (await injector
                //               .get<SearchRepository>()
                //               .fetchSearchSuggestions())
                //           .data;
                //     },
                //     itemBuilder: (context, suggestion) {
                //       return TextView(text: suggestion.word);
                //     },
                //     builder: (p0, p1, p2) {
                //       return SearchField(
                //         controller: p1,
                //       );
                //     },
                //     onSuggestionSelected: (suggestion) {},
                //   ),
                // ),
                8.verticalSpace,
                const Divider(
                  indent: 0,
                  height: 2,
                ),
                Container(
                  width: 1.sw,
                  height: 1.sh,
                  decoration: BoxDecoration(color: context.colorScheme.surface),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      19.verticalSpace,
                      const TextView(
                        text: "Trending searches",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      11.verticalSpace,
                      BlocConsumer<SearchCubit, SearchState>(
                        bloc: injector.get(),
                        buildWhen: stateIsTrending,
                        listener: (context, state) {},
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () => 0.verticalSpace,
                            fetchTrendingSearchesLoading: () {
                              return SizedBox(
                                height: 200,
                                child: Center(
                                  child: CustomDialogs.getLoading(size: 50),
                                ),
                              );
                            },
                            fetchTrendingSearchesFailure: (error) {
                              return AppPromptWidget(
                                onTap: () => injector
                                    .get<SearchCubit>()
                                    .fetchTrendingSearches(),
                              );
                            },
                            fetchTrendingSearchesSuccess: (response) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (response.data.isNotEmpty)
                                    Wrap(
                                      spacing: 4,
                                      runSpacing: 8,
                                      children: List.generate(
                                        response.data.length,
                                        (index) => InkWell(
                                          onTap: () {
                                            context
                                                .pushNamed(
                                                    PageUrl.searchResultScreen,
                                                    extra: response
                                                        .data[index].word)
                                                .then(
                                              (value) {
                                                injector
                                                    .get<SearchCubit>()
                                                    .fetchRecentSearches(
                                                        reload: false);
                                              },
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.r),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Pallets.borderGrey,
                                                )),
                                            child: TextView(
                                                text:
                                                    response.data[index].word),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (response.data.isEmpty)
                                    const SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: TextView(
                                            text:
                                                "You have no recent searches"),
                                      ),
                                    )
                                ],
                              );
                            },
                          );
                        },
                      ),
                      41.verticalSpace,
                      const TextView(
                        text: "Recent searches",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      11.verticalSpace,
                      BlocConsumer<SearchCubit, SearchState>(
                        bloc: injector.get(),
                        buildWhen: _buildWhen,
                        listener: (context, state) {},
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () => 0.verticalSpace,
                            fetchRecentSearchesLoading: () {
                              return SizedBox(
                                height: 200,
                                child: Center(
                                  child: CustomDialogs.getLoading(size: 50),
                                ),
                              );
                            },
                            fetchRecentSearchesFailure: (error) {
                              return AppPromptWidget(
                                onTap: () => injector
                                    .get<SearchCubit>()
                                    .loadSearchScreen(),
                              );
                            },
                            fetchRecentSearchesSuccess: (response) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (response.data.isNotEmpty)
                                    ...List.generate(
                                      response.data.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                        child: _RecentSearchItem(
                                          response: response.data[index],
                                          onDelete: () {
                                            response.data
                                                .remove(response.data[index]);
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  if (response.data.isEmpty)
                                    const SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: TextView(
                                            text:
                                                "You have no recent searches"),
                                      ),
                                    )
                                ],
                              );
                            },
                          );
                        },
                      )

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool stateIsTrending(SearchState previous, SearchState current) {
    return current.maybeWhen(
      orElse: () => false,
      fetchTrendingSearchesSuccess: (response) => true,
      fetchTrendingSearchesFailure: (error) => true,
      fetchTrendingSearchesLoading: () => true,
    );
  }

  bool _buildWhen(SearchState previous, SearchState current) {
    return current.maybeWhen(
      orElse: () => false,
      fetchRecentSearchesSuccess: (response) => true,
      fetchRecentSearchesFailure: (error) => true,
      fetchRecentSearchesLoading: () => true,
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.controller, this.focusNode});

  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,

      // keyboardType: TextInputType.,

      onSubmitted: (value) {
        if (controller.text.isNotEmpty) {
          injector.get<SearchCubit>().fetchRecentSearches();
          context
              .pushNamed(PageUrl.searchResultScreen, extra: controller.text)
              .then(
            (value) {
              injector.get<SearchCubit>().fetchRecentSearches(reload: false);
            },
          );
        }
      },
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(13.0),
          child: ImageWidget(
            imageUrl: Assets.images.svgs.search,
            color: Pallets.grey,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: "Search talKAM",
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Pallets.borderGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Pallets.borderGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Pallets.borderGrey,
          ),
        ),
      ),
    );
  }
}

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 1, right: 18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      context.read<DrawerCubit>().closeDrawer();
                      context.read<DrawerCubit>().openDrawer();
            /**/
                    },
                    icon: Icon(
                      Icons.menu_outlined,
                      color: context.colorScheme.onSurface,
                    )),
                ImageWidget(imageUrl: Assets.images.svgs.logo2),
                const Spacer(),
                InkWell(
                  onTap: () {
                    // SessionManager.instance.logOut();
                    // context.goNamed(PageUrl.onboardingIntro);

                    // context.pushNamed(PageUrl.notifications);
                  },
                  child: ImageWidget(
                    imageUrl: Assets.images.svgs.notification,
                    onTap: () {
                      // context.pushNamed(PageUrl.notifications);
                    },
                  ),
                ),
                20.horizontalSpace,
                GuestUserHelper.guestUserWidget(
                    widget: ImageWidget(
                  imageUrl: injector.get<ProfileBloc>().appUser?.avatar ??
                      Assets.images.svgs.uploadAvatar,
                  fit: BoxFit.scaleDown,
                  size: 40,
                  onTap: () {
                    context.pushNamed(PageUrl.profileScreen);
                  },
                )),
              ],
            ),

            const Divider(thickness: 1,)
          ],
        ),
      ),
    );
  }
}

class _RecentSearchItem extends StatelessWidget {
  const _RecentSearchItem(
      {super.key, required this.response, required this.onDelete});

  final SearchResponse response;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        injector.get<SearchCubit>().fetchRecentSearches();
        context.pushNamed(PageUrl.searchResultScreen, extra: response.word);
      },
      child: Row(
        children: [
          Expanded(child: TextView(text: response.word)),
          InkWell(
              onTap: () {
                injector.get<SearchCubit>().deleteSearch(response.id);
                onDelete();
              },
              child: const Icon(Icons.close))
        ],
      ),
    );
  }
}
