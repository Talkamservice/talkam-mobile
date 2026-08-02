import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/mood_check/data/models/mood.dart';
import 'package:talkam/features/mood_check/presentation/bloc/mood_check_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

/// The daily "How are you feeling today" check-in — see MoodCheckCubit for
/// the once-per-calendar-day reset logic.
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
              child:
              Column(
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
                      onTap: () {
                        cubit.dismiss(mood);
                        Navigator.of(context).pop();
                      },
                    ))
                        .toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MoodFace extends StatelessWidget {
  const _MoodFace({required this.mood, required this.onTap});

  final Mood mood;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: SvgPicture.asset(mood.iconPath, width: 33.w, height: 33.w),
      ),
    );
  }
}
