import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class AddTagsSheet2 extends StatefulWidget {
  const AddTagsSheet2({super.key, required this.initialTags});

  final List<String> initialTags;

  @override
  State<AddTagsSheet2> createState() => _AddTagsSheet2State();
}

class _AddTagsSheet2State extends State<AddTagsSheet2> {
  /// Used only when the trends endpoint returns nothing or fails, so the
  /// user is never trapped in this sheet with no suggested tags to pick.
  static const List<String> _fallbackTags = [
    'anxiety',
    'depression',
    'selfcare',
    'mentalhealth',
    'therapy',
    'mindfulness',
    'grief',
    'burnout',
    'relationships',
    'stress',
    'sleep',
    'motivation',
  ];

  final TextEditingController searchController = TextEditingController();
  List<String> selectedTags = [];
  List<String> allTrends = []; // Full list of trends from BLoC
  List<String> filteredTrends = [];

  @override
  void initState() {
    super.initState();
    selectedTags.addAll(widget.initialTags);
    // Trigger the event to fetch trends when the sheet initializes
    injector.get<PostBloc>().add(const PostEvent.getTrends());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(color: context.theme.cardColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: "Add Tags",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const TextView(
            text:
                "Select or add tags to categorize your post. Press Enter to add a new tag if not found.",
            fontSize: 14,
            color: Colors.grey,
          ),
          10.verticalSpace,
          const Divider(),
          BlocBuilder<PostBloc, PostState>(
            bloc: injector.get(),
            builder: (context, state) {
              return state.maybeWhen(
                getTrendsLoading: () => SizedBox(
                    width: 1.sw,
                    height: 200,
                    child: Center(child: CustomDialogs.getLoading(size: 30))),
                getTrendsSuccess: () {
                  final serverTrends = injector
                      .get<PostBloc>()
                      .trends
                      .map(
                        (e) => e.tag.toString(),
                      )
                      .toList();
                  allTrends =
                      serverTrends.isEmpty ? _fallbackTags : serverTrends;

                  _filterTrends();
                  return _buildTagSelector(
                    fallbackReason: serverTrends.isEmpty
                        ? 'The server returned an empty tag list.'
                        : null,
                  );
                },
                getTrendsFailure: (error) {
                  allTrends = _fallbackTags;
                  _filterTrends();
                  return _buildTagSelector(fallbackReason: error);
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Pallets.primary,
                      foregroundColor: Pallets.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      shape: const StadiumBorder()),
                  onPressed: () {
                    if (filteredTrends.isEmpty &&
                        searchController.text.isNotEmpty &&
                        !selectedTags.contains(searchController.text)) {
                      selectedTags.add(searchController.text);
                      searchController.clear();
                      setState(() {});
                    } else {
                      context.pop(selectedTags);
                    }
                  },
                  child: TextView(
                    text: filteredTrends.isEmpty &&
                            searchController.text.isNotEmpty
                        ? "Add tag"
                        : "Save",
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  /// Tag chips + search field + suggested-tags list. When [fallbackReason] is
  /// non-null, [allTrends] is local fallback data and a banner explaining why
  /// is shown above the search field.
  Widget _buildTagSelector({String? fallbackReason}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (fallbackReason != null) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Pallets.borderGrey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline_rounded,
                    size: 18, color: Pallets.boldBlackV2),
                10.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextView(
                        text: 'Showing default tags',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Pallets.boldBlackV2,
                      ),
                      2.verticalSpace,
                      TextView(
                        text: fallbackReason,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Pallets.grey500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          10.verticalSpace,
        ],
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          runAlignment: WrapAlignment.start,
          children: selectedTags
              .map((tag) => Chip(
                    label: Text(tag),
                    onDeleted: () {
                      selectedTags.remove(tag);
                      setState(() {});
                    },
                  ))
              .toList(),
        ),
        OutlinedFormField(
          hint: "Search ",
          controller: searchController,
          radius: 100.r,
          onChange: (d) {
            _filterTrends();
          },
          preffix: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ImageWidget(imageUrl: Assets.images.svgs.searchMd),
          ),
          onFieldSubmitted: (value) {
            if (value.isNotEmpty && !selectedTags.contains(value)) {
              selectedTags.add(value);
              searchController.clear();
              setState(() {});
            }
          },
        ),
        10.verticalSpace,
        filteredTrends.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextView(
                  text:
                      'No matching tags found. Press Enter to add "${searchController.text}".',
                  fontSize: 14,
                ),
              )
            : SizedBox(
                height: 0.4.sh, // Adjust as needed
                child: ListView.builder(
                  itemCount: filteredTrends.length,
                  itemBuilder: (context, index) {
                    final trend = filteredTrends[index];
                    return ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      dense: true,
                      title: TextView(text: trend),
                      trailing: selectedTags.contains(trend)
                          ? const Icon(Icons.check_circle,
                              color: Pallets.primary)
                          : null,
                      onTap: () {
                        if (!selectedTags.contains(trend)) {
                          selectedTags.add(trend);
                          setState(() {});
                        } else {
                          selectedTags.remove(trend);
                          setState(() {});
                        }
                      },
                    );
                  },
                ),
              ),
      ],
    );
  }

  void _filterTrends() {
    Future.delayed(
      Duration(milliseconds: 200),
      () {
        setState(() {
          final query = searchController.text.toLowerCase();
          if (query.isEmpty) {
            filteredTrends = allTrends;
          } else {
            filteredTrends = allTrends
                .where((tag) => tag.toLowerCase().contains(query))
                .toList();
          }
        });
      },
    );
  }
}
