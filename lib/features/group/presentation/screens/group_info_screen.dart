import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/subscribe_button.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/presentation/blocs/group_post_cubit/group_post_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/screens/refresh_group_listener.dart';
import 'package:talkam/features/group/presentation/tabs/groups_about_tab.dart';
import 'package:talkam/features/group/presentation/tabs/group_posts_tab.dart';
import 'package:talkam/features/group/presentation/widgets/group_action_sheet.dart';
import 'package:talkam/features/home/presentation/screens/home_screen.dart';
import 'package:talkam/features/post/presentation/widgets/create_post_sheet.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupInfoScreen extends StatefulWidget {
  GroupInfoScreen({
    super.key,
    required this.groupId,
    this.isPrivate = false,
  });

  final String groupId;
  final bool isPrivate;

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen>
    with SingleTickerProviderStateMixin {
  final tabItems = [
    TabItemModel(imagePath: Assets.images.svgs.icfeatured, tittle: "Trending"),
    TabItemModel(imagePath: Assets.images.svgs.icTrending, tittle: "About"),
  ];
  int selecteIndex = 0;
  final PageController _pageController = PageController();
  final bloc = GroupsCubit(injector.get());
  final groupPostCubit = GroupPostCubit(injector.get());
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    bloc.getGroup(widget.groupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshGroupListener(
      onRefresh: () {
        bloc.getGroup(widget.groupId);
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        floatingActionButton: FloatingActionButton(
          foregroundColor: Pallets.white,
          backgroundColor: Pallets.primary,
          onPressed: () {
            showCreatePostSheet(context);
          },
          child: const Icon(Icons.add),
        ),
        body: BlocConsumer<GroupsCubit, GroupsState>(
          bloc: bloc,
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              getGroupSuccess: (response) {
                response = response;
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => 0.verticalSpace,
              getGroupLoading: () {
                return Scaffold(
                  appBar: const CustomAppBar(),
                  body: Center(
                    child: CustomDialogs.getLoading(size: 50),
                  ),
                );
              },
              getGroupFailure: (error) {
                return Scaffold(
                  appBar: const CustomAppBar(),
                  body: AppErrorWidget(
                    message: error,
                    onTap: () {
                      bloc.getGroup(widget.groupId);
                    },
                  ),
                );
              },
              getGroupSuccess: (response) {
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                        child: Container(
                          color: context.colorScheme.surface,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ImageWidget(
                                    imageUrl: response.image ?? '',
                                    height: 250.h,
                                    width: 1.sw,
                                    fit: BoxFit.cover,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  SafeArea(
                                    bottom: false,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 8.h),
                                      child: Row(
                                        children: [
                                          _HeaderIconButton(
                                            icon: Icons.arrow_back_ios,
                                            onTap: () => context.pop(),
                                          ),
                                          const Spacer(),
                                          Container(
                                            width: 38.w,
                                            height: 38.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.3),
                                              shape: BoxShape.circle,
                                            ),
                                            child: ImageWidget(imageUrl: Assets.images.svgV2.searchIcon,
                                                color: Colors.white,
                                                onTap: ()=> context.pushNamed(
                                                  PageUrl.searchResultScreen,
                                                  extra: {
                                                    'query': '',
                                                    'initialTab': 2,
                                                  },
                                                )
                                            ),
                                          ),
                                          8.horizontalSpace,
                                          _HeaderIconButton(
                                            icon: Icons.more_vert,
                                            onTap: () async {
                                              await CustomDialogs.showCustomDialog(
                                                GroupActionSheet(
                                                  group: response,
                                                  isPrivate: widget.isPrivate,
                                                ),
                                                context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 14.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView(
                                      text: response.name ?? "",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    10.verticalSpace,
                                    Row(
                                      children: [
                                        _MemberAvatarsStack(
                                            avatarUrls: MockHomeData
                                                .groupMemberAvatars(response)),
                                        8.horizontalSpace,
                                        TextView(
                                          text:
                                          "${_formatMemberCount(MockHomeData.groupMemberCount(response))} Members",
                                          fontSize: 13,
                                          color: context.colorScheme.onSurface,
                                        ),
                                        const Spacer(),
                                        SubscribeButton(
                                          text: "Subscribe",
                                          onTap: () {
                                            // TODO: handle logic
                                          },
                                        ),
                                        8.horizontalSpace,
                                        InkWell(
                                          onTap: () => CustomDialogs.showToast(
                                              "Coming soon"),
                                          customBorder: const CircleBorder(),
                                          child: ImageWidget(
                                            imageUrl:
                                            Assets.images.svgV2.userAdd,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    12.verticalSpace,
                                    TextView(
                                      text: response.description ?? "",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: context.colorScheme.onSurface,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                    )
                  ],
                  body: Column(
                    children: [
                      Container(
                        color: context.colorScheme.surface,
                        width: 1.sw,
                        child: Center(
                          child: TabBar(
                              padding: EdgeInsets.zero,
                              controller: _tabController,
                              tabAlignment: TabAlignment.center,
                              indicatorColor: context.colorScheme.primary,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorWeight: 3,
                              onTap: (value) {
                                selecteIndex = value;
                                _pageController.jumpToPage(value);
                                setState(() {});
                              },
                              tabs: List.generate(
                                tabItems.length,
                                    (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Tab(
                                    child: Row(
                                      children: [
                                        TextView(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          text: tabItems[index].tittle,
                                          color: selecteIndex == index
                                              ? context.colorScheme.onSurface
                                              : Pallets.grey60,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ).toList()),
                        ),
                      ),
                      Container(
                        color: context.colorScheme.surface,
                        height: 12.h,
                      ),
                      BlocProvider.value(
                        value: groupPostCubit,
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: PageView(
                              controller: _pageController,
                              onPageChanged: (int index) {
                                _tabController.animateTo(index);
                                selecteIndex = index;

                                setState(() {});
                              },
                              children: [
                                GroupPostsTab(
                                  group: response,
                                ),
                                GroupsAboutTab(
                                  data: response,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 38.w,
        height: 38.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20.w),
      ),
    );
  }
}

class _MemberAvatarsStack extends StatelessWidget {
  const _MemberAvatarsStack({required this.avatarUrls});

  final List<String> avatarUrls;

  @override
  Widget build(BuildContext context) {
    if (avatarUrls.isEmpty) return const SizedBox.shrink();

    final toShow = avatarUrls.take(4).toList();
    return SizedBox(
      width: (toShow.length * 18.w) + 12.w,
      height: 30.w,
      child: Stack(
        children: List.generate(toShow.length, (index) {
          return Positioned(
            left: index * 18.w,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: ClipOval(
                child: ImageWidget(
                  imageUrl: toShow[index],
                  size: 26.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

String _formatMemberCount(int count) {
  if (count >= 1000) {
    return '${(count / 1000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}K';
  }
  return count.toString();
}
