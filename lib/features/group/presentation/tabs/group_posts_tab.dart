import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/features/group/presentation/blocs/group_post_cubit/group_post_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/post/presentation/widgets/post_loading_shimmer.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class GroupPostsTab extends StatefulWidget {
  const GroupPostsTab({super.key, required this.group});

  final TalkamGroup group;

  @override
  State<GroupPostsTab> createState() => _GroupPostsTabState();
}

class _GroupPostsTabState extends State<GroupPostsTab> {
  @override
  void initState() {
    context.read<GroupPostCubit>().getGroupPosts(widget.group.id.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupPostCubit, GroupPostState>(
      buildWhen: _buildWhen,
      listener: (context, state) {},
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => AppErrorWidget(
            onTap: () {
              context.read<GroupPostCubit>().getGroupPosts(widget.group.id.toString());
            },
          ),
          postsLoading: () {
            return const PostLoadingShimmer();
          },
          postsFailed: (message) => AppErrorWidget(
            onTap: () {
              context.read<GroupPostCubit>().getGroupPosts(widget.group.id.toString());
            },
          ),
          postsLoaded: (media, paginationData) {
            return Column(
              children: [
                if (media.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: paginationData.canLoadMore ? media.length + 1 : media.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        if (index >= media.length) {
                          context
                              .read<GroupPostCubit>()
                              .fetchNextMediaPage(groupId: widget.group.id.toString(), paginationData: paginationData, previousMedia: media);
                          return const Center(child: CircularProgressIndicator());
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: PostItem(
                            post: media[index],
                            showGroupAndCategory: false,
                          ),
                        );
                      },
                    ),
                  ),
                if (media.isEmpty) const Expanded(child: Center(child: TextView(text: "No posts here")))
              ],
            );
          },
        );
      },
    );
  }

  bool _buildWhen(GroupPostState previous, GroupPostState current) {
    return current.maybeWhen(
      orElse: () => false,
      postsLoading: () => true,
      postsFailed: (message) => true,
      postsLoaded: (posts, paginationData) => true,
    );
  }
}
