import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

import '../../gen/assets.gen.dart';
import 'image_widget.dart';

enum DocumentUploadStatus { idle, uploading, success, failure }

/// One requirement in a document-upload checklist. Renders differently per
/// [status] — empty dropzone, in-progress with a percentage bar, a completed
/// green tile, or a failed red tile.
class DocumentUploadTile extends StatelessWidget {
  const DocumentUploadTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    this.progress = 0,
    this.fileName,
    this.onBrowse,
    this.onCancel,
    this.onRemove,
    this.onRetry,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final DocumentUploadStatus status;

  /// 0..1, only meaningful while [status] is [DocumentUploadStatus.uploading].
  final double progress;
  final String? fileName;

  final VoidCallback? onBrowse;
  final VoidCallback? onCancel;
  final VoidCallback? onRemove;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case DocumentUploadStatus.idle:
        return _buildIdle();
      case DocumentUploadStatus.uploading:
        return _buildUploading();
      case DocumentUploadStatus.success:
        return _buildSuccess();
      case DocumentUploadStatus.failure:
        return _buildFailure();
    }
  }

  Widget _buildIdle() {
    return GestureDetector(
      onTap: onBrowse,
      child: DottedBox(
        child: Column(
          children: [
            ImageWidget(
              imageUrl: Assets.images.svgs.uploadIconDoc,
              size: 24.w,
            ),
            10.verticalSpace,
            TextView(
              text: title,
              align: TextAlign.center,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Pallets.boldBlackV2,
            ),
            4.verticalSpace,
            TextView(
              text: subtitle,
              align: TextAlign.center,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Pallets.grey400,
            ),
            8.verticalSpace,
            TextView(
              text: "Browse files",
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Pallets.blueBubbleColor,
              onTap: onBrowse,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploading() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Pallets.blueBubbleColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageWidget(
                imageUrl: Assets.images.svgs.uploadingDocumentIcon,
                size: 24.w,
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: fileName ?? title,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Pallets.boldBlackV2,
                    ),
                    2.verticalSpace,
                    TextView(
                      text: "Uploading... ${(progress * 100).round()}%",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Pallets.blueBubbleColor,
                    ),
                  ],
                ),
              ),
              if (onCancel != null)
                GestureDetector(
                  onTap: onCancel,
                  child: ImageWidget(
                    imageUrl: Assets.images.svgs.uploadingDocumentCancel,
                    size: 16.w,
                  ),
                ),
            ],
          ),
          10.verticalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5.h,
              backgroundColor: Pallets.grey90,
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Pallets.blueBubbleColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Pallets.successGreen.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(19.r),
        border: Border.all(color: Pallets.successGreen.withValues(alpha: 0.7), width: 1),
      ),
      child: Row(
        children: [
          ImageWidget(
            imageUrl: Assets.images.svgs.verificationIcon,
            size: 24.w,
            color: Pallets.successGreen.withValues(alpha: 0.7),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlackV2,
                ),
                2.verticalSpace,
                TextView(
                  text: subtitle,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                ),
              ],
            ),
          ),
          if (onRemove != null)
            GestureDetector(
              onTap: onRemove,
              child: ImageWidget(
                imageUrl: Assets.images.svgs.documentDelete,
                size: 16.w,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFailure() {
    return GestureDetector(
      onTap: onRetry,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Pallets.errorRed.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Pallets.errorRed, width: 1.5),
        ),
        child: Row(
          children: [
            ImageWidget(
              imageUrl: Assets.images.svgs.errorIcon,
              size: 24.w,
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: subtitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Pallets.boldBlackV2,
                  ),
                  const TextView(
                    text: "Uploading failed",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Pallets.errorRed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dashed-border container used by the idle upload dropzone.
class DottedBox extends StatelessWidget {
  const DottedBox({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(radius: 14.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child: child,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.radius});

  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Pallets.grey90
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    final path = Path()..addRRect(rrect);

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) => false;
}
