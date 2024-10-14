import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/presentation/widgets/post_video.dart';
import 'package:talkam/features/profile/data/models/user_media_response.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_media_tab/user_profile_media_tab_cubit.dart';

class UserProfileMediaTab extends StatefulWidget {
  const UserProfileMediaTab({super.key, required this.userId});

  final String userId;

  @override
  State<UserProfileMediaTab> createState() => _UserProfileMediaTabState();
}

class _UserProfileMediaTabState extends State<UserProfileMediaTab> with AutomaticKeepAliveClientMixin {
  final UserProfileMediaTabCubit _cubit = injector.get();
  List<UserMedia> _posts = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _cubit.fetchUserMedia(widget.userId);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _cubit.loadMorePosts(_posts, widget.userId);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<UserProfileMediaTabCubit, UserProfileMediaTabState>(
      bloc: _cubit,
      listener: (context, state) {
        state.maybeWhen(
          loaded: (List<UserMedia> posts) {
            _posts = posts;
            setState(() {});
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => Center(
            child: CustomDialogs.getLoading(size: 50),
          ),
          error: () => const SizedBox.shrink(),
          orElse: () {
            if (_posts.isEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  _cubit.fetchUserMedia(widget.userId);
                },
                child: ListView(
                  children: [
                    60.verticalSpace,
                    const EmptyState(
                      title: 'No media yet',
                      subtitle: "Media items will appear here if any ",
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                _cubit.fetchUserMedia(widget.userId);
              },
              child: GridView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                // padding: EdgeInsets.only(top: 2),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                children: [
                  for (int i = 0; i < _posts.length; i++) ...[
                    if(_posts[i].type.toLowerCase() == "video")
                      PostVideo(
                        radius: 0,
                        videos:[
                          _posts[i].url
                        ],
                      ),
                    if(_posts[i].type.toLowerCase() != "video")

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: ImageWidget(canPreview: true, imageUrl: _posts[i].url),
                    ),
                  ],
                  if (state is UserProfileMediaTabLoadingMoreState)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Center(child: CustomDialogs.getLoading(size: 50)),
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
