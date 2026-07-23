import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/chips_selector_widget.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  static const int _minSelection = 3;

  /// Used only when the categories endpoint returns nothing or fails, so the
  /// user is never trapped on this screen with no way to satisfy [_minSelection].
  /// Ids are positional placeholders, NOT real backend category ids.
  static const List<String> _fallbackInterestNames = [
    'Anxiety',
    'Depression',
    'Fear',
    'Grief',
    'Bipolar',
    'OCD',
    'ADHD',
    'Addiction',
    'Eating Disorder',
    'Psychosis',
    'Schizophrenia',
    'Insomnia',
    'Panic',
    'PTSD',
    'Relationships',
    'Physical Abuse',
    'Job Loss',
    'Social Isolation',
  ];

  late final List<PostCategory> _fallbackInterests = List.generate(
    _fallbackInterestNames.length,
    (index) => PostCategory(
      id: index + 1,
      name: _fallbackInterestNames[index],
      uuid: null,
      description: null,
      backgroundImage: null,
      followersCount: null,
      iconImage: null,
      createdAt: null,
      updatedAt: null,
      parentCategory: null,
      type: null,
      isFollowing: false,
      isSuspended: false,
      groupAccess: null,
    ),
  );

  List<PostCategory> selectedInterests = [];

  final postBloc = PostBloc(injector.get());
  final profileBloc = ProfileBloc(injector.get());

  @override
  void initState() {
    super.initState();
    postBloc.add(const PostEvent.getCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        bgColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: BlocListener<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: _listenToProfileBloc,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: TextView(
                        text: 'Select at least $_minSelection',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Pallets.boldBlackV2,
                      ),
                    ),
                    TextView(
                      text: '${selectedInterests.length}/$_minSelection',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Pallets.boldBlackV2,
                    ),
                  ],
                ),
                16.verticalSpace,
                CustomButton(
                  onPressed: selectedInterests.length >= _minSelection
                      ? _submitInterests
                      : null,
                  child: const TextView(
                    text: 'Next',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextView(
                  text: 'What are some of your interests?',
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  lineHeight: 1.25,
                  color: Pallets.boldBlackV2,
                ),
                8.verticalSpace,
                const TextView(
                  text:
                      'We’ll use this to personalize your for you page and groups you can join.',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                  lineHeight: 1.4,
                ),
              ],
            ),
          ),

          32.verticalSpace,

          // ── Interest chips ─────────────────────────────────────────
          Expanded(
            child: BlocBuilder<PostBloc, PostState>(
              bloc: postBloc,
              builder: (context, state) {
                return state.maybeWhen(
                  getCategoriesSuccess: (response) => response.data.isEmpty
                      ? _buildChips(_fallbackInterests,
                          fallbackReason:
                              'The server returned an empty interest list.')
                      : _buildChips(response.data),
                  getCategoriesLoading: () => Center(
                    child: CustomDialogs.getLoading(size: 40),
                  ),
                  getCategoriesFailure: (error) =>
                      _buildChips(_fallbackInterests, fallbackReason: error),
                  orElse: () => 0.verticalSpace,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Chip list. When [fallbackReason] is non-null the items are local fallback
  /// data and a banner explaining why is shown above them.
  Widget _buildChips(List<PostCategory> items, {String? fallbackReason}) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (fallbackReason != null) ...[
            _buildFallbackNotice(fallbackReason),
            20.verticalSpace,
          ],
          LifeChipsList<PostCategory>.multiple(
            items: items,
            initialItems: selectedInterests,
            onItemSelected: (selected) {
              setState(
                  () => selectedInterests = List<PostCategory>.from(selected));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackNotice(String reason) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Pallets.dailyTaskItemBg,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded,
              size: 18.sp, color: Pallets.boldBlackV2),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextView(
                  text: 'Showing default interests',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlackV2,
                ),
                2.verticalSpace,
                const TextView(
                  text:
                      'This is offline fallback data — these selections cannot be saved to your profile.',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                  lineHeight: 1.4,
                ),
                4.verticalSpace,
                TextView(
                  text: reason,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey500,
                  lineHeight: 1.4,
                ),
                6.verticalSpace,
                TextView(
                  text: 'Retry',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Pallets.blueBubbleColor,
                  onTap: () => postBloc.add(const PostEvent.getCategories()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submitInterests() {
    profileBloc.add(UpdateProfileEvent(UpdateProfilePayload(
      interests: selectedInterests
          .map((e) => int.tryParse(e.id.toString()) ?? 0)
          .toList(),
    )));
  }

  void _listenToProfileBloc(BuildContext context, ProfileState state) {
    if (state is UpdateProfileLoading) {
      CustomDialogs.showLoading(context);
    }
    if (state is UpdateProfileFailure) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is UpdateProfileSuccess) {
      context.pop();
      CustomDialogs.success("Interest updated");
      context.pushNamed(PageUrl.userNameScreen);
    }
  }
}
