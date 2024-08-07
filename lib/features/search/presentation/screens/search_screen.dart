import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchAppBar(),
            8.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SearchField(
                controller: controller,
              ),
            ),
            8.verticalSpace,
            const Divider(
              indent: 0,
              height: 2,
            ),
            Expanded(
              child: Container(
                width: 1.sw,
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
                    Wrap(
                      spacing: 4,
                      runSpacing: 8,
                      children: List.generate(
                        3,
                        (index) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              border: Border.all(
                                width: 1,
                                color: Pallets.borderGrey,
                              )),
                          child: const TextView(text: "Champions league"),
                        ),
                      ),
                    ),
                    41.verticalSpace,
                    const TextView(
                      text: "Recent searches",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    11.verticalSpace,
                    ...List.generate(
                      3,
                      (index) => const _RecentSearchItem(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      // keyboardType: TextInputType.,

      onSubmitted: (value) {
        if (controller.text.isNotEmpty) {
          context.pushNamed(PageUrl.searchResultScreen, extra: controller.text);
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
        child: Row(
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
              size: 40,
              onTap: () {
                context.pushNamed(PageUrl.profileScreen);
              },
            )),
          ],
        ),
      ),
    );
  }
}

class _RecentSearchItem extends StatelessWidget {
  const _RecentSearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: TextView(text: "Rafaela and Hummus")),
        IconButton(onPressed: () {}, icon: const Icon(Icons.close))
      ],
    );
  }
}
