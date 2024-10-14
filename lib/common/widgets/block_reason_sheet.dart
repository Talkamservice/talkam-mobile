import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';

class BlockReasonSheet extends StatelessWidget {
  BlockReasonSheet({super.key});

  final List<String> accountBlocReasons = [
    "Spam",
    "Self-promotion",
    "Misinformation",
    "Hate speech",
    "Violence or threats",
    "Harassment",
    "Rule violation",
    "Nudity or sexually suggestive content",
    "Copyright infringement",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.colorScheme.background),
      child: ListView.builder(
        itemCount: accountBlocReasons.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => _Reason(reason: accountBlocReasons[index]),
      ),
    );
  }
}

class _Reason extends StatelessWidget {
  const _Reason({super.key, required this.reason});

  final String reason;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop(reason);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: TextView(
              text: reason,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
