import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Compact "permanently delete account" confirmation dialog.
///
/// Matches the Profile delete-account mockup: red trash icon, a close (X),
/// a confirm message + subtitle, and Cancel / Delete actions. Owns its own
/// [SettingsBloc] so it can be shown from anywhere via [show].
class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  /// Shows the dialog as a modal. Returns once dismissed.
  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Pallets.black.withValues(alpha: 0.35),
      builder: (_) => const DeleteAccountDialog(),
    );
  }

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final bloc = SettingsBloc(injector.get(), injector.get());

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          deleteAccountLoading: () => CustomDialogs.showLoading(context),
          deleteAccountFailure: (error) {
            context.pop(); // dismiss loading
            CustomDialogs.error(error);
          },
          deleteAccountSuccess: (response) {
            context.pop(); // dismiss loading
            SessionManager.instance.logOut();
            context.goNamed(PageUrl.signUp);
            CustomDialogs.success('Account deleted');
          },
        );
      },
      child: Dialog(
        backgroundColor: Colors.white,
        elevation: 5,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Close ──────────────────────────────────────────────
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => context.pop(),
                  borderRadius: BorderRadius.circular(20.r),
                  child: Padding(
                    padding: EdgeInsets.all(4.r),
                    child: Icon(Icons.close, size: 20.r, color: Pallets.grey400),
                  ),
                ),
              ),
              // ── Trash icon ─────────────────────────────────────────
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Pallets.boldRed.withValues(alpha: 0.08),
                ),
                alignment: Alignment.center,
                child: ImageWidget(imageUrl: Assets.images.svgs.trash03, size: 30.r,)
                // Icon(
                //   Icons.delete_outline,
                //   size: 30.r,
                //   color: Pallets.boldRed,
                // ),
              ),
              20.verticalSpace,
              const TextView(
                text: "Please confirm if you wish to permanently delete "
                    "your account.",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Pallets.boldBlackV2,
                align: TextAlign.center,
                lineHeight: 1.35,
              ),
              8.verticalSpace,
              const TextView(
                text: "You have declined your session",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Pallets.grey400,
                align: TextAlign.center,
              ),
              24.verticalSpace,
              // ── Actions ────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => context.pop(),
                      child: const TextView(
                        text: "Cancel",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Pallets.blueBubbleColor,
                      ),
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Pallets.boldRed,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () =>
                          bloc.add(const SettingsEvent.deleteAccount()),
                      child: const TextView(
                        text: "Delete",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
