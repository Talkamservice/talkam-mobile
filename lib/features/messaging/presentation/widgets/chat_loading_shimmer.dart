import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Placeholder shown only while a conversation with no local cache yet is
/// being fetched for the first time — mirrors [MessagesLoadingShimmer]'s
/// style so both loading states in the messaging feature look consistent.
class ChatLoadingShimmer extends StatelessWidget {
  const ChatLoadingShimmer({super.key});

  static const _bubbleWidths = [180.0, 220.0, 140.0, 200.0, 160.0, 120.0];

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[350]!,
      highlightColor: Colors.grey[50]!,
      child: ListView.builder(
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _bubbleWidths.length,
        itemBuilder: (context, index) {
          final alignLeft = index.isEven;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Align(
              alignment:
                  alignLeft ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                height: 40,
                width: _bubbleWidths[index],
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
