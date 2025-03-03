import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/flutterwave/flutterwave_payment_helper.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/helper_utils.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/subscription/data/models/get_plans_response.dart';
import 'package:talkam/features/subscription/presentation/blocs/subscriptions_bloc/subscriptions_bloc_cubit.dart';
import 'package:talkam/features/subscription/presentation/widgets/subscription_succes_dialog.dart';

class PlanItem extends StatelessWidget {
  PlanItem({super.key, required this.plan, required this.durationIndex});

  final int durationIndex;

  final TalkamPlan plan;
  final bloc = SubscriptionsCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionsCubit, SubscriptionsState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          initiateSubscriptionLoading: () => CustomDialogs.showLoading(context),
          initiateSubscriptionFailure: (error) {
            context.pop();
            CustomDialogs.error(error);
          },
          initiateSubscriptionSuccess: (response) async {
            var user = injector.get<ProfileBloc>().appUser;

            context.pop();

            var paymentResponse = await PaymentHelper().makePayment(
                context,
                FlutterRequirements(
                  amount: plan.durations[durationIndex].price,
                  referenceNumber: response.data.reference,
                  currency: plan.currency,
                  meta: response.data.metadata.toJson(),
                  email: user?.email,
                  fullName: user?.name,
                ));
            injector.get<ProfileBloc>().add(const GetRemoteUser());
            if (paymentResponse?.success ?? false) {
              CustomDialogs.showOverlayDialog(context,
                  dissmisable: false,
                  child: SubscriptionSucessDialog(
                    duration: plan.durations[durationIndex]!,
                  ));
            } else {
              CustomDialogs.error(paymentResponse?.status.toString() ?? "Payment canceled");
            }
            injector.get<SubscriptionsCubit>().getPlans(reload: true);
          },
        );
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Pallets.borderGrey,
              ),
              color: Pallets.white),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextView(
                            text: plan.name,
                            color: Pallets.textGrey,
                          ),
                        ),
                        if (plan.isActiveSubscription)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xffF6F3DA)), borderRadius: BorderRadius.circular(22), color: const Color(0xffFDFAE0)),
                            child: const TextView(
                              text: "Current plan",
                              fontSize: 10,
                            ),
                          )
                      ],
                    ),
                    5.verticalSpace,
                    if (planIsPaid)
                      TextView(
                        text: "${plan.currency.toString().getCurrencySymbol}${(plan.durations[durationIndex]?.price ?? 0).toString().formatAmount()}",
                        // text: "${plan.currency.toString().getCurrencySymbol}${planDuration?.price ?? 0}",
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    if (!planIsPaid)
                      TextView(
                        text: "Free",
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    4.verticalSpace,
                    if (planIsPaid) TextView(text: "Billed ${plan.durations[durationIndex]?.frequency ?? "Monthly"}")
                  ],
                ),
              ),
              if (planIsPaid && !plan.isActiveSubscription)
                Column(
                  children: [
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                      child: CustomButton(
                        bgColor: Pallets.blueBubbleColor,
                        elevation: 0,
                        padding: const EdgeInsets.all(12),
                        onPressed: () {
                          bloc.initiateSubscription(plan.durations[durationIndex]?.id.toString() ?? "0");
                        },
                        borderRadius: BorderRadius.circular(100),
                        child: const TextView(text: "Subscribe and Pay"),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: plan.benefits.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_rounded,
                          size: 24,
                          color: Pallets.primary,
                        ),
                        10.horizontalSpace,
                        Expanded(
                            child: TextView(
                          text: plan.benefits[index].title,
                          fontSize: 12,
                        ))
                      ],
                    ),
                  );
                },
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextView(
                      text: "By subscribing to TalkAm plus, you agree to have read the",
                      fontSize: 10,
                      color: Pallets.textGrey,
                    ),
                    InkWell(
                      onTap: () {
                        Helpers.launchRawUrl("https://web.talkam.prodevs.io/help&info/payment-terms");

                      },
                      child: const TextView(
                        text: "Purchase Terms and Conditions",
                        fontSize: 10,
                        color: Pallets.primary,
                      ),
                    ),
                    18.verticalSpace
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  bool get planIsPaid => !(plan.name.toString().toLowerCase() == "freemium");
}
