import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/block_reason_sheet.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/ads/presentation/widgets/view_analytics_bottomsheet.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/confirm_report_dialog.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupActionSheet extends StatefulWidget {
  const GroupActionSheet({
    super.key,
    required this.group,
  });

  final TalkamGroup group;

  @override
  State<GroupActionSheet> createState() => _GroupActionSheetState();
}

class _GroupActionSheetState extends State<GroupActionSheet> {
  final bloc = GroupsCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
          )),
      child: BlocConsumer<GroupsCubit, GroupsState>(
        bloc: bloc,
        listener: (context, state) {

          state.maybeWhen(
            orElse: () => null,
            reportGroupFailureState: (error) {
              context.pop();
              CustomDialogs.error(error);
            },
            reportGroupLoading: () {
              CustomDialogs.showLoading(context);
            },
            reportGroupSuccess: (response) {
              injector.get<GroupsCubit>().refreshGroups();
              context.pop();
              context.pop();
              context.pop();
              CustomDialogs.success("Group Reported");
            },
          );
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(!(widget.group.isReported??false))
              _ActionItem(
                imagePath: Assets.images.svgs.flag02,
                tittle: "Report Group",
                onTap: () async {
                  var reason = await CustomDialogs.showCustomDialog(BlockReasonSheet(), context);
                  if (reason != null) {
                    var report = await CustomDialogs.showCustomDialog(
                        ConfirmReportDialog(
                          reason: reason!,
                        ),
                        context);

                    if (report) {
                      bloc.reportGroup(groupId: widget.group.id.toString(), reason: reason);
                    }
                  }
                },
              ),
              if (groupIsFromLoggedInUser && widget.group.isPromoted)
                _ActionItem(
                  imagePath: Assets.images.svgs.analytics,
                  tittle: "View analytics",
                  onTap: () async {
                    context.pop();
                    await CustomDialogs.showBottomSheet(
                      context,
                      ViewAnalyticsBottomSheet(
                        isPost: false,
                        postId: widget.group.id.toString(),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
  bool get groupIsFromLoggedInUser => widget.group.isOwner;

}

class _ActionItem extends StatelessWidget {
  const _ActionItem({super.key, required this.imagePath, required this.tittle, required this.onTap});

  final String imagePath;
  final String tittle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
            child: Row(
              children: [
                ImageWidget(imageUrl: imagePath),
                18.horizontalSpace,
                TextView(
                  text: tittle,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
          ),
          const Divider(
              // thickness: 1,
              )
        ],
      ),
    );
  }
}
