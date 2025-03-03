import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_group_item.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/recent_group_post_cubit/recent_group_post_cubit.dart';
import 'package:talkam/features/group/presentation/screens/refresh_group_listener.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/post/presentation/widgets/post_loading_shimmer.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class GroupRecentTab extends StatefulWidget {
  const GroupRecentTab({super.key});

  @override
  State<GroupRecentTab> createState() => _GroupRecentTabState();
}

class _GroupRecentTabState extends State<GroupRecentTab> with AutomaticKeepAliveClientMixin {
  final bloc = RecentGroupPostCubit(injector.get(), injector.get());

  @override
  void initState() {
    bloc.getRecentPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshGroupListener(
      onRefresh: () {
        injector.get<GroupsCubit>().getGroups();
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<RecentGroupPostCubit, RecentGroupPostState>(
                bloc: bloc,
                listener: (context, state) {},
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return AppErrorWidget(
                        onTap: () {
                          bloc.getRecentPosts();
                        },
                      );
                    },
                    getRecentPostsLoading: () => const Center(
                      child: PostLoadingShimmer(),
                    ),
                    getRecentPostsFailed: (error) => AppErrorWidget(
                      message: error,
                      onTap: () {
                        bloc.getRecentPosts();
                      },
                    ),
                    getRecentPostsSuccess: (mergedData) {
                      if (mergedData.isEmpty) {
                        return const Center(
                          child: TextView(text: "No posts or groups yet"),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          bloc.getRecentPosts();
                        },
                        child: ListView.builder(
                          itemCount: mergedData.length,
                          itemBuilder: (context, index) {
                            final item = mergedData[index];

                            if (item is TalkamPost) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: PostItem(post: item),
                              );
                            } else if (item is TalkamGroup) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: context.theme.cardColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.borderGrey)),
                                  padding: EdgeInsets.all(10),
                                  child: AdGroupResultItem(
                                    showFollowGroup: true,
                                    imageRadius: BorderRadius.circular(5),
                                    group: item,
                                    onJoinStateChanged: () {},
                                  ),
                                ), // Create a `GroupItem` widget
                              );
                            }

                            return const SizedBox.shrink(); // Fallback for unknown data types
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
