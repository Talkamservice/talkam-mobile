import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/messaging/presentation/widgets/new_notification.dart';
import 'package:talkam/features/notifications/data/models/get_notifications_response.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/notifications/presentation/widgets/all_notifications_listener.dart';

class ConversationsTab extends StatefulWidget {
  const ConversationsTab({super.key});

  @override
  State<ConversationsTab> createState() => _ConversationsTabState();
}

class _ConversationsTabState extends State<ConversationsTab> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  List<TalkamNotification> _notifications = [];
  final bloc = NotificationsBloc(injector.get(), injector.get());

  @override
  void initState() {
    bloc.add(GetNotificationsEvent(tab: "conversation"));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        bloc.add(LoadMoreNotificationsEvent(previousNotifications: _notifications, tab: "conversation"));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NotificationsBloc, NotificationsState>(
        bloc: bloc,
        listener: _listenToNotificationBloc,
        builder: (context, state) {
          return SafeArea(
            child: Builder(
              builder: (context) {
                if (state is GetNotificationsLoadingState) {
                  return Center(
                    child: CustomDialogs.getLoading(size: 35),
                  );
                } else if (state is GetNotificationsFailureState) {
                  return Center(
                    child: AppErrorWidget(
                      onTap: () {
                        bloc.add(const GetNotificationsEvent(tab: "conversation"));
                      },
                    ),
                  );
                } else {
                  return Column(

                    children: [
                      AllNotificationsListener(onReadAll: () {
                        bloc.add(const GetNotificationsEvent(tab: "conversation"));
                      }),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            bloc.add(GetNotificationsEvent(tab: "conversation"));
                          },
                          child: _notifications.isEmpty
                              ? ListView(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  children: const [
                                    EmptyState(
                                      title: "No notifications here",
                                      subtitle: "Notifications will appear here if there are any.",
                                    )
                                  ],
                                )
                              : ListView.separated(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  controller: _scrollController,
                                  itemCount: state is LoadingMoreNotificationState ? _notifications.length + 1 : _notifications.length,
                                  separatorBuilder: (_, __) => const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  itemBuilder: (context, index) {
                                    if (index == _notifications.length) {
                                      return const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8.0),
                                        child: Center(child: SizedBox.square(dimension: 26, child: CircularProgressIndicator())),
                                      );
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 2),
                                      child: TalkamNotificationItem(
                                        notification: _notifications[index],
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  void _listenToNotificationBloc(BuildContext context, NotificationsState state) {
    if (state is ClearNotificationsDetailsLoadingState) {
      CustomDialogs.showLoading(context);
    }

    if (state is ClearNotificationsDetailsFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }

    if (state is ClearNotificationsDetailsSuccessState) {
      context.pop();
      CustomDialogs.success('Notifications cleared');
      bloc.add(GetNotificationsEvent());
    }

    if (state is GetNotificationsSuccessState) {
      _notifications = state.response;
      setState(() {});
    }
  }

  @override
  bool get wantKeepAlive => true;
}
