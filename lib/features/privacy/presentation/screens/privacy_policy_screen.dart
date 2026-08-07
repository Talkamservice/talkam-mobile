import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/privacy/dormain/repository/privacy_repository.dart';

/// Renders the real `/user/privacy-policies` content. The backend serves
/// HTML and this app has no HTML renderer yet, so tags are stripped down to
/// readable plain text rather than pulling in a new rendering dependency.
class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late Future<String> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<String> _load() =>
      injector.get<PrivacyRepository>().getPrivacyPolicy().then(_toPlainText);

  /// Strips tags and collapses block-level elements into paragraph breaks —
  /// crude, but keeps the real policy content readable without a package.
  String _toPlainText(String html) {
    final withBreaks = html.replaceAllMapped(
      RegExp(r'<(p|h[1-6]|li|br|div)[^>]*>', caseSensitive: false),
      (match) => '\n',
    );
    final stripped = withBreaks.replaceAll(RegExp(r'<[^>]+>'), '');
    return stripped
        .replaceAll('&amp;', '&')
        .replaceAll('&nbsp;', ' ')
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .join('\n\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        tittleText: "Privacy Policy",
        centerTile: false,
        showDivider: true,
      ),
      body: SafeArea(
        child: FutureBuilder<String>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CustomDialogs.getLoading(size: 50));
            }
            if (snapshot.hasError) {
              return AppErrorWidget(
                onTap: () => setState(() => _future = _load()),
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: TextView(
                text: snapshot.data ?? '',
                fontSize: 14,
                color: Pallets.boldBlackV2,
                lineHeight: 1.5,
              ),
            );
          },
        ),
      ),
    );
  }
}
