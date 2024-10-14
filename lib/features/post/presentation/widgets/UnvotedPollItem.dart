import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/rounded_track_shape.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/bloc/poll/poll_bloc.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';

class UnVotedPollItem extends StatefulWidget {
  const UnVotedPollItem({
    super.key,
    required this.poll,
    required this.onTap,
  });

  final TalkamPoll poll;
  final VoidCallback onTap;

  @override
  State<UnVotedPollItem> createState() => _UnVotedPollItemState();
}

class _UnVotedPollItemState extends State<UnVotedPollItem> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    Future.delayed(
      Duration.zero,
      () {
        _animateToTargetValue();
      },
    );

    // logger.i("init Called");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // logger.i("dependency change Called");
    super.didChangeDependencies();
  }

  ValueNotifier<double> sliderValue = ValueNotifier(30);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: ValueListenableBuilder(
          valueListenable: sliderValue,
          builder: (context, sliderListenerValue, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 35,
                      inactiveTrackColor: Pallets.pollTrackColor.withOpacity(0.1),
                      thumbShape: SliderComponentShape.noThumb,
                      // activeTrackColor: p,
                      // rangeThumbShape: RoundRangeSliderThumbShape(),
                      trackShape: RoundedSliderTrackShape(),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 1.0, // Adjust radius for overlay size
                      ),
                    ),
                    child: Container(
                      // padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: pollFinished ? Colors.grey : Pallets.primary),
                        borderRadius: BorderRadius.circular(100),
                        color: pollFinished ? Colors.grey.withOpacity(0.01) : Pallets.pollTrackColor.withOpacity(0.1),
                      ),
                      child: Slider(
                        min: 0,
                        max: 100,
                        activeColor: pollFinished ? Colors.grey.withOpacity(0.4) : Pallets.pollTrackColor,
                        value: sliderValue.value,
                        onChanged: (double value) {
                          // setState(() {
                          //   sliderValue.value = value;
                          // });
                        },
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextView(text: widget.poll.option),
                      TextView(text: "${widget.poll.percentage.toString()}%"),
                    ],
                  ),
                ),
                if(widget.poll.selected)
                const Icon(Icons.check_circle_outline_rounded),
                Positioned.fill(
                    child: InkWell(
                  onTap: widget.onTap,
                ))
              ],
            );
          }),
    );
  }

  void _animateToTargetValue() {
    final animation = Tween<double>(
      begin: 0,
      end: widget.poll.percentage.toDouble(),
    ).animate(controller);

    animation.addListener(() {
      sliderValue.value = animation.value;
    });
    controller.forward();
  }

  bool get pollFinished => widget.poll.expiresAt.difference(DateTime.now()).inSeconds < 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
