import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/inline_select_field.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/presentation/blocs/messaging/messaging_cubit.dart';
import 'package:talkam/features/messaging/presentation/screens/chat_screen.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'package:talkam/features/therapist/data/models/therapist_client.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';
import 'package:talkam/features/therapist/presentation/bloc/therapist_client_cubit/therapist_client_cubit.dart';
import 'package:talkam/gen/assets.gen.dart';

class ClientDetailsScreen extends StatefulWidget {
  final int clientId;

  const ClientDetailsScreen({super.key, required this.clientId});

  @override
  State<ClientDetailsScreen> createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
  final clientCubit = TherapistClientCubit(injector.get<TherapistRepository>());
  final settingsBloc = SettingsBloc(injector.get(), injector.get());
  final messagingCubit = MessagingCubit(injector.get());

  @override
  void initState() {
    super.initState();
    clientCubit.getClientDetails(widget.clientId);
  }

  @override
  void dispose() {
    clientCubit.close();
    settingsBloc.close();
    messagingCubit.close();
    super.dispose();
  }

  void _confirmBlock(String name) {
    CustomDialogs.showConfirmDialog(
      context,
      tittle: 'Block $name',
      message:
          "You won't see messages or posts from $name anymore. This doesn't cancel any upcoming session.",
      confirmButtonBgColor: Colors.red,
      onYes: () =>
          settingsBloc.add(SettingsEvent.blockUser(widget.clientId.toString())),
    );
  }

  void _openReportDialog() {
    showDialog<void>(
      context: context,
      builder: (_) => _ReportClientDialog(
        bloc: settingsBloc,
        clientId: widget.clientId.toString(),
      ),
    );
  }

