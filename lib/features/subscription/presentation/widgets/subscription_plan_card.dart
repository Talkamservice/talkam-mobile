import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mixins/returning_user_mixin.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/subscription/presentation/blocs/subscriptions_bloc/subscriptions_bloc_cubit.dart';
import 'package:talkam/features/subscription/presentation/blocs/subscriptions_bloc/subscriptions_bloc_cubit.dart';
import 'package:talkam/features/subscription/presentation/widgets/cancel_subscription_dialog.dart';

class SubscriptionPlanCard extends StatelessWidget {
  const SubscriptionPlanCard({super.key, required this.isSubscribed});

  final bool isSubscribed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TextView(
            text: "YOUR SUBSCRIPTION PLAN",
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        15.verticalSpace,
        isSubscribed ? _Subscribed() : const _UnSubscribed(),
      ],
    );
  }
}

class _Subscribed extends StatelessWidget {
  _Subscribed({super.key});

  final bloc = SubscriptionsCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionsCubit, SubscriptionsState>(
      bloc: bloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: 1.sw,
                decoration: subscriptionCardDecoration,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: TextView(
                                  text: "Your premium plan",
                                  fontWeight: FontWeight.w700,
                                  color: Pallets.white,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), gradient: blueWhiteGradient),
                                child: const TextView(
                                  text: "TalkAm Plus",
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          12.verticalSpace,
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color(0xff024B72),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          16.verticalSpace,
                          const Row(
                            children: [
                              Expanded(
                                child: TextView(
                                  text: "Plan",
                                  color: Pallets.lightBlue,
                                  fontSize: 12,
                                ),
                              ),
                              TextView(
                                text: "Annual plan",
                                fontSize: 12,
                                color: Pallets.white,
                              )
                            ],
                          ),
                          16.verticalSpace,
                          const Row(
                            children: [
                              Expanded(
                                child: TextView(
                                  text: "Renewal",
                                  color: Pallets.lightBlue,
                                  fontSize: 12,
                                ),
                              ),
                              TextView(
                                text: "October 20, 2025",
                                fontSize: 12,
                                color: Pallets.white,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            29.verticalSpace,
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpace,
                  TextButton(
                      onPressed: () {
                        CustomDialogs.showOverlayDialog(context,
                            child: CancelSubscriptionDialog(
                              onCancel: () {
                                logger.i("cancel");
                              },
                            ));
                      },
                      style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
                      child: const TextView(
                        text: "Cancel Subscription",
                        decoration: TextDecoration.underline,
                      )),
                  const TextView(
                    text: "By clicking on cancel subscription, you agree that you have ready TalkAM’s",
                    fontSize: 11,
                  ),
                  const TextView(
                    text: "Cancelation Policy.",
                    color: Pallets.blueBubbleColor,
                    fontSize: 11,
                  ),
                ],
              ),
            ),
            15.verticalSpace,
            const Divider(
              thickness: 1,
            ),
          ],
        );
      },
    );
  }
}

class _UnSubscribed extends StatelessWidget {
  const _UnSubscribed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            width: 1.sw,
            decoration: subscriptionCardDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffF6F3DA)), borderRadius: BorderRadius.circular(22), color: const Color(0xffFDFAE0)),
                  child: const TextView(
                    text: "Freemium",
                    fontSize: 10,
                  ),
                ),
                4.verticalSpace,
                const TextView(
                  text: "Upgrade to TalkAM plus",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Pallets.white,
                ),
                4.verticalSpace,
                const TextView(
                  text: "Enjoy great experiences with our premium plan, get easy access to creator tools and boost your presence on TalkAm.",
                  fontSize: 12,
                  color: Pallets.lightBlue,
                ),
                12.verticalSpace,
                CustomButton(
                  text: "Upgrade to TalkAM plus",
                  bgColor: Pallets.blueBubbleColor,
                  padding: const EdgeInsets.all(12),
                  borderRadius: BorderRadius.circular(50),
                  onPressed: () {
                    context.pushNamed(PageUrl.subscriptionScreen);
                  },
                )
              ],
            ),
          ),
        ),
        30.verticalSpace,
        const Divider(
          thickness: 1,
        )
      ],
    );
  }
}

LinearGradient get blueWhiteGradient {
  return const LinearGradient(colors: [
    Color(0xffD1F2F7),
    Color(0xffFDFFFF),
    Color(0xffD1F2F7),
  ]);
}

BoxDecoration get subscriptionCardDecoration {
  return BoxDecoration(
      border: Border.all(color: Pallets.blueBubbleColor),
      borderRadius: BorderRadius.circular(13),
      gradient: const LinearGradient(colors: [
        Color(0xff005783),
        Color(0xff00131D),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter));
}
