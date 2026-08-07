import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';

/// Small uppercase heading that introduces a group of content
/// ("SPECIALTIES", "ACCOUNT MANAGEMENT").
///
/// The therapist profile and the settings lists each grew their own copy of
/// this at slightly different sizes; this is the single source of truth.
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextView(
      text: text.toUpperCase(),
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Pallets.grey400,
      wordSpacing: 1,
    );
  }
}
