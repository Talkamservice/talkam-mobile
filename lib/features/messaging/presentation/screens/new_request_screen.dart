import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/messaging/presentation/screens/chat_screen.dart';
import 'package:talkam/features/messaging/presentation/widgets/conversation_item.dart';

class NewRequestScreen extends StatefulWidget {
  const NewRequestScreen({super.key});

  @override
  State<NewRequestScreen> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  // final injector.get<ConversationsCubit>() = ConversationsCubit(injector.get());

  @override
  void initState() {
    injector.get<ConversationsCubit>().getPendingRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        leadingWidth: 25,
        tittle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextView(
              text: "New Requests",
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        centerTile: false,
        showDivider: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: BlocConsumer<ConversationsCubit, ConversationsState>(
            buildWhen: _buildWhen,
            bloc: injector.get<ConversationsCubit>(),
            listener: (context, state) {},
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => 0.verticalSpace,
                getPendingRequestsFailure: (error) {
                  return AppErrorWidget(
                    onTap: () {
                      injector.get<ConversationsCubit>().getPendingRequest();
                    },
                  );
                },
                getPendingRequestsLoading: () {
                  return CustomDialogs.getLoading(size: 40);
                },
                getPendingRequestsSuccess: (response) {
                  if (response.data.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        injector.get<ConversationsCubit>().getPendingRequest();
                      },
                      child: ListView(
                        children: [
                          100.verticalSpace,
                          const EmptyState(
                            title: "No Pending Requests Here ",
                            subtitle:
                                "Your pending requests will appear here if there are any",
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      injector.get<ConversationsCubit>().getPendingRequest();
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: response.data.length,
                      itemBuilder: (BuildContext context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.pushNamed(PageUrl.chatScreen,
                                extra: ChatScreenParam(
                                    conversation: response.data[index],
                                    user: response.data[index].otherUser));
                          },
                          child:
                              ConversationItem(message: response.data[index]),
                        );
                      },
                      separatorBuilder: (context, _) =>
                          const SizedBox(height: 16),
                    ),
                  );
                },
              );
            },
          ))
        ],
      ),
    );
  }

  bool _buildWhen(ConversationsState previous, ConversationsState current) {
    return current.maybeWhen(
      orElse: () => false,
      getPendingRequestsFailure: (error) => true,
      getPendingRequestsLoading: () => true,
      getPendingRequestsSuccess: (response) => true,
    );
  }
}
