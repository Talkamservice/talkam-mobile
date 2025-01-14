import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/ads/data/models/initiate_payment_response.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import '../screens/ads_review_screens/view_analytics_page.dart';
import 'package:talkam/features/subscription/presentation/widgets/subscription_plan_card.dart';
import 'package:talkam/features/ads/presentation/widgets/cancel_ad_dialog.dart';
import 'package:talkam/features/ads/data/models/promotion_data.dart';

class AdInfoWidget extends StatelessWidget {
  AdInfoWidget({super.key, required this.promotion, required this.onAdCancelled, required this.onAdDeleted, required this.onRestarted});

  final PromotionData promotion;
  final VoidCallback onAdCancelled;
  final VoidCallback onAdDeleted;
  final VoidCallback onRestarted;
  final AdsCubit bloc = AdsCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdsCubit, AdsState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          removingPromotion: () {
            CustomDialogs.showLoading(context);
          },
          promotionRemoveFailed: (message) {
            context.pop();
            CustomDialogs.error(message);
          },
          promotionRemoved: (result) {
            context.pop();
            CustomDialogs.success("Promotion deleted");
            onAdDeleted();
          },
          updateAdLoading: () {
            CustomDialogs.showLoading(context);
          },
          updateAdFailed: (message) {
            context.pop();
            CustomDialogs.error(message);
          },
          updateAdSuccess: (result) {
            context.pop();
            CustomDialogs.success("Promotion cancelled");
            onAdCancelled();
          },
          creatingPromotion: () {
            CustomDialogs.showLoading(context);
          },
          promotionCreateFailed: (message) {
            context.pop();
            CustomDialogs.error(message);
          },
          paymentFailed: (message) {
            context.pop();
            CustomDialogs.error(message);
          },
          paymentSuccess: (result) {
            context.pop();
            CustomDialogs.success("Promotion restarted");

            onRestarted();
          },
          promotionCreated: (result) {
            bloc.payForPromotion(result as InitiatePaymentResponse);
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: context.theme.cardColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.borderGrey)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextView(
                      text: "Impressions",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Pallets.textGrey,
                    ),
                    8.verticalSpace,
                    TextView(
                      text: promotion.stats?.impressions.toString() ?? "0",
                      fontSize: 16,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextView(
                      text: "Engagement Rate",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Pallets.textGrey,
                    ),
                    8.verticalSpace,

                    TextView(
                      text: "${promotion.stats?.engagements.round().toString() ?? "0"}%",
                      fontSize: 16,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextView(
                      text: "Engagement",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Pallets.textGrey,
                    ),
                    8.verticalSpace,
                    TextView(
                      text: promotion.stats?.followers.toString() ?? "0",
                      fontSize: 16,
                    ),
                  ],
                )
              ],
            ),
            15.verticalSpace,
            const Divider(
              thickness: 1,
              color: Pallets.buttonGrey,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewAnalyticsPage(
                                promotionId: promotion.id.toString(),
                              )));
                },
                child: const Row(
                  children: [
                    Expanded(
                        child: TextView(
                      text: "View all analytics",
                      fontSize: 12,
                    )),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    )
                  ],
                )),
            const Divider(
              thickness: 1,
              color: Pallets.buttonGrey,
            ),
            15.verticalSpace,
            if (promotion.isActive)
              ActiveAdBar(
                onCancel: () {
                  bloc.updatePromotion(promotion.id.toString(), "Inactive");
                },
                onEdit: () {
                  bloc.reinitiatePromotion(
                    promotion.id.toString(),
                  );
                },
                data: promotion,
              ),
            if (!promotion.isActive)
              InActiveAdBar(
                onDelete: () {
                  bloc.removePromotion(promotion.id.toString());
                },
                onRestart: () {
                  bloc.reinitiatePromotion(
                    promotion.id.toString(),
                  );
                },
                data: promotion,
              ),
          ],
        ),
      ),
    );
  }
}

class ActiveAdBar extends StatelessWidget {
  const ActiveAdBar({
    super.key,
    required this.onCancel,
    required this.onEdit,
    required this.data,
  });

  final VoidCallback onCancel;
  final VoidCallback onEdit;
  final PromotionData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), border: Border.all(color: Pallets.lightBlue), gradient: whiteBlueGradient),
          child: const TextView(fontSize: 12, text: "Running Ad"),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Pallets.buttonred,
            textStyle: const TextStyle(color: Pallets.buttonred, fontSize: 12),
          ),
          onPressed: () {
            CustomDialogs.showOverlayDialog(context, child: CancelAdDialog(
              onCancel: () {
                onCancel();
                // bloc.removePromotion(promotion.id.toString());
              },
            ));
          },
          child: const TextView(
            text: "Close Ad",
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: 30,
          child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                foregroundColor: Pallets.white,
                backgroundColor: Pallets.blueBubbleColor,
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                CustomDialogs.showOverlayDialog(context,
                    child: CancelAdDialog(
                      tittle: "Restart Ad ?",
                      message: "You are about to restart a closed ad, you will have to make payment for this ad, Do you wish to proceed ? ",
                      onCancel: () {
                        onEdit();
                      },
                    ));

                // context.pushNamed(PageUrl.createAdsScreen);
              },
              child: const TextView(
                text: "Restart Ad",
                fontSize: 12,
              )),
        )
      ],
    );
  }
}

class InActiveAdBar extends StatelessWidget {
  const InActiveAdBar({
    super.key,
    required this.onDelete,
    required this.onRestart,
    required this.data,
  });

  final VoidCallback onDelete;
  final VoidCallback onRestart;
  final PromotionData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            shape: StadiumBorder(),
            backgroundColor: statusColor.withOpacity(0.1),
            foregroundColor: statusColor,
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            // textStyle:
            //     TextStyle(color: data.status.toString().toLowerCase() == "pending" ? Pallets.black : statusColor, fontSize: 12, fontWeight: FontWeight.w700),
            //
          ),
          onPressed: () {},
          child: TextView(
            text: "${data.status == "Inactive" ? "Closed" : data.status} Ad",
            color: data.status.toString().toLowerCase() == "pending" ? Pallets.black : statusColor,
            fontSize: 12,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Pallets.buttonred,
            textStyle: const TextStyle(color: Pallets.buttonred, fontSize: 12),
          ),
          onPressed: () {
            CustomDialogs.showOverlayDialog(context,
                child: CancelAdDialog(
                  tittle: "Delete Ad ?",
                  message: "You are about to delete a closed ad, and all information related to the ad will be permanently lost. Please note that this action "
                      "is irreversible, and no refunds will be provided. Are you sure you want to proceed?",
                  onCancel: () {
                    onDelete();
                  },
                ));
          },
          child: const TextView(
            text: "Delete Ad",
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: 30,
          child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                foregroundColor: Pallets.white,
                backgroundColor: Pallets.blueBubbleColor,
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                CustomDialogs.showOverlayDialog(context,
                    child: CancelAdDialog(
                      tittle: "Restart Ad ?",
                      message: "You are about to restart a closed ad, you will have to make payment for this ad, Do you wish to proceed ? ",
                      onCancel: () {
                        onRestart();
                      },
                    ));

                // context.pushNamed(PageUrl.createAdsScreen);
              },
              child: const TextView(
                text: "Restart Ad",
                fontSize: 12,
              )),
        )
      ],
    );
  }

  Color get statusColor {
    switch (data.status.toString().toLowerCase()) {
      case 'pending':
        return Color(0xffECA110);
      case 'active':
        return Pallets.lightBlue;
      case 'inactive':
        return Pallets.buttonred;
      default:
        return Pallets.primary;
    }
  }
}
