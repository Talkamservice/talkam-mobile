import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/utils/custom_debouncer.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/messaging/data/models/conversations_filter.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/messaging/presentation/widgets/messages_list.dart';
import 'package:talkam/features/messaging/presentation/widgets/messages_loading_shimmer.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    injector.get<ConversationsCubit>().getConversations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: CustomAppBar(
        centerTile: false,
        tittleText: "Messages",
      ),
      body: Column(
        children: [
          GuestUserHelper.guestUserWidget(
              widget: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: CustomTextField(
                  controller: _searchController,
                  hint: "Search messages",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: ImageWidget(
                      imageUrl: Assets.images.svgV2.searchIcon,
                      color: Pallets.grey400,
                    ),
                  ),
                  onChanged: (p0) {
                    GuestUserHelper.handleGuestUserAction(
                      action: () {
                        Debouncer(milliseconds: 100).run(
                          () {
                            injector.get<ConversationsCubit>().getConversations(
                                reload: false,
                                filter: ConversationsFilter(
                                    status: "",
                                    search: _searchController.text,
                                    tab: ""));
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              guestWidget: 0.verticalSpace),
          GuestUserHelper.guestUserWidget(
              guestWidget: AppErrorWidget(
                title: "You are a guest",
                retryText: "Sign In",
                onTap: () {
                  context.pushNamed(PageUrl.onboardingIntro);
                },
                message:
                    "You cannot view messages because you are a guest, Please signin to view messages.",
              ),
              widget: Expanded(
                  child: BlocConsumer<ConversationsCubit, ConversationsState>(
                bloc: injector.get(),
                buildWhen: _buildWhen,
                listener: (context, state) {},
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => 0.verticalSpace,
                    getConversationsFailure: (error) {
                      return AppErrorWidget(
                        onTap: () {
                          injector.get<ConversationsCubit>().getConversations();
                        },
                      );
                    },
                    getConversationsLoading: () {
                      return const MessagesLoadingShimmer();
                    },
                    getConversationsSuccess: (response) {
                      final List<TalkamConversation> conversations =
                          response.data.isEmpty &&
                                  _searchController.text.isEmpty
                              ? MockHomeData.conversations
                              : response.data;
                      return MessagesList(
                        message: conversations,
                      );
                    },
                  );
                },
              )))
        ],
      ),
    );
  }
}

bool _buildWhen(ConversationsState previous, ConversationsState current) {
  return current.maybeWhen(
    orElse: () => false,
    getConversationsFailure: (error) => true,
    getConversationsLoading: () => true,
    getConversationsSuccess: (response) => true,
  );
}
