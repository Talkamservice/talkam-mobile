import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Circular therapist avatar that degrades to a tinted person glyph rather
/// than the generic app-icon placeholder, which reads as a broken image on a
/// profile.
class TherapistAvatar extends StatelessWidget {
  const TherapistAvatar({
    super.key,
    required this.imageUrl,
    this.diameter = 80,
  });

  final String imageUrl;

  /// Logical width before ScreenUtil scaling.
  final double diameter;

  @override
  Widget build(BuildContext context) {
    final size = diameter.w;

    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Pallets.avatarSurface,
        shape: BoxShape.circle,
      ),
      child: imageUrl.isEmpty
          ? _fallback(size)
          : CachedNetworkImage(
              imageUrl: imageUrl,
              width: size,
              height: size,
              fit: BoxFit.cover,
              placeholder: (context, url) => _fallback(size),
              errorWidget: (context, url, error) => _fallback(size),
            ),
    );
  }

  Widget _fallback(double size) => Center(
        child: SvgPicture.asset(
          Assets.images.svgV2.userActive,
          width: size * 0.4,
          height: size * 0.4,
          colorFilter: const ColorFilter.mode(
            Pallets.blueBubbleColor,
            BlendMode.srcIn,
          ),
        ),
      );
}
