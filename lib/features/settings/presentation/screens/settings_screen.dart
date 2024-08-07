import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/profile/data/models/settings_category.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_screen_cubit/profile_screen_cubit.dart';
import 'package:talkam/gen/assets.gen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TalkamUser _talkamUser = TalkamUser.forTest();

  @override
  void initState() {
    injector.get<ProfileScreenCubit>().fetchUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileScreenCubit, ProfileScreenState>(
      bloc: injector.get<ProfileScreenCubit>(),
      listener: (context, state) {
        state.maybeWhen(
          loaded: (TalkamUser talkAmUser) {
            _talkamUser = talkAmUser;
            setState(() {});
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(
            padding: EdgeInsets.all(0.0),
            tittleText: "Settings",
            centerTile: false,
            showDivider: true,
          ),
          body: SafeArea(
            child: state.maybeWhen(
              loading: () => Center(child: CustomDialogs.getLoading(size: 50)),
              error: () => const SizedBox(),
              orElse: () {
                return ListView(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 14.h, right: 16.w, left: 16.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageWidget(
                            width: 34.w,
                            height: 34.w,
                            shape: BoxShape.circle,
                            imageUrl: _talkamUser.avatar,
                          ),
                          10.horizontalSpace,
                          TextView(
                            text: _talkamUser.username,
                            fontWeight: FontWeight.w600,
                            color: Pallets.boldBlackV2,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              context.pushNamed(PageUrl.editProfileScreen);
                            },
                            child: Container(
                              height: 40.h,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(56),
                                border: Border.all(color: Pallets.borderGrey),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ImageWidget(
                                      imageUrl:
                                          Assets.images.svgs.icPersonEdit),
                                  4.horizontalSpace,
                                  const TextView(text: "Edit profile")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0.h),
                      child: Container(
                        height: 1,
                        color: Pallets.borderGrey,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                      child: _SettingItemTile(
                        settingsCategory: contentSettings,
                        key: Key(contentSettings.title),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Pallets.borderGrey,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 16.w),
                      child: _SettingItemTile(
                        settingsCategory: accountSettings,
                        key: Key(accountSettings.title),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Pallets.borderGrey,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 16.w),
                      child: _SettingItemTile(
                        settingsCategory: aboutSettings,
                        key: Key(aboutSettings.title),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 40.h),
                      child: InkWell(
                        onTap: () {
                          context.pushNamed(PageUrl.deleteAccountScreen);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(
                              text: "Delete account",
                              fontWeight: FontWeight.w600,
                              color: Pallets.boldRed,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 16.0,
                              color: Color(0xFF444444),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _SettingItemTile extends StatelessWidget {
  final SettingsCategory settingsCategory;

  const _SettingItemTile({super.key, required this.settingsCategory});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: settingsCategory.title,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        16.verticalSpace,
        for (int i = 0; i < settingsCategory.items.length; i++) ...[
          InkWell(
            onTap: () => settingsCategory.items[i].onTap(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: settingsCategory.items[i].title,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF444444),
                ),
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 14.0,
                  color: Color(0xFF444444),
                )
              ],
            ),
          ),
          if (i == settingsCategory.items.length)
            const SizedBox.shrink()
          else
            16.verticalSpace
        ]
      ],
    );
  }
}
