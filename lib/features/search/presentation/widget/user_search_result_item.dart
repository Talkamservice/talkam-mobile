import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/search/data/models/user_search_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class UserSearchResultItem extends StatelessWidget {
  const UserSearchResultItem({super.key, required this.userSearchResult});

  final UserSearchResult userSearchResult;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        viewUsersProfile(context);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageWidget(
            imageUrl: userSearchResult.avatar ?? Assets.images.svgs.user,
            size: 40,
            shape: BoxShape.circle,
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: userSearchResult.username == null || userSearchResult.username.toString().isEmpty
                      ? (userSearchResult.name ?? userSearchResult.email)
                      : userSearchResult.username,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                // TextView(
                //   text:"",
                //   fontSize: 12,
                //   fontWeight: FontWeight.w500,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void viewUsersProfile(BuildContext context) {
    GuestUserHelper.handleGuestUserAction(
        action: () {
          var me = injector.get<ProfileBloc>().appUser;
          if (me?.id == userSearchResult.id) {
            context.pushNamed(
              PageUrl.profileScreen,
            );
          } else {
            context.pushNamed(PageUrl.userProfileScreen, extra: userSearchResult.id.toString());
          }
        },
        message: "Login to view user profile");
  }
}
