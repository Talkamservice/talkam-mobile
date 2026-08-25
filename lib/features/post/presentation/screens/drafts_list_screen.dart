import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';
import 'package:talkam/features/post/presentation/bloc/drafts_cubit/drafts_cubit.dart';

/// `GET/PUT/DELETE /user/post-drafts[/{id}]` — the only draft affordance
/// that existed before this screen was the "Save as Draft" button in
/// [CreatePostSheet]; there was nowhere to see, edit, publish, or delete
/// a draft afterward.
class DraftsListScreen extends StatefulWidget {
  const DraftsListScreen({super.key});

  @override
  State<DraftsListScreen> createState() => _DraftsListScreenState();
}

class _DraftsListScreenState extends State<DraftsListScreen> {
  final cubit = DraftsCubit(injector.get<PostRepository>());

  @override
  void initState() {
    super.initState();
    cubit.getDrafts();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";
    return "${diff.inDays}d ago";
  }

  Future<void> _openEditSheet(TalkamPost draft) async {
    await CustomDialogs.showBottomSheet(
      context,
      BlocProvider.value(
        value: cubit,
        child: _DraftEditSheet(draft: draft),
      ),
      constraints: BoxConstraints(maxHeight: 0.9.sh),
    );
  }

  void _confirmDelete(TalkamPost draft) {
    CustomDialogs.showConfirmDialog(
      context,
      tittle: "Delete draft",
      message: "This draft will be permanently deleted. This can't be undone.",
      confirmText: "Delete",
      confirmButtonBgColor: Pallets.boldRedV2,
      onYes: () async {
        context.pop();
        final success = await cubit.deleteDraft(draft.id);
        if (!mounted) return;
        if (success) {
          CustomDialogs.showToast("Draft deleted");
        } else {
          CustomDialogs.error("Couldn't delete this draft");
        }
      },
    );
  }

  void _confirmPublish(TalkamPost draft) {
    CustomDialogs.showConfirmDialog(
      context,
      tittle: "Publish post",
      message: "This will publish the draft to your feed right away.",
      confirmText: "Publish",
      onYes: () async {
        context.pop();
        final success = await cubit.publishDraft(draft);
        if (!mounted) return;
        if (success) {
          CustomDialogs.success("Post published");
        } else {
          CustomDialogs.error("Couldn't publish this post");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: Pallets.white,
        appBar: const CustomAppBar(
          tittle: TextView(
            text: "My Drafts",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlack,
          ),
          centerTile: false,
        ),
        body: BlocBuilder<DraftsCubit, DraftsState>(
          builder: (context, state) => _buildBody(context, state),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, DraftsState state) {
    switch (state.status) {
      case LoadStatus.idle:
      case LoadStatus.loading:
        if (state.drafts.isEmpty) {
          return Center(child: CustomDialogs.getLoading(size: 50));
        }
        break;
      case LoadStatus.error:
        return AppErrorWidget(
          message: state.error ?? "Something went wrong",
          onTap: cubit.getDrafts,
        );
      case LoadStatus.success:
        if (state.drafts.isEmpty) {
          return Center(
            child: TextView(
              text: "No drafts yet",
              fontSize: 14,
              color: Pallets.grey400,
            ),
          );
        }
    }

    return RefreshIndicator(
      color: Pallets.blueBubbleColor,
      onRefresh: () => cubit.getDrafts(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        itemCount: state.drafts.length,
        separatorBuilder: (context, index) => 12.verticalSpace,
        itemBuilder: (context, index) {
          final draft = state.drafts[index];
          final isBusy =
              state.savingId == draft.id || state.deletingId == draft.id;
          return Opacity(
            opacity: isBusy ? 0.5 : 1,
            child: IgnorePointer(
              ignoring: isBusy,
              child: InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: () => _openEditSheet(draft),
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: Pallets.white,
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: (draft.title?.toString().isNotEmpty ?? false)
                                  ? draft.title.toString()
                                  : "Untitled draft",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Pallets.boldBlack,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            4.verticalSpace,
                            TextView(
                              text: (draft.body ?? "").isEmpty
                                  ? "No content yet"
                                  : draft.body!,
                              fontSize: 13,
                              color: Pallets.grey400,
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            8.verticalSpace,
                            Row(
                              children: [
                                if ((draft.category.name ?? '')
                                    .toString()
                                    .isNotEmpty) ...[
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF2F9FF),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: TextView(
                                      text: draft.category.name.toString(),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Pallets.blueBubbleColor,
                                    ),
                                  ),
                                  8.horizontalSpace,
                                ],
                                TextView(
                                  text: "Updated ${_timeAgo(draft.updatedAt)}",
                                  fontSize: 12,
                                  color: Pallets.grey400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert,
                            color: Pallets.grey400, size: 20.w),
                        onSelected: (value) {
                          switch (value) {
                            case 'edit':
                              _openEditSheet(draft);
                              break;
                            case 'publish':
                              _confirmPublish(draft);
                              break;
                            case 'delete':
                              _confirmDelete(draft);
                              break;
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(
                              value: 'publish', child: Text('Publish')),
                          PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete',
                                  style: TextStyle(color: Colors.red))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DraftEditSheet extends StatefulWidget {
  const _DraftEditSheet({required this.draft});

  final TalkamPost draft;

  @override
  State<_DraftEditSheet> createState() => _DraftEditSheetState();
}

class _DraftEditSheetState extends State<_DraftEditSheet> {
  late final _titleController =
      TextEditingController(text: widget.draft.title?.toString() ?? '');
  late final _bodyController =
      TextEditingController(text: widget.draft.body ?? '');
  bool _saving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_titleController.text.trim().isEmpty) {
      CustomDialogs.error("Please add a title for your post");
      return;
    }

    setState(() => _saving = true);
    final cubit = context.read<DraftsCubit>();
    final success = await cubit.updateDraft(
      widget.draft.id,
      categoryId: int.tryParse(widget.draft.category.id.toString()) ?? 0,
      type: widget.draft.type?.toString() ?? "Text",
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (success) {
      Navigator.of(context).pop();
      CustomDialogs.success("Draft saved");
    } else {
      CustomDialogs.error("Couldn't save this draft");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                16.w, 16.h, 16.w, 16.h + MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                        color: Pallets.grey90,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                16.verticalSpace,
                const TextView(
                  text: "Edit draft",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                16.verticalSpace,
                TextField(
                  controller: _titleController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
                12.verticalSpace,
                TextField(
                  controller: _bodyController,
                  maxLines: 8,
                  minLines: 6,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: "What's on your mind",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
                20.verticalSpace,
                CustomButton(
                  onPressed: _saving ? null : _save,
                  bgColor: Pallets.blueBubbleColor,
                  child: _saving
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(
                              strokeWidth: 2.2, color: Colors.white),
                        )
                      : const TextView(
                          text: "Save",
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
