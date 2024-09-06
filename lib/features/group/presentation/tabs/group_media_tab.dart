import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/features/group/presentation/blocs/group_post_cubit/group_post_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class GroupMediaTab extends StatefulWidget {
  const GroupMediaTab({super.key, required this.group});

  final TalkamGroup group;

  @override
  State<GroupMediaTab> createState() => _GroupMediaTabState();
}

class _GroupMediaTabState extends State<GroupMediaTab> {
  @override
  void initState() {
    super.initState();
    context.read<GroupPostCubit>().getGroupMedia(widget.group.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupPostCubit, GroupPostState>(
      listener: (context, state) {},
      buildWhen: _buildWhen,
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => AppErrorWidget(
            onTap: () {
              context
                  .read<GroupPostCubit>()
                  .getGroupMedia(widget.group.id.toString());
            },
          ),
          mediaLoading: () {
            return CustomDialogs.getLoading(size: 50);
          },
          mediaFailed: (message) => AppErrorWidget(
            onTap: () {
              context
                  .read<GroupPostCubit>()
                  .getGroupMedia(widget.group.id.toString());
            },
          ),
          mediaLoaded: (media, paginationData) {
            return Column(
              children: [
                if (media.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: paginationData.canLoadMore
                          ? media.length + 1
                          : media.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        if (index >= media.length) {
                          context.read<GroupPostCubit>().fetchNextMediaPage(
                              groupId: widget.group.id.toString(),
                              paginationData: paginationData,
                              previousMedia: media);
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return PostItem(
                          post: media[index],
                          showGroupAndCategory: false,
                        );
                      },
                    ),
                  ),
                if (media.isEmpty)
                  const Expanded(
                      child: Center(child: TextView(text: "No media here")))
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
      mediaLoaded: (media, paginationData) => true,
      mediaLoading: () => true,
      mediaFailed: (message) => true,
    );
  }
}