  Future<void> _openMessageComposer(String name) async {
    final message = await showDialog<String>(
      context: context,
      builder: (_) => _FirstMessageDialog(recipientName: name),
    );
    if (message == null || message.trim().isEmpty) return;
    if (!mounted) return;

    CustomDialogs.showLoading(context);
    try {
      final conversation = await messagingCubit.startConversation(
        receiverId: widget.clientId,
        message: message.trim(),
      );
      if (!mounted) return;
      context.pop();
      context.pushNamed(
        PageUrl.chatScreen,
        extra: ChatScreenParam(
          conversation: conversation,
          user: conversation.otherMember ??
              (conversation.members?.firstWhere(
                (m) => m.id == widget.clientId,
                orElse: () => conversation.members!.first,
              )) ??
              ConversationUser(
                id: widget.clientId,
                name: name,
                username: name,
                email: "",
                avatar: null,
              ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      context.pop();
      CustomDialogs.error(e.toString());
    }
  }

  Future<void> _openTreatmentPlanEditor(TherapistClientDetail detail) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => _TreatmentPlanSheet(
        cubit: clientCubit,
        clientId: widget.clientId,
        currentPlan: detail.treatmentPlan,
        defaultSessions: detail.sessionsCount,
      ),
    );
    if (saved == true && mounted) {
      CustomDialogs.success("Treatment plan saved");
    }
  }

  void _openSessionNote(int sessionId) {
    context.pushNamed(
      PageUrl.clientNoteDetailScreen,
      extra: sessionId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      bloc: settingsBloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          blockUserLoading: () => CustomDialogs.showLoading(context),
          blockUserFailure: (error) {
            context.pop();
            CustomDialogs.error(error);
          },
          blockUserSuccess: (_) {
            context.pop();
            CustomDialogs.success('Client has been blocked');
          },
        );
      },
      child: Scaffold(
        backgroundColor: Pallets.white,
        appBar: CustomAppBar(
          titleAlign: TextAlign.center,
          centerTile: true,
          canGoBack: true,
          tittle: const SizedBox.shrink(),
          actions: [
            BlocBuilder<TherapistClientCubit, TherapistClientState>(
              bloc: clientCubit,
              builder: (context, state) {
                final name = state.detail?.name ?? '';
                return IconButton(
                  onPressed: state.detail == null
                      ? null
                      : () => _openMessageComposer(name),
                  icon: ImageWidget(imageUrl: Assets.images.svgV2.messageIcon),
                );
              },
            ),
            12.horizontalSpace,
          ],
        ),
        body: BlocBuilder<TherapistClientCubit, TherapistClientState>(
          bloc: clientCubit,
          builder: (context, state) {
            switch (state.detailStatus) {
              case LoadStatus.idle:
              case LoadStatus.loading:
                return Center(child: CustomDialogs.getLoading(size: 50));
              case LoadStatus.error:
                return Center(
                  child: TextView(
                    text: state.detailError ?? "Something went wrong",
                    fontSize: 14,
                    color: Pallets.grey400,
                    align: TextAlign.center,
                  ),
                );
              case LoadStatus.success:
                return _buildBody(context, state.detail!);
            }
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, TherapistClientDetail client) {
    final planTotal = client.treatmentPlan?.totalSessions ?? 0;
    final double progressFraction = planTotal > 0
        ? (client.completedSessions / planTotal).clamp(0, 1).toDouble()
        : 0.0;

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          Center(
            child: Column(
              children: [
                Container(
                  width: 60.r,
                  height: 60.r,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2F9FF),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: ImageWidget(
                      imageUrl: Assets.images.svgV2.userInActive,
                      size: 24,
                      color: Pallets.blueBubbleColor,
                    ),
                  ),
                ),
                16.verticalSpace,
                TextView(
                  text: client.name,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlack,
                ),
                4.verticalSpace,
                TextView(
                  text:
                      "Client since ${_formatDate(client.clientSince)}${client.topics.isNotEmpty ? ' • ${client.topics.first}' : ''}",
                  fontSize: 14,
                  color: Pallets.grey400,
                ),
              ],
            ),
          ),
          16.verticalSpace,

          // Report / Block
          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  onPressed: _openReportDialog,
                  isExpanded: true,
                  borderColor: Pallets.grey90,
                  foreGroundColor: Pallets.boldBlack,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageWidget(
                        imageUrl: Assets.images.svgs.flag02,
                        size: 16.w,
                        color: Pallets.boldBlack,
                      ),
                      6.horizontalSpace,
                      const TextView(
                        text: "Report",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: CustomOutlinedButton(
                  onPressed: () => _confirmBlock(client.name),
                  isExpanded: true,
                  borderColor: Pallets.boldRed.withValues(alpha: 0.3),
                  foreGroundColor: Pallets.boldRed,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageWidget(
                        imageUrl: Assets.images.svgs.blockedUser,
                        size: 16.w,
                        color: Pallets.boldRed,
                      ),
                      6.horizontalSpace,
                      const TextView(
                        text: "Block",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Pallets.boldRed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          32.verticalSpace,

          // Stats Row
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  value: client.sessionsCount.toString(),
                  label: "Sessions",
                ),
              ),
              Container(width: 1, height: 40.h, color: Pallets.grey90),
              Expanded(
                child: _buildStatItem(
                  value: planTotal > 0 ? planTotal.toString() : "—",
                  label: "Plan total",
                ),
              ),
              Container(width: 1, height: 40.h, color: Pallets.grey90),
              Expanded(
                child: _buildStatItem(
                  value: client.treatmentPlan?.progressStatus
                          .replaceAll('_', ' ') ??
                      "—",
                  label: "Progress",
                  valueColor: const Color(0xFF0F9D58),
                ),
              ),
            ],
          ),
          32.verticalSpace,

          // Treatment Progress
          InkWell(
            onTap: () => _openTreatmentPlanEditor(client),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextView(
                  text: "Treatment Progress",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlackV2,
                ),
                TextView(
                  text: planTotal > 0
                      ? "${client.completedSessions}/$planTotal sessions"
                      : "Set treatment plan",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Pallets.primary,
                ),
              ],
            ),
          ),
          8.verticalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: LinearProgressIndicator(
              value: progressFraction,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: const AlwaysStoppedAnimation<Color>(Pallets.primary),
              minHeight: 8.h,
            ),
          ),
          24.verticalSpace,

          // Needs-note prompt
          if (client.needsNote && client.sessionHistory.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F9FF),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.assignment_outlined,
                        color: Pallets.primary, size: 24.w),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            text: "Add a note for the last session",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Pallets.primary,
                          ),
                          2.verticalSpace,
                          TextView(
                            text: _formatDate(
                                client.sessionHistory.first.startsAt),
                            fontSize: 12,
                            color: Pallets.grey400,
                          ),
                        ],
                      ),
                    ),
                    8.horizontalSpace,
                    CustomButton(
                      onPressed: () =>
                          _openSessionNote(client.sessionHistory.first.id),
                      isExpanded: false,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      borderRadius: BorderRadius.circular(20.r),
                      child: const TextView(
                        text: "Write",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Pallets.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Session History
          const TextView(
            text: "SESSION HISTORY",
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Pallets.grey,
          ),
          16.verticalSpace,
          if (client.sessionHistory.isEmpty)
            TextView(
              text: "No sessions yet.",
              fontSize: 13,
              color: Pallets.grey400,
            )
          else
            for (final session in client.sessionHistory) ...[
              _buildSessionHistoryItem(session),
              12.verticalSpace,
            ],
          40.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String value,
    required String label,
    Color? valueColor,
  }) {
    return Column(
      children: [
        TextView(
          text: value,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: valueColor ?? Pallets.boldBlack,
        ),
        4.verticalSpace,
        TextView(text: label, fontSize: 12, color: Pallets.grey400),
      ],
    );
  }

  Widget _buildSessionHistoryItem(ClientSessionHistoryItem session) {
    return InkWell(
      onTap: () => _openSessionNote(session.id),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF6FBFF),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: const BoxDecoration(
                color: Pallets.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                session.status == 'completed'
                    ? Icons.check
                    : Icons.calendar_today_outlined,
                color: const Color(0xFF0F9D58),
                size: 16.w,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: _formatDate(session.startsAt),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Pallets.boldBlack,
                  ),
                  4.verticalSpace,
                  TextView(
                    text: session.summary ??
                        "${session.format[0].toUpperCase()}${session.format.substring(1)} • ${session.status}",
                    fontSize: 12,
                    color: Pallets.grey400,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Pallets.grey400, size: 24.w),
          ],
        ),
      ),
    );
  }

  static String _formatDate(String raw) {
    final dt = DateTime.tryParse(raw);
    if (dt == null) return raw;
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${months[dt.month - 1]} ${dt.day}, ${dt.year}";
  }
}

