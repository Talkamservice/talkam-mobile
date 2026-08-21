import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/notifications/data/models/get_notifications_response.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/notifications/presentation/widgets/therapist_action_dialogs.dart';
import 'package:talkam/gen/assets.gen.dart';

/// `GET/POST /user/notifications/*` (v2) — one flat feed shared by consumer
/// and therapist accounts. Booking-request items (`extra.action` present)
/// get inline Accept/Decline actions, reached from `dataId` (the session id)
/// via `TherapistRepository.getSessionRequest`/`acknowledgeSession` and
/// `BookingRepository.cancelBooking`.
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final bloc = injector.get<NotificationsBloc>();

  List<TalkamNotification>? _notifications;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    bloc.add(const GetNotificationsEvent());
  }

  void _refresh() {
    setState(() {
      _loading = true;
      _error = null;
    });
    bloc.add(const GetNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittleText: "Notification",
        centerTile: false,
        titleAlign: TextAlign.left,
        showDivider: true,
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () => bloc.add(const ReadAllNotificationEvent()),
            child: const TextView(
              text: "Mark all read",
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Pallets.blueBubbleColor,
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Pallets.boldBlackV2, size: 22.w),
            onSelected: (value) {
              if (value == 'clear') _confirmClearAll(context);
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'clear', child: Text('Clear all')),
            ],
          ),
          4.horizontalSpace,
        ],
      ),
      body: SafeArea(
        child: BlocListener<NotificationsBloc, NotificationsState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is GetNotificationsLoadingState) {
              setState(() {
                _loading = true;
                _error = null;
              });
            } else if (state is GetNotificationsSuccessState) {
              setState(() {
                _loading = false;
                _notifications = state.response;
              });
            } else if (state is GetNotificationsFailureState) {
              setState(() {
                _loading = false;
                _error = state.error;
              });
            } else if (state is ReadAllNotificationSuccessState) {
              CustomDialogs.showToast('All notifications marked as read');
              bloc.add(GetNotificationsStatsEvent());
              _refresh();
            } else if (state is ReadAllNotificationFailureState) {
              CustomDialogs.showToast(state.error, isError: true);
            } else if (state is ClearNotificationsDetailsSuccessState) {
              CustomDialogs.showToast('Notifications cleared');
              bloc.add(GetNotificationsStatsEvent());
              setState(() => _notifications = []);
            } else if (state is ClearNotificationsDetailsFailureState) {
              CustomDialogs.showToast(state.error, isError: true);
            }
          },
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_loading && _notifications == null) {
      return Center(child: CustomDialogs.getLoading(size: 50));
    }
    if (_error != null && _notifications == null) {
      return Center(
        child: TextView(
          text: _error!,
          fontSize: 14,
          color: Pallets.grey400,
          align: TextAlign.center,
        ),
      );
    }

    final notifications = _notifications ?? [];
    if (notifications.isEmpty) {
      return EmptyState(
        imageUrl: Assets.images.svgV2.emptyState,
        title: "No notifications yet",
        subtitle: "You'll see session updates, messages, and activity here.",
      );
    }

    final groups = _groupByDay(notifications);
    return RefreshIndicator(
      color: Pallets.blueBubbleColor,
      onRefresh: () async => bloc.add(const GetNotificationsEvent()),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        children: [
          for (final group in groups) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: _DayChip(label: group.label),
            ),
            12.verticalSpace,
            for (final item in group.items) ...[
              _NotificationCard(
                item: item,
                onTap: () => _onTapNotification(item),
                onAccept: () => _openRequestSheet(item),
                onDecline: () => _declineFromNotification(item),
              ),
              12.verticalSpace,
            ],
            8.verticalSpace,
          ],
        ],
      ),
    );
  }

  void _onTapNotification(TalkamNotification item) {
    if (item.readAt == null) {
      bloc.add(ReadNotificationEvent(id: item.id.toString()));
      bloc.add(GetNotificationsStatsEvent());
    }
  }

  void _openRequestSheet(TalkamNotification item) {
    final sessionId = item.sessionRequestId;
    if (sessionId == null) return;
    _onTapNotification(item);
    TherapistActionDialogs.showSessionRequestBottomSheet(
      context,
      sessionId: sessionId,
      onAcknowledged: _refresh,
      onDeclined: _refresh,
    );
  }

  void _declineFromNotification(TalkamNotification item) {
    final sessionId = item.sessionRequestId;
    if (sessionId == null) return;
    _onTapNotification(item);
    TherapistActionDialogs.showDeclineReasonBottomSheet(
      context,
      bookingId: sessionId,
      subtitle: item.title?.toString(),
      onSuccess: _refresh,
    );
  }

  void _confirmClearAll(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear all notifications?'),
        content: const Text(
          'This removes every notification. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(const ClearNotificationsEvent());
            },
            child: const Text('Clear all'),
          ),
        ],
      ),
    );
  }

  List<_NotificationDayGroup> _groupByDay(
    List<TalkamNotification> notifications,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final Map<String, List<TalkamNotification>> buckets = {};
    for (final n in notifications) {
      final d = DateTime(n.createdAt.year, n.createdAt.month, n.createdAt.day);
      final label = d == today
          ? "Today"
          : (d == yesterday ? "Yesterday" : _formatDate(d));
      buckets.putIfAbsent(label, () => []).add(n);
    }
    return buckets.entries
        .map((e) => _NotificationDayGroup(label: e.key, items: e.value))
        .toList();
  }

  static String _formatDate(DateTime dt) {
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
    return "${months[dt.month - 1]} ${dt.day}";
  }
}

