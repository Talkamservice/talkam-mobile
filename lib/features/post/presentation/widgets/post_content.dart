import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/readmore_text.dart';
import 'package:talkam/common/widgets/rounded_track_shape.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/post/presentation/bloc/poll/poll_bloc.dart';
import 'package:talkam/features/post/presentation/bloc/poll/poll_bloc.dart';
import 'package:talkam/features/post/presentation/widgets/post_image.dart';

class PostContent extends StatelessWidget {
  final TalkamPost post;

  const PostContent({required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (post.title?.isNotEmpty ?? false)
        TextView(
          text: post.title,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      if (post.body?.isNotEmpty ?? false)
        ReadMoreText(
          text: post.body ?? '',
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      PostMedia(post: post),
      if (post.tags?.isNotEmpty ?? false)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.verticalSpace,
            Wrap(
              spacing: 4,
              runSpacing: 8,
              children: List.generate(
                post.tags?.length ?? 0,
                (index) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(
                        width: 1,
                        color: Pallets.borderGrey,
                      )),
                  child: TextView(text: post.tags?[index] ?? ''),
                ),
              ),
            ),
          ],
        ),
    ]);
  }
}

class PostMedia extends StatelessWidget {
  const PostMedia({super.key, required this.post});

  final TalkamPost post;

  @override
  Widget build(BuildContext context) {
    // logger.w(post.type.toString().toLowerCase());
    return switch (post.type.toString().toLowerCase()) {
      "file" => Column(
          children: [
            10.verticalSpace,
            PostImage(
              images: post.attachments.isNotEmpty
                  ? post.attachments
                      .map(
                        (e) => e!.url,
                      )
                      .toList()
                  : [],
            ),
          ],
        ),
      "image" => Column(
          children: [
            10.verticalSpace,
            PostImage(
              images: post.attachments.isNotEmpty
                  ? post.attachments
                      .map(
                        (e) => e!.url,
                      )
                      .toList()
                  : [],
            ),
          ],
        ),
      "poll" => Column(
          children: [
            10.verticalSpace,
            PollsWidget(polls: post.polls),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                    text: TimeUtil.getTimeRemaining(
                        DateTime.now(), post.polls.first.expiresAt)),
                TextView(text: "$totalVotesCount votes"),
              ],
            )
          ],
        ),
      "text" => 0.verticalSpace,

      // TODO: Handle this case.
      String() => 0.verticalSpace,
    };
  }

  String get totalVotesCount {
    return post.polls
        .map(
          (e) => e.count,
        )
        .fold(
          0,
          (previousValue, element) => previousValue + element,
        )
        .toString();
  }
}

class PollsWidget extends StatefulWidget {
  const PollsWidget({super.key, required this.polls});

  final List<TalkamPoll> polls;

  @override
  State<PollsWidget> createState() => _PollsWidgetState();
}

class _PollsWidgetState extends State<PollsWidget> {
  // List<AnimationController> get controllers => widget.polls
  //     .map(
  //       (e) => AnimationController(
  //           vsync: this, duration: const Duration(milliseconds: 700)),
  //     )
  //     .toList();

  final pollBloc = PollBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PollBloc, PollState>(
      bloc: pollBloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          selectPollSuccess: (val) {
            // refreshPost(reload: false);
          },
        );
      },
      builder: (BuildContext context, PollState state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Column(
                children: List.generate(
              widget.polls.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: widget.polls.any(
                  (element) => element.selected == true,
                )
                    ? IgnorePointer(
                        child: VotedPollItem(
                          poll: widget.polls[index],

                          // onTap: () {},
                        ),
                      )
                    : UnVotedPollItem(
                        poll: widget.polls[index],
                        // controller: controllers[index],
                        onTap: () {
                          pollBloc.add(PollEvent.selectPoll(
                              widget.polls[index].id.toString()));
                        },
                      ),
              ),
            )),
            state.maybeWhen(
              orElse: () => 0.verticalSpace,
              selectPollLoading: () => Center(
                child: CustomDialogs.getLoading(size: 40),
              ),
            ),
          ],
        );
      },
    );
  }

  void forwardAll() {
    // for (var controller in controllers) {
    //   controller.repeat();
    //   // controller.forward();
    // }
  }
}

class VotedPollItem extends StatefulWidget {
  const VotedPollItem({
    super.key,
    required this.poll,
  });

  final TalkamPoll poll;

  @override
  State<VotedPollItem> createState() => _VotedPollItemState();
}

class _VotedPollItemState extends State<VotedPollItem>
    with SingleTickerProviderStateMixin {
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

    logger.i("init Called");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    logger.i("dependency change Called");
    super.didChangeDependencies();
  }

  ValueNotifier<double> sliderValue = ValueNotifier(30);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
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
                      border: Border.all(color: Pallets.primary),
                      borderRadius: BorderRadius.circular(100),
                      color: Pallets.pollTrackColor.withOpacity(0.1),
                    ),
                    child: Slider(
                      min: 0,
                      max: 100,
                      activeColor: Pallets.pollTrackColor,
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
            ],
          );
        });
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

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

class _UnVotedPollItemState extends State<UnVotedPollItem>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  ValueNotifier<double> sliderValue = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: ValueListenableBuilder(
          valueListenable: sliderValue,
          builder: (context, sliderListenerValue, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 36,
                      inactiveTrackColor:
                          Pallets.pollTrackColor.withOpacity(0.1),
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
                        border: Border.all(color: Pallets.primary),
                        borderRadius: BorderRadius.circular(100),
                        color: Pallets.pollTrackColor.withOpacity(0.1),
                      ),
                      child: Slider(
                        min: 0,
                        max: 100,
                        activeColor: Pallets.pollTrackColor,
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
                  child: Center(
                    child: TextView(text: widget.poll.option),
                  ),
                ),
                Positioned.fill(
                    child: InkWell(
                  onTap: widget.onTap,
                ))
              ],
            );
          }),
    );
  }
}
