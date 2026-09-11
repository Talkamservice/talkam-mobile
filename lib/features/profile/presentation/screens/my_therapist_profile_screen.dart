import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/constants/shell_layout.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/components/talkam_tab_bar.dart';
import 'package:talkam/features/profile/presentation/screens/tabs/profile_posts_tab.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/features/therapist/data/therapist_profile_store.dart';
import 'package:talkam/features/therapist/presentation/screens/tabs/therapist_about_tab.dart';
import 'package:talkam/features/therapist/presentation/screens/tabs/therapist_settings_tab.dart';
import 'package:talkam/features/therapist/presentation/widgets/therapist_profile_header.dart';

/// Breathing room below the last row. The shell also floats a FAB above the
/// nav bar, so clearing the bar alone still leaves content looking clipped.
const double _kContentBottomGap = 40;

enum _TherapistProfileTab {
  profile("Profile"),
  posts("Post"),
  settings("Settings");

  const _TherapistProfileTab(this.title);

  final String title;
}

/// The signed-in therapist's own profile — the Profile tab of the app shell
/// when [SessionManager.isTherapistAccount] is set.
///
/// The identity header stays pinned while Profile / Post / Settings swap
/// beneath it, so a therapist always sees their own stats in context.
class MyTherapistProfileScreen extends StatefulWidget {
  const MyTherapistProfileScreen({super.key, this.therapist});

  /// Test-only override — bypasses [TherapistProfileStore] entirely and
  /// renders as already loaded. Left null in production.
  final TherapistModel? therapist;

  @override
  State<MyTherapistProfileScreen> createState() =>
      _MyTherapistProfileScreenState();
}

class _MyTherapistProfileScreenState extends State<MyTherapistProfileScreen> {
  final PageController _pageController = PageController();
  _TherapistProfileTab _selectedTab = _TherapistProfileTab.profile;