/// Collects a reason (required) and optional context before submitting
/// `POST /user/user-reports`. Only one open report is allowed per
/// (reporter, target) pair — a second attempt is rejected server-side.
class _ReportClientDialog extends StatefulWidget {
  const _ReportClientDialog({required this.bloc, required this.clientId});

  final SettingsBloc bloc;
  final String clientId;

  @override
  State<_ReportClientDialog> createState() => _ReportClientDialogState();
}

class _ReportClientDialogState extends State<_ReportClientDialog> {
  final _reasonController = TextEditingController();
  final _contextController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    _contextController.dispose();
    super.dispose();
  }

  void _submit() {
    final reason = _reasonController.text.trim();
    if (reason.isEmpty) return;
    Navigator.of(context).pop();
    widget.bloc.add(SettingsEvent.reportUser(
      reportedUserId: widget.clientId,
      reason: reason,
      context: _contextController.text.trim().isEmpty
          ? null
          : _contextController.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      bloc: widget.bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          reportUserLoading: () => CustomDialogs.showLoading(context),
          reportUserFailure: (error) {
            context.pop();
            CustomDialogs.error(error);
          },
          reportUserSuccess: () {
            context.pop();
            CustomDialogs.success("Report submitted");
          },
        );
      },
      child: Dialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextView(
                text: "Report client",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              8.verticalSpace,
              const TextView(
                text: "Tell us what happened. This is reviewed by our team.",
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Pallets.grey400,
              ),
              16.verticalSpace,
              OutlinedFormField(
                placeHolder: "Reason",
                hint: "e.g. Abusive behaviour",
                controller: _reasonController,
              ),
              12.verticalSpace,
              OutlinedFormField(
                placeHolder: "Additional context (optional)",
                hint: "e.g. session reference",
                controller: _contextController,
                maxLine: 3,
                minLine: 3,
              ),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
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
                    child: CustomButton(
                      elevation: 0,
                      bgColor: Colors.red,
                      onPressed: _submit,
                      child: const TextView(
                        text: "Submit",
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

/// Simple text-entry dialog for the message that kicks off a brand-new
/// conversation (`POST /user/messaging/conversations` requires one).
class _FirstMessageDialog extends StatefulWidget {
  const _FirstMessageDialog({required this.recipientName});

  final String recipientName;

  @override
  State<_FirstMessageDialog> createState() => _FirstMessageDialogState();
}

class _FirstMessageDialogState extends State<_FirstMessageDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: "Message ${widget.recipientName}",
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            16.verticalSpace,
            CustomTextField(
              controller: _controller,
              hint: "Type your message…",
              maxLines: 4,
            ),
            20.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
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
                  child: CustomButton(
                    elevation: 0,
                    onPressed: () =>
                        Navigator.of(context).pop(_controller.text),
                    child: const TextView(
                      text: "Send",
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
    );
  }
}

/// `POST /therapist/clients/{id}/treatment-plan` editor. [progressStatus]'s
/// options are assumed (see [kProgressStatusOptions]) — no values-list
/// endpoint is documented for its "config-driven vocabulary".
class _TreatmentPlanSheet extends StatefulWidget {
  const _TreatmentPlanSheet({
    required this.cubit,
    required this.clientId,
    required this.currentPlan,
    required this.defaultSessions,
  });

  final TherapistClientCubit cubit;
  final int clientId;
  final TreatmentPlan? currentPlan;
  final int defaultSessions;

  @override
  State<_TreatmentPlanSheet> createState() => _TreatmentPlanSheetState();
}

class _TreatmentPlanSheetState extends State<_TreatmentPlanSheet> {
  late final _sessionsController = TextEditingController(
    text: (widget.currentPlan?.totalSessions ?? widget.defaultSessions)
        .toString(),
  );
  late final _notesController =
      TextEditingController(text: widget.currentPlan?.notes ?? '');
  late String? _progressStatus = widget.currentPlan?.progressStatus;
  bool _saving = false;

  @override
  void dispose() {
    _sessionsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final total = int.tryParse(_sessionsController.text.trim());
    if (total == null || total <= 0 || _progressStatus == null) return;
    setState(() => _saving = true);
    final success = await widget.cubit.setTreatmentPlan(
      widget.clientId,
      totalSessions: total,
      progressStatus: _progressStatus!,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );
    if (!mounted) return;
    if (success) {
      Navigator.of(context).pop(true);
    } else {
      setState(() => _saving = false);
      CustomDialogs.error(
          widget.cubit.state.planError ?? "Couldn't save treatment plan");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 24.h,
        bottom: 24.h + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextView(
            text: "Treatment plan",
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          20.verticalSpace,
          CustomTextField(
            label: "Total sessions",
            hint: "e.g. 8",
            controller: _sessionsController,
            keyboardType: TextInputType.number,
          ),
          16.verticalSpace,
          InlineSelectField<String>(
            label: "Progress",
            hint: "Select progress status",
            options: kProgressStatusOptions,
            labelBuilder: (v) => v.replaceAll('_', ' '),
            value: _progressStatus,
            onSingleChanged: (v) => setState(() => _progressStatus = v),
          ),
          16.verticalSpace,
          CustomTextField(
            label: "Notes (optional)",
            hint: "Anything worth remembering about this plan",
            controller: _notesController,
            maxLines: 3,
          ),
          24.verticalSpace,
          CustomButton(
            elevation: 0,
            onPressed: _saving ? null : _save,
            child: _saving
                ? CustomDialogs.getLoading(size: 24, color: Colors.white)
                : const TextView(
                    text: "Save",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
          ),
        ],
      ),
    );
  }
}
