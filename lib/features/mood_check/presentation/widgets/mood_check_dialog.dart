import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/mood_check/data/models/mood.dart';
import 'package:talkam/features/mood_check/presentation/bloc/mood_check_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

/// The daily "How are you feeling today" check-in — see MoodCheckCubit for
/// the server-driven should-show logic.
///
/// Tapping a face previews it (tooltip) rather than submitting immediately;
/// the Submit button is always present, just disabled until a mood is
/// selected — same enabled/disabled pattern as the rest of the app's forms
/// (e.g. TherapistPersonalInfoScreen's "Save and Continue"), rather than the
/// button appearing/disappearing.
class MoodCheckDialog extends StatelessWidget {
  const MoodCheckDialog({super.key, required this.cubit});

  final MoodCheckCubit cubit;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good morning";
    if (hour < 17) return "Good afternoon";
    return "Good evening";
  }

  @override
  Widget build(BuildContext context) {
    final name = injector.get<ProfileBloc>().appUser?.name.split(' ').first;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () {
                    cubit.dismiss();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close, color: Pallets.boldBlackV2),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 36.w, right: 36.w, bottom: 36.w),
              child: BlocBuilder<MoodCheckCubit, MoodCheckState>(
                bloc: cubit,
                builder: (context, state) {
                  final selected =
                      state is MoodCheckMoodSelected ? state.mood : null;

                  return Column(
                    children: [
                      TextView(
                        text: name != null && name.isNotEmpty
                            ? "$_greeting, $name"
                            : _greeting,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Pallets.boldBlackV2,
                        align: TextAlign.center,
                      ),
                      8.verticalSpace,
                      const TextView(
                        text: "How are you feeling today",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Pallets.grey400,
                        align: TextAlign.center,
                      ),
                      12.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: Mood.values
                            .map((mood) => _MoodFace(
                                  mood: mood,
                                  onTriggered: () => cubit.selectMood(mood),
                                ))
                            .toList(),
                      ),
                      16.verticalSpace,
                      CustomButton(
                        elevation: 0,
                        bgColor: Pallets.blueBubbleColor,
                        onPressed: selected == null
                            ? null
                            : () {
                                cubit.submitMood(selected);
                                Navigator.of(context).pop();
                              },
                        child: const TextView(
                          text: "Submit",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MoodFace extends StatelessWidget {
  const _MoodFace({required this.mood, required this.onTriggered});

  final Mood mood;

  /// Fired via [Tooltip.onTriggered] — the same tap that shows the label
  /// also selects the mood. Deliberately not a separate InkWell/
  /// GestureDetector: nesting one inside Tooltip's own tap recognizer would
  /// put two tap handlers in the same gesture arena, and the inner one can
  /// silently win, so the tooltip and the selection could end up firing
  /// inconsistently. Routing both through Tooltip's own trigger keeps there
  /// being exactly one gesture owner.
  final VoidCallback onTriggered;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: mood.label,
      triggerMode: TooltipTriggerMode.tap,
      onTriggered: onTriggered,
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: SvgPicture.asset(mood.iconPath, width: 33.w, height: 33.w),
      ),
    );
  }
}