class _NotificationDayGroup {
  const _NotificationDayGroup({required this.label, required this.items});

  final String label;
  final List<TalkamNotification> items;
}

class _DayChip extends StatelessWidget {
  const _DayChip({required this.label});

  final String label;

  bool get _isToday => label == "Today";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorScheme.onSurface.withValues(alpha: 0.07),
        ),
        color: _isToday ? Pallets.blueBubbleColor : Pallets.grey90,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextView(
        text: label,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: _isToday ? Colors.white : Pallets.boldBlackV2,
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.item,
    required this.onTap,
    required this.onAccept,
    required this.onDecline,
  });

  final TalkamNotification item;
  final VoidCallback onTap;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  bool get _isUnread => item.readAt == null;

  /// The `type` vocabulary for booking-request items isn't documented, so
  /// presence of `extra.action` (rather than a specific `type` string) is
  /// what marks a notification as therapist-actionable — see
  /// [TalkamNotification.requestAction].
  bool get _isActionable =>
      SessionManager.instance.isTherapistAccount &&
      item.requestAction != null &&
      item.sessionRequestId != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _isUnread
              ? Pallets.blueBubbleColor.withValues(alpha: 0.04)
              : Pallets.grey90.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Pallets.grey90),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _bgColor.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: ImageWidget(imageUrl: _iconUrl, size: 24, color: _bgColor),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextView(
                          text: item.title?.toString() ?? '',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      8.horizontalSpace,
                      TextView(
                        text: timeago.format(item.createdAt),
                        fontSize: 11,
                        color: Pallets.grey60,
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  TextView(
                    text: item.message?.toString() ?? '',
                    fontSize: 13,
                    color: Pallets.grey400,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  if (_isActionable) ...[
                    10.verticalSpace,
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        CustomButton(
                          isExpanded: false,
                          elevation: 0,
                          bgColor: Pallets.blueBubbleColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          onPressed: onAccept,
                          child: const TextView(
                            text: "Open Session",
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        CustomOutlinedButton(
                          isExpanded: false,
                          text: "Decline",
                          foregroundColor: Pallets.boldBlackV2,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          borderColor: Pallets.grey90,
                          onPressed: onDecline,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _iconUrl {
    final t = item.type?.toString().toLowerCase() ?? '';
    if (t.contains('session') || t.contains('booking')) {
      return Assets.images.svgV2.calendarInActive;
    }
    if (t.contains('payout') || t.contains('earning')) {
      return Assets.images.svgV2.dollar2;
    }
    if (t.contains('comment')) return Assets.images.svgV2.commentIcon;
    if (t.contains('like') || t.contains('reaction')) {
      return Assets.images.svgV2.likeIcon;
    }
    if (t.contains('message') || t.contains('conversation')) {
      return Assets.images.svgV2.user2;
    }
    if (t.contains('wellness') || t.contains('mood')) {
      return Assets.images.svgV2.user2;
    }
    return Assets.images.svgV2.notificationIcon;
  }

  Color get _bgColor {
    final t = item.type?.toString().toLowerCase() ?? '';
    if (t.contains('session') || t.contains('booking')) {
      return Pallets.blueBubbleColor;
    }
    if (t.contains('payout') || t.contains('earning')) {
      return const Color(0xFF0F9C5B);
    }
    if (t.contains('comment')) return Colors.orange;
    if (t.contains('like') || t.contains('reaction')) return Colors.pink;
    if (t.contains('message') || t.contains('conversation'))
      return Colors.green;
    return Pallets.blueBubbleColor;
  }
}
