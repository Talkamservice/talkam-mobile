import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/presentation/bloc/composer_editor_cubit/composer_editor_cubit.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Live "@" mention suggestions for a composer field — shows/hides itself
/// off [ComposerEditorCubit.state.showMentionSuggestions], debounced
/// people-search results included, so composers just drop this under their
/// `TextField` with no query/search wiring of their own.
class MentionSuggestionsPanel extends StatelessWidget {
  const MentionSuggestionsPanel({super.key, required this.editor});

  final ComposerEditorCubit editor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComposerEditorCubit, ComposerEditorState>(
      bloc: editor,
      builder: (context, state) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          alignment: Alignment.topCenter,
          child: !state.showMentionSuggestions
              ? const SizedBox(width: double.infinity)
              : Container(
                  margin: EdgeInsets.only(top: 8.h),
                  constraints: BoxConstraints(maxHeight: 220.h),
                  decoration: BoxDecoration(
                    color: context.theme.cardColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Pallets.grey90),
                  ),
                  child: _buildBody(state),
                ),
        );
      },
    );
  }

  Widget _buildBody(ComposerEditorState state) {
    if (state.mentionLoading) {
      // A plain CircularProgressIndicator, not CustomDialogs.getLoading's
      // SpinKitWaveSpinner — that painter throws a geometry assertion when
      // squeezed into the near-zero-size frames this panel's enclosing
      // AnimatedSize passes through while animating open.
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }
    // Only people with a real handle can actually be @mentioned.
    final mentionable = state.mentionResults
        .where((u) => (u.username ?? '').isNotEmpty)
        .toList();

    if (mentionable.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        child: TextView(
          text: state.mentionQuery!.isEmpty
              ? "Keep typing a name to search"
              : "No matching users",
          fontSize: 13,
          color: Pallets.grey60,
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 4.h),
      itemCount: mentionable.length,
      itemBuilder: (context, index) {
        final user = mentionable[index];
        return InkWell(
          canRequestFocus: false,
          onTap: () => editor.selectMention(user.username!),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              children: [
                ClipOval(
                  child: ImageWidget(
                    imageUrl: user.avatar ?? Assets.images.svgs.dummyUser,
                    size: 32,
                    fit: BoxFit.cover,
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: user.name,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      TextView(
                        text: "@${user.username}",
                        color: Pallets.grey60,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
