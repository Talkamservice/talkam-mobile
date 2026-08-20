import 'package:flutter/material.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/components/talkam_tab_bar.dart';
import 'package:talkam/features/profile/presentation/screens/tabs/profile_posts_tab.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/features/therapist/data/therapist_profile_store.dart';
import 'package:talkam/features/therapist/presentation/screens/tabs/therapist_about_tab.dart';
import 'package:talkam/features/therapist/presentation/screens/tabs/therapist_settings_tab.dart';
import 'package:talkam/features/therapist/presentation/widgets/therapist_profile_header.dart';

/// Height of the shell's bottom navigation bar — see `BasePage`, which sets
/// `extendBody: true`, so tab content scrolls underneath it.
const double _kShellNavBarHeight = 69;

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

  /// Injected in tests and once a real therapist endpoint exists; defaults to
  /// the local mock record until then.
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
    // Silent — the mock/last-known record already renders; this just
    // refreshes it in the background.
    TherapistProfileStore.instance.fetchFromServer();
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
    // Listens rather than reading once: the shell keeps visited branches alive,
    // so saving on the Edit Profile screen would otherwise change nothing here
    // until the app restarted.
    return ValueListenableBuilder<TherapistModel>(
      valueListenable: TherapistProfileStore.instance.profile,
      builder: (context, stored, _) =>
          _buildBody(context, widget.therapist ?? stored),
    );
  }

  Widget _buildBody(BuildContext context, TherapistModel therapist) {
    // viewPadding rather than padding: it survives ancestor SafeArea widgets,
    // so the device inset is counted exactly once.
    final bottomInset = (_kShellNavBarHeight + _kContentBottomGap).h +
        MediaQuery.viewPaddingOf(context).bottom;

    return Scaffold(
      backgroundColor: Pallets.white,
      body: SafeArea(
        // The shell's nav bar owns the bottom inset; consuming it here would
        // leave a dead gap above it.
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: TherapistProfileHeader(therapist: therapist),
            ),
            24.verticalSpace,
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
                  TherapistAboutTab(
                    key: const PageStorageKey(_TherapistProfileTab.profile),
                    therapist: therapist,
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      bottom: bottomInset,
                    ),
                  ),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final tab in _TherapistProfileTab.values)
            TalkamTabBar(
              key: Key(tab.title),
              title: tab.title,
              isSelected: tab == selected,
              // Hug the label so "Profile" and "Settings" underline evenly.
              indicatorWidth: null,
              useExpandedAsParent: false,
              onTap: () => onSelected(tab),
            ),
        ],
      ),
    );
  }
}
