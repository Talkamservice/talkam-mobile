import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/components/talkam_tab_bar.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_screen_cubit/profile_screen_cubit.dart';
import 'package:talkam/features/profile/presentation/screens/tabs/profile_posts_tab.dart';
import 'package:talkam/features/profile/presentation/screens/tabs/therapist_profile_info_tab.dart';
import 'package:talkam/features/profile/presentation/widgets/delete_account_dialog.dart';
import 'package:talkam/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:talkam/gen/assets.gen.dart';

enum _ProfileTabOptions {
  profile,
  posts,
  settings;

  String get title {
    switch (this) {
      case profile:
        return "Profile";
      case posts:
        return "Post";
      case settings:
        return "Settings";
    }
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  _ProfileTabOptions? _selectedTab;
  final PageController _pageController = PageController(initialPage: 0);
  TalkamUser _talkamUser = TalkamUser.forTest();

  List<_ProfileTabOptions> get _availableTabs {
    return SessionManager.instance.isTherapistAccount
        ? [_ProfileTabOptions.profile, _ProfileTabOptions.posts, _ProfileTabOptions.settings]
        : [_ProfileTabOptions.posts, _ProfileTabOptions.settings];
  }

  @override
  void initState() {
    injector.get<ProfileScreenCubit>().fetchUserProfile();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
          backgroundColor: Colors.white,
          body: SafeArea(
            child: state.maybeWhen(
              loading: () => Center(child: CustomDialogs.getLoading(size: 50)),
              error: () => AppErrorWidget(
                onTap: () {
                  injector.get<ProfileScreenCubit>().fetchUserProfile();
                },
              ),
              orElse: () {
                final user = injector.get<ProfileBloc>().appUser;
                final sessionManager = SessionManager.instance;
                final isAnonymous = !sessionManager.isLoggedIn ||
                    sessionManager.anonymousUsername.isNotEmpty ||
                    (user?.role?.toString().toLowerCase().contains('anonymous') ?? false);

                final userName = user?.name;
                final userHandle = isAnonymous
                    ? (sessionManager.anonymousUsername.isNotEmpty ? sessionManager.anonymousUsername : (user?.username ?? 'dippsdavid'))
                    : user?.username;
                final displayName = (userName != null && userName.isNotEmpty)
                    ? userName
                    : (_talkamUser.name.isNotEmpty ? _talkamUser.name : "Femi Adebayo");
                final handle = "@${(userHandle != null && userHandle.isNotEmpty) ? userHandle : (_talkamUser.username.isNotEmpty ? _talkamUser.username : 'dippsdavid')}";
                final avatarUrl = user?.avatar ?? _talkamUser.avatar;

                final isTherapist = SessionManager.instance.isTherapistAccount;
                _selectedTab ??= _availableTabs.first;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top User Header
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, right: 16.w, left: 16.w),
                      child: isTherapist
                          ? _buildTherapistHeader(displayName, handle, avatarUrl)
                          : _buildRegularHeader(isAnonymous, displayName, handle, avatarUrl),
                    ),

                    24.verticalSpace,

                    // Tab Bar: Profile | Post | Settings
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _availableTabs.map((tabOption) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: TalkamTabBar(
                              key: Key(tabOption.title),
                              useExpandedAsParent: false,
                              title: tabOption.title,
                              isSelected: tabOption == _selectedTab,
                              onTap: () {
                                setState(() {
                                  _selectedTab = tabOption;
                                });
                                _pageController.jumpToPage(_availableTabs.indexOf(tabOption));
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: const Divider(height: 1, color: Pallets.borderGrey),
                    ),

                    // Tab Views
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (int index) {
                          setState(() {
                            _selectedTab = _availableTabs[index];
                          });
                        },
                        children: _availableTabs.map((tab) {
                          switch (tab) {
                            case _ProfileTabOptions.profile:
                              return TherapistProfileInfoTab(
                                key: PageStorageKey(_ProfileTabOptions.profile),
                              );
                            case _ProfileTabOptions.posts:
                              return ProfilePostTab(
                                key: PageStorageKey(_ProfileTabOptions.posts),
                              );
                            case _ProfileTabOptions.settings:
                              return _SettingsTab(
                                key: PageStorageKey(_ProfileTabOptions.settings),
                              );
                          }
                        }).toList(),
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
  Widget _buildRegularHeader(bool isAnonymous, String displayName, String handle, String? avatarUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageWidget(
          width: 80.w,
          height: 80.w,
          canPreview: true,
          fit: BoxFit.cover,
          shape: BoxShape.circle,
          imageUrl: avatarUrl ?? Assets.images.svgs.user,
        ),
        12.verticalSpace,
        if (!isAnonymous) ...[
          Row(
            children: [
              TextView(
                text: displayName,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Pallets.boldBlackV2,
              ),
              6.horizontalSpace,
              ImageWidget(
                size: 20,
                canPreview: false,
                imageUrl: Assets.images.svgs.blueThick,
              ),
            ],
          ),
          4.verticalSpace,
        ],
        TextView(
          text: handle,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Pallets.grey400,
        ),

        if (isAnonymous) ...[
          8.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF6E5),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: const TextView(
              text: "Anonymous",
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFFD97706),
            ),
          ),
          16.verticalSpace,
          CustomButton(
            onPressed: () {
              context.pushNamed(PageUrl.signUp);
            },
            text: "Create account",
            bgColor: Pallets.blueBubbleColor,
            elevation: 0,
          ),
        ],
      ],
    );
  }

