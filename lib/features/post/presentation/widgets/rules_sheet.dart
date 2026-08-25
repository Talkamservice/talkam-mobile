import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/get_guidlines_response.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class RulesSheet extends StatefulWidget {
  const RulesSheet({super.key});

  @override
  State<RulesSheet> createState() => _RulesSheetState();
}

class _RulesSheetState extends State<RulesSheet>
    with AutomaticKeepAliveClientMixin {
  // final bloc = PostBloc(injector.get());

  @override
  void initState() {
    injector.get<PostBloc>().add(const PostEvent.getGuidelines());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7.sh,
      color: context.colorScheme.surface,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextView(
                  fontWeight: FontWeight.w600,
                  text: "TalkAM Rules & Guidelines",
                ),
                IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          ),
          const Divider(),
          const SizedBox(
            height: 19,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextView(text: rulesHeader),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  BlocConsumer<PostBloc, PostState>(
                    bloc: injector.get(),
                    listener: (context, state) {},
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () => 0.verticalSpace,
                        getGuidelinesLoading: () => SizedBox(
                          height: 300.h,
                          child: Center(
                            child: CustomDialogs.getLoading(size: 30),
                          ),
                        ),
                        getGuideLinesSuccess: (response) {
                          final rules = injector.get<PostBloc>().talkamRules;
                          return ListView.builder(
                            itemCount: rules.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 16),
                              child: _GuidelineItem(
                                guidline: rules[index],
                              ),
                            ),
                          );
                        },
                        getGuideLinesFailed: (error) => AppErrorWidget(
                          title: "Something went wrong",
                          message: error,
                          onTap: () => injector
                              .get<PostBloc>()
                              .add(const PostEvent.getGuidelines()),
                        ),
                      );

                      // return ListView.builder(
                      //   itemBuilder: (context, index) => const _GuidelineItem(),
                      // );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _GuidelineItem extends StatelessWidget {
  const _GuidelineItem({super.key, required this.guidline});

  final TalkamGuidelineModel guidline;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageWidget(imageUrl: Assets.images.svgs.guidlineIndicatior),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: TextView(text: "${guidline.title}: ${guidline.description}"))
      ],
    );
  }
}
