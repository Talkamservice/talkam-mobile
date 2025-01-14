import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'package:talkam/features/settings/presentation/widgets/notification_setting_item.dart';
import 'package:talkam/features/subscription/presentation/widgets/subscription_plan_card.dart';
import 'package:talkam/features/subscription/utils/subscription_helper.dart';
import 'package:talkam/gen/assets.gen.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final bloc = SettingsBloc(injector.get(), injector.get());

  final profileBloc = ProfileBloc(injector.get());

  bool adsDeactivated = false;

  @override
  void initState() {
    profileBloc.add(const GetRemoteUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          linkSocialAccountLoading: () => CustomDialogs.showLoading(context),
          linkSocialAccountFailure: (error) {
            context.pop();
            CustomDialogs.error(error);
          },
          linkSocialAccountSuccess: (response) {
            context.pop();
            CustomDialogs.success("Account Linked Successfully");
            profileBloc.add(const GetRemoteUser());
          },
          unlinkSocialAccountLoading: () => CustomDialogs.showLoading(context),
          unlinkSocialAccountFailure: (error) {
            context.pop();
            CustomDialogs.error(error);
          },
          unlinkSocialAccountSuccess: (response) {
            context.pop();
            CustomDialogs.success("Account UnLinked Successfully");
            profileBloc.add(const GetRemoteUser());
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(
            padding: EdgeInsets.all(0.0),
            tittleText: "Account Settings",
            centerTile: false,
            showDivider: true,
          ),
          body: BlocConsumer<ProfileBloc, ProfileState>(
            bloc: profileBloc,
            listener: (context, state) {
              if (state is UpdateProfileFailure) {
                adsDeactivated = !adsDeactivated;
                CustomDialogs.error(state.error);
              }

              if (state is GetProfileSuccessState) {
                adsDeactivated = !(state.user.shouldDisplayAd as int).toBool;
              }
            },
            buildWhen: (previous, current) => current is GetProfileLoadingState || current is GetProfileFailureState || current is GetProfileSuccessState,
            builder: (context, state) {
              if (state is GetProfileLoadingState) {
                return Center(
                  child: CustomDialogs.getLoading(size: 50),
                );
              }

              if (state is GetProfileFailureState) {
                return const AppErrorWidget();
              }

              if (state is GetProfileSuccessState) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            24.verticalSpace,
                            const TextView(
                              text: "Email address",
                              fontWeight: FontWeight.w700,
                            ),
                            7.verticalSpace,
                            TextView(text: injector.get<ProfileBloc>().appUser?.email ?? "***"),
                            24.verticalSpace,
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextView(
                                      text: "Password",
                                      fontWeight: FontWeight.w700,
                                    ),
                                    7.verticalSpace,
                                    const TextView(text: "********"),
                                  ],
                                )),
                                TextButton(
                                    style: TextButton.styleFrom(shape: const StadiumBorder(side: BorderSide(color: Pallets.primary))),
                                    onPressed: () {
                                      context.pushNamed(PageUrl.changePasswordScreen);
                                      // context.read<SettingsBloc>().add(SettingsEvent.blockUser(
                                      //     blockedUser.blockedUser.id.toString()));
                                    },
                                    child: const TextView(text: "Change password"))
                              ],
                            ),
                            30.verticalSpace,
                          ],
                        ),
                      ),
                      SubscriptionHelper.subscriptionWidget(
                        widget: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: NotificationSettingItem(
                            notificationItemType: NotificationItemType.switchType,
                            tittle: 'Deactivate ads on your feed',
                            subtittle: 'You will be unable to see ads on your feeds when this is activated.',
                            selected: adsDeactivated,
                            onTap: () async {
                              adsDeactivated = !adsDeactivated;
                              setState(() {});
                              profileBloc.add(UpdateProfileEvent(UpdateProfilePayload(shouldDisplayAd: (!adsDeactivated).toInt)));
                            },
                          ),
                        ),
                        freeUserWidget: 0.verticalSpace
                      ),
                      16.verticalSpace,
                      const Divider(
                        thickness: 1,
                      ),
                      10.verticalSpace,
                      SubscriptionPlanCard(
                        isSubscribed: true,
                        activeSub: state.user.activeSubscription,
                        onCancelled: () {
                          profileBloc.add(const GetRemoteUser());
                        },
                      ),
                      20.verticalSpace,
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              CustomOutlinedButton(
                                // bgColor: Colors.blueAccent,
                                isExpanded: true,

                                foreGroundColor: Pallets.black,
                                radius: 8.r,
                                outlinedColr: Pallets.borderGrey,
                                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                                onPressed: () {
                                  // _authBloc.add(const FacebookAuthEvent());

                                  // context.pushNamed(PageUrl.termsScreen);

                                  if (state.user.googleId == null) {
                                    bloc.add(const SettingsEvent.linkSocialAccount('google'));
                                  } else {
                                    bloc.add(const SettingsEvent.unlinkSocialAccount('google'));
                                  }
                                },
                                child: Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ImageWidget(imageUrl: Assets.images.svgs.googleAuth),
                                      16.horizontalSpace,
                                      TextView(
                                        text: state.user.googleId == null ? 'Connect with Google' : "Disconnect with Google",
                                        align: TextAlign.center,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              12.verticalSpace,
                              CustomButton(
                                foregroundColor: Colors.white,
                                bgColor: Pallets.facebookBlue,
                                borderRadius: BorderRadius.circular(8.r),
                                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                                onPressed: () {
                                  if (state.user.facebookId == null) {
                                    bloc.add(const SettingsEvent.linkSocialAccount('facebook'));
                                  } else {
                                    bloc.add(const SettingsEvent.unlinkSocialAccount('facebook'));
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ImageWidget(imageUrl: Assets.images.svgs.facebookWhite),
                                    12.horizontalSpace,
                                    TextView(
                                      text: state.user.facebookId == null ? 'Connect with Facebook' : "Disconnect with Facebook",
                                      align: TextAlign.center,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ),
                              12.verticalSpace,
                              if (Platform.isIOS)
                                CustomButton(
                                  foregroundColor: Pallets.white,
                                  bgColor: Pallets.black,
                                  borderRadius: BorderRadius.circular(8.r),
                                  padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                                  onPressed: () {
                                    if (state.user.appleId == null) {
                                      bloc.add(const SettingsEvent.linkSocialAccount('apple'));
                                    } else {
                                      bloc.add(const SettingsEvent.unlinkSocialAccount('apple'));
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ImageWidget(imageUrl: Assets.images.svgs.appleWhite),
                                      12.horizontalSpace,
                                      TextView(
                                        text: state.user.appleId == null ? 'Connect with Apple' : "Disconnect with Apple",
                                        align: TextAlign.center,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                ),
                              12.verticalSpace,
                              TextButton(
                                  onPressed: () {
                                    context.pushNamed(PageUrl.deleteAccountScreen);
                                  },
                                  child: const TextView(
                                    text: 'Delete Account',
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  )),
                              50.verticalSpace
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return 0.verticalSpace;
            },
          ),
        );
      },
    );
  }
}
