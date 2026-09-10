import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/group/presentation/blocs/group_invite_cubit/group_invite_cubit.dart';

/// Bottom sheet for inviting someone to a group by email — opened from the
/// person-add icon on [GroupDetailsHeader]. Any member can invite (this
/// sheet doesn't gate on role; the header only shows the icon to members).
class InviteToGroupSheet extends StatefulWidget {
  const InviteToGroupSheet({super.key, required this.groupId});

  final String groupId;

  @override
  State<InviteToGroupSheet> createState() => _InviteToGroupSheetState();
}

class _InviteToGroupSheetState extends State<InviteToGroupSheet> {
  final _cubit = GroupInviteCubit(injector.get());
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _cubit.close();
    _emailController.dispose();
    super.dispose();
  }

  void _sendInvite() {
    if (_formKey.currentState?.validate() ?? false) {
      _cubit.inviteToGroup(
        groupId: widget.groupId,
        email: _emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupInviteCubit, GroupInviteState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is InviteToGroupLoading) {
          CustomDialogs.showLoading(context);
        }
        if (state is InviteToGroupFailure) {
          context.pop(); // pop loading
          CustomDialogs.error(state.error);
        }
        if (state is InviteToGroupSuccess) {
          context.pop(); // pop loading
          context.pop(); // pop sheet
          CustomDialogs.showToast("Invite sent");
        }
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Pallets.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            bottom: 24.h + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Handle bar ─────────────────────────────────────────
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
                    child: Container(
                      width: 48.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Pallets.boldBlackV2,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),

                const TextView(
                  text: "Invite to group",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlackV2,
                ),
                8.verticalSpace,
                const TextView(
                  text: "Enter their email address and we'll send them an "
                      "invite to join this group.",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                  lineHeight: 1.4,
                ),
                20.verticalSpace,

                CustomTextField(
                  label: "Email address",
                  hint: "Enter their email address",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Email is required"),
                    EmailValidator(errorText: "Enter a valid email address"),
                  ]).call,
                ),
                20.verticalSpace,

                CustomButton(
                  onPressed: _sendInvite,
                  bgColor: Pallets.blueBubbleColor,
                  borderRadius: BorderRadius.circular(14.r),
                  child: const TextView(
                    text: "Send Invite",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                8.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