  Widget _buildTherapistHeader(String displayName, String handle, String? avatarUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ImageWidget(
            width: 80.w,
            height: 80.w,
            canPreview: true,
            fit: BoxFit.cover,
            shape: BoxShape.circle,
            imageUrl: avatarUrl ?? Assets.images.svgs.user,
          ),
        ),
        12.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextView(
              text: displayName,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Pallets.boldBlackV2,
            ),
            6.horizontalSpace,
            const Icon(
              Icons.verified,
              color: Color(0xFFF59E0B),
              size: 20,
            ),
          ],
        ),
        4.verticalSpace,
        const TextView(
          text: "Anxiety • CBT • 9 yrs experience",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF9CA3AF),
        ),
        24.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatItem("132", "Sessions"),
            Container(width: 1, height: 32.h, color: const Color(0xFFE5E7EB)),
            _buildStatItem("4.9", "Ratings", showStar: true),
            Container(width: 1, height: 32.h, color: const Color(0xFFE5E7EB)),
            _buildStatItem("4pm", "next slot", valueColor: const Color(0xFF3B82F6)),
            Container(width: 1, height: 32.h, color: const Color(0xFFE5E7EB)),
            _buildStatItem("2 hrs", "avg"),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String value, String label, {bool showStar = false, Color? valueColor}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showStar) ...[
              const Icon(Icons.star, color: Color(0xFFF59E0B), size: 16),
              4.horizontalSpace,
            ],
            TextView(
              text: value,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: valueColor ?? Pallets.boldBlackV2,
            ),
          ],
        ),
        4.verticalSpace,
        TextView(
          text: label,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF9CA3AF),
        ),
      ],
    );
  }
}

class _SettingsTab extends StatelessWidget {
  const _SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ACCOUNT MANAGEMENT
          const _SectionTitle(title: "ACCOUNT MANAGEMENT"),
          12.verticalSpace,
          Container(
            decoration: BoxDecoration(
              color: Pallets.bgLight.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                _SettingsTile(
                  svgPath: Assets.images.svgV2.userInActive,
                  iconBgColor: const Color(0xFFE8F1FF),
                  title: "Edit Profile",
                  subtitle: "Edit name, email, and billing address",
                  onTap: () {
                    if (SessionManager.instance.isTherapistAccount) {
                      context.pushNamed(PageUrl.therapistEditProfileScreen);
                    } else {
                      context.pushNamed(PageUrl.editProfileScreen);
                    }
                  },
                ),
                _SettingsTile(
                  svgPath: Assets.images.svgV2.notificationIcon,
                  iconBgColor: const Color(0xFFE8F1FF),
                  title: "Notification Settings",
                  subtitle: "Edit name, email, and billing address",
                  onTap: () => context.pushNamed(PageUrl.notificationSettingsScreen),
                ),
              ],
            ),
          ),

          24.verticalSpace,

          // PRIVACY & PAYMENTS
          const _SectionTitle(title: "PRIVACY & PAYMENTS"),
          12.verticalSpace,
          Container(
            decoration: BoxDecoration(
              color: Pallets.bgLight.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                _SettingsTile(
                  svgPath: Assets.images.svgV2.card,
                  iconBgColor: const Color(0xFFE8F1FF),
                  title: "Payment Methods",
                  subtitle: "2 saved cards",
                  onTap: () {},
                ),
                _SettingsTile(
                  svgPath: Assets.images.svgV2.shield,
                  iconBgColor: const Color(0xFFE8F1FF),
                  title: "Privacy Settings",
                  subtitle: "Manage privacy",
                  onTap: () => context.pushNamed(PageUrl.privacySettingsScreen),
                ),
                _SettingsTile(
                  svgPath: Assets.images.svgV2.gear,
                  iconBgColor: const Color(0xFFE8F1FF),
                  title: "Data & Content",
                  subtitle: "Control your data and consent usage.",
                  onTap: () => context.pushNamed(PageUrl.dataPrivacyScreen),
                ),
                _SettingsTile(
                  svgPath: Assets.images.svgV2.delete,
                  iconBgColor: const Color(0xFFFFF0F0),
                  title: "Delete Account",
                  titleColor: const Color(0xFFFF4D4D),
                  showChevron: false,
                  onTap: () => DeleteAccountDialog.show(context),
                ),
                _SettingsTile(
                  svgPath: Assets.images.svgV2.userInActive,
                  iconBgColor: const Color(0xFFFFF0F0),
                  title: "Logout",
                  titleColor: const Color(0xFFFF4D4D),
                  showChevron: false,
                  onTap: () => LogoutDialog.show(context),
                ),
              ],
            ),
          ),

          32.verticalSpace,
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return TextView(
      text: title,
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Pallets.grey400,
      wordSpacing: 1,
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.svgPath,
    required this.iconBgColor,
    required this.title,
    this.subtitle,
    this.titleColor,
    this.showChevron = true,
    required this.onTap,
  });

  final String svgPath;
  final Color iconBgColor;
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final bool showChevron;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: ImageWidget(
                imageUrl: svgPath,
                width: 22.w,
                height: 22.w,
              ),
            ),
            14.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: title,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: titleColor ?? Pallets.boldBlackV2,
                  ),
                  if (subtitle != null) ...[
                    4.verticalSpace,
                    TextView(
                      text: subtitle!,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Pallets.grey400,
                    ),
                  ],
                ],
              ),
            ),
            if (showChevron)
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Pallets.grey400,
              ),
          ],
        ),
      ),
    );
  }
}
