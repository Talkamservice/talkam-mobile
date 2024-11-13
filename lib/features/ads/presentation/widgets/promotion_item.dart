import 'package:flutter/material.dart';

import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/ads/data/models/promotion_data.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_group_item.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_info_widget.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_post_item.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/theme/pallets.dart';

class PromotionItem extends StatelessWidget {
  PromotionItem(
      {super.key,
      required this.promotion,
      this.showGroupAndCategory = true,
      this.showScheduledPost = false,
      required this.onAdCancelled,
      required this.onAdRestarted,
      required this.onAdDeleted});

  final bool? showGroupAndCategory;
  final bool? showScheduledPost;
  final PromotionData promotion;
  final AdsCubit bloc = AdsCubit(injector.get());
  final VoidCallback onAdCancelled;
  final VoidCallback onAdDeleted;
  final VoidCallback onAdRestarted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        promotion.isPost
            ? AdPostItem(promotion: promotion)
            : Container(
                decoration:
                    BoxDecoration(color: context.theme.cardColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.borderGrey)),
                padding: EdgeInsets.all(10),
                child: AdGroupResultItem(
                  imageRadius: BorderRadius.circular(5),
                  group: promotion.group!,
                  onJoinStateChanged: () {},
                ),
              ),
        14.verticalSpace,
        AdInfoWidget(
          promotion: promotion,
          onAdCancelled: onAdCancelled,
          onAdDeleted: onAdDeleted,
          onRestarted: onAdRestarted,
        )
      ],
    );
  }
}