  @override
  void initState() {
    super.initState();
    // Skipped when a therapist is injected directly (tests).
    if (widget.therapist == null) {
      TherapistProfileStore.instance.fetchFromServer();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectTab(_TherapistProfileTab tab) {
    if (tab == _selectedTab) return;
    setState(() => _selectedTab = tab);
    _pageController.jumpToPage(tab.index);
  }

  @override
  Widget build(BuildContext context) {
    // A caller-injected therapist (tests) bypasses the store entirely and is
    // always treated as already loaded.
    if (widget.therapist != null) {
      return _buildBody(context, widget.therapist!,
          TherapistProfileLoadStatus.loaded);
    }
    // Listens rather than reading once: the shell keeps visited branches alive,
    // so saving on the Edit Profile screen would otherwise change nothing here
    // until the app restarted.
    return ValueListenableBuilder<TherapistProfileLoadStatus>(
      valueListenable: TherapistProfileStore.instance.loadStatus,
      builder: (context, status, _) => ValueListenableBuilder<TherapistModel>(
        valueListenable: TherapistProfileStore.instance.profile,
        builder: (context, stored, _) => _buildBody(context, stored, status),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    TherapistModel therapist,
    TherapistProfileLoadStatus status,
  ) {
    // viewPadding rather than padding: it survives ancestor SafeArea widgets,
    // so the device inset is counted exactly once.
    final bottomInset = (kShellNavBarHeight + _kContentBottomGap).h +
        MediaQuery.viewPaddingOf(context).bottom;
    final loaded = status == TherapistProfileLoadStatus.loaded;

    if (status == TherapistProfileLoadStatus.loading) {
      return Scaffold(
        backgroundColor: Pallets.white,
        body: SafeArea(
          child: Center(
            child: CustomDialogs.getLoading(size: 50),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Pallets.white,
      body: SafeArea(
        // The shell's nav bar owns the bottom inset; consuming it here would
        // leave a dead gap above it.
        bottom: false,
        child: Column(
          children: [
            // The stat strip only means something once real numbers have
            // loaded — showing it with a blank/zeroed placeholder would look
            // like a broken profile rather than a profile that isn't ready.
            if (loaded) ...[
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
                child: TherapistProfileHeader(therapist: therapist),
              ),
              24.verticalSpace,
            ] else
              12.verticalSpace,
            _TabStrip(
              selected: _selectedTab,
              onSelected: _selectTab,
            ),
            const Divider(height: 1, color: Pallets.borderGrey),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(
                  () => _selectedTab = _TherapistProfileTab.values[index],
                ),
                children: [
                  _buildProfileTabContent(status, therapist, bottomInset),
                  ProfilePostTab(
                    key: const PageStorageKey(_TherapistProfileTab.posts),
                    bottomPadding: bottomInset,
                  ),
                  TherapistSettingsTab(
                    key: const PageStorageKey(_TherapistProfileTab.settings),
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      bottom: bottomInset,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The "Profile" tab's content, keyed to the fetch outcome — the Post and
  /// Settings tabs stay reachable regardless (a therapist pending
  /// verification still needs Logout/Continue Application in Settings).
  Widget _buildProfileTabContent(
    TherapistProfileLoadStatus status,
    TherapistModel therapist,
    double bottomInset,
  ) {
    switch (status) {
      case TherapistProfileLoadStatus.loading:
        return const Center(
          key: PageStorageKey(_TherapistProfileTab.profile),
          child: CircularProgressIndicator(),
        );
      case TherapistProfileLoadStatus.unauthorized:
        return _VerificationRequiredPanel(
          key: const PageStorageKey(_TherapistProfileTab.profile),
          onRetry: () => TherapistProfileStore.instance.fetchFromServer(),
        );
      case TherapistProfileLoadStatus.error:
        return AppErrorWidget(
          key: const PageStorageKey(_TherapistProfileTab.profile),
          title: "Couldn't load your profile",
          message: 'Check your connection and try again.',
          onTap: () => TherapistProfileStore.instance.fetchFromServer(),
        );
      case TherapistProfileLoadStatus.loaded:
        return TherapistAboutTab(
          key: const PageStorageKey(_TherapistProfileTab.profile),
          therapist: therapist,
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            bottom: bottomInset,
          ),
        );
    }
  }
}

/// Shown on the "Profile" tab in place of the real profile when the server
/// rejects `GET /therapist/profile` as unauthorized/forbidden — on this
/// endpoint that means the account isn't a verified therapist yet.
class _VerificationRequiredPanel extends StatelessWidget {
  const _VerificationRequiredPanel({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 88.w,
              width: 88.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Pallets.noticeAmber.withValues(alpha: 0.1),
              ),
              child: Icon(
                Icons.hourglass_top_rounded,
                size: 40.sp,
                color: Pallets.noticeAmber,
              ),
            ),
            20.verticalSpace,
            const TextView(
              text: "Your account isn't verified yet",
              align: TextAlign.center,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Pallets.boldBlackV2,
            ),
            8.verticalSpace,
            TextView(
              text:
                  "Your therapist profile becomes available once your account is verified — this usually takes 3–5 business days. You can still check your application status and account settings below.",
              align: TextAlign.center,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Pallets.grey400,
              lineHeight: 1.5,
            ),
            20.verticalSpace,
            CustomButton(
              isExpanded: false,
              elevation: 0,
              bgColor: Pallets.blueBubbleColor,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              onPressed: onRetry,
              child: const TextView(
                text: "Check again",
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabStrip extends StatelessWidget {
  const _TabStrip({required this.selected, required this.onSelected});

  final _TherapistProfileTab selected;
  final ValueChanged<_TherapistProfileTab> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          for (final tab in _TherapistProfileTab.values)
            Expanded(
              // Each tab gets an equal third of the row, and the whole cell
              // (not just the label) is tappable.
              child: TalkamTabBar(
                key: Key(tab.title),
                title: tab.title,
                isSelected: tab == selected,
                useExpandedAsParent: true,
                onTap: () => onSelected(tab),
              ),
            ),
        ],
      ),
    );
  }
}
