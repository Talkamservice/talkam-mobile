import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Mirrors [GroupResultItem]'s layout — a thumbnail, title/subtitle, and a
/// trailing pill button — so the loading state doesn't visibly jump once
/// the real rows swap in.
class GroupLoadingShimmer extends StatelessWidget {
  const GroupLoadingShimmer({super.key, this.padding, this.itemCount = 6});

  final EdgeInsetsGeometry? padding;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Callers place this inside a Center/SliverToBoxAdapter/Expanded
      // interchangeably — shrink-wrapping keeps it correct in all three
      // instead of relying on the ambient constraints being bounded.
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: itemCount,
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: _GroupRowPlaceholder(),
      ),
    );
  }
}

class _GroupRowPlaceholder extends StatelessWidget {
  const _GroupRowPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[350]!,
      highlightColor: Colors.grey[50]!,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 54,
            width: 78,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 10,
                  width: 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 30,
            width: 72,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
