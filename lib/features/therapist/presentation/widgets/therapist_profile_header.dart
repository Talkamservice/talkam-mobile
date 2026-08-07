import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/features/therapist/presentation/widgets/rating_stars.dart';
import 'package:talkam/features/therapist/presentation/widgets/therapist_avatar.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Identity block at the top of a therapist profile: avatar, name, headline and
/// the four-up stat strip. Shared by the client-facing profile and the
/// therapist's own profile so the two cannot drift apart.
///
/// Renders edge to edge — callers supply horizontal padding.
class TherapistProfileHeader extends StatelessWidget {
  const TherapistProfileHeader({super.key, required this.therapist});

  final TherapistModel therapist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TherapistAvatar(imageUrl: therapist.avatarUrl),
        12.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: TextView(
                text: therapist.name,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Pallets.boldBlack,
                align: TextAlign.center,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            if (therapist.isVerified) ...[
              6.horizontalSpace,
              SvgPicture.asset(
                Assets.images.svgV2.checkmarkBadge,
                width: 18.w,
                height: 18.w,
              ),
            ],
          ],
        ),
        4.verticalSpace,
        TextView(
          text: therapist.headline,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Pallets.grey,
          align: TextAlign.center,
        ),
        20.verticalSpace,
        _StatStrip(therapist: therapist),
      ],
    );
  }
}

class _StatStrip extends StatelessWidget {
  const _StatStrip({required this.therapist});

  final TherapistModel therapist;

  @override
  Widget build(BuildContext context) {
    final stats = <Widget>[
      _StatItem(
        label: "Sessions",
        value: "${therapist.totalSessions}",
      ),
      _StatItem(
        label: "Ratings",
        value: "${therapist.rating}",
        showStar: true,
      ),
      _StatItem(
        label: "next slot",
        value: therapist.nextSlotLabel,
        valueColor: Pallets.blueBubbleColor,
      ),
      _StatItem(
        label: "avg",
        value: therapist.avgDuration,
      ),
    ];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < stats.length; i++) ...[
            // Equal-width columns keep the strip from overflowing on narrow
            // devices, where four intrinsic-width stats would not fit.
            Expanded(child: stats[i]),
            if (i < stats.length - 1)
              const VerticalDivider(
                thickness: 1,
                width: 1,
                color: Pallets.hairline,
              ),
          ],
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
    this.showStar = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool showStar;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showStar) ...[
              const RatingStars(count: 1),
              4.horizontalSpace,
            ],
            Flexible(
              child: TextView(
                text: value,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: valueColor ?? Pallets.boldBlack,
                align: TextAlign.center,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        2.verticalSpace,
        TextView(
          text: label,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Pallets.grey,
          align: TextAlign.center,
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
