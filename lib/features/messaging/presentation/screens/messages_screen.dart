import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/messaging/presentation/widgets/conversation_state_action_sheet.dart';
import 'package:talkam/features/messaging/presentation/widgets/messages_list.dart';
import 'package:talkam/features/messaging/presentation/widgets/messages_loading_shimmer.dart';
import 'package:talkam/gen/assets.gen.dart';

enum _ConversationsTab {
  all("All"),
  starred("Starred"),
  archived("Archived");

  const _ConversationsTab(this.label);

  final String label;
}

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  final _cubit = injector.get<ConversationsCubit>();

  _ConversationsTab _selectedTab = _ConversationsTab.all;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _cubit.getConversationsList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        final state = _cubit.state;
        state.maybeWhen(
          orElse: () {},
          getConversationsListSuccess: (response) {
            _cubit.fetchNextConversationsPage(
              response.data.data,
              response.data.paginationMeta,
              archived: _selectedTab == _ConversationsTab.archived,
              starred: _selectedTab == _ConversationsTab.starred,
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _selectTab(_ConversationsTab tab) {
    if (tab == _selectedTab) return;
    setState(() => _selectedTab = tab);
    _cubit.getConversationsList(
      archived: tab == _ConversationsTab.archived,
      starred: tab == _ConversationsTab.starred,
    );
  }

  void _refresh() {
    _cubit.getConversationsList(
      archived: _selectedTab == _ConversationsTab.archived,
      starred: _selectedTab == _ConversationsTab.starred,
    );
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
                  // Conversation search isn't a server-side filter on this
                  // endpoint (only `archived`/`starred` are) — this filters
                  // the currently-loaded page client-side by name/username.
                  onChanged: (value) =>
                      setState(() => _searchQuery = value.trim()),
                ),
              ),
              guestWidget: 0.verticalSpace),
          GuestUserHelper.guestUserWidget(
              widget: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: _ConversationsTab.values
                      .map((tab) => Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: _TabChip(
                              label: tab.label,
                              isSelected: tab == _selectedTab,
                              onTap: () => _selectTab(tab),
                            ),
                          ))
                      .toList(),
                ),
              ),
              guestWidget: 0.verticalSpace),
          8.verticalSpace,
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
                bloc: _cubit,
                buildWhen: _buildWhen,
                listener: (context, state) {},
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => 0.verticalSpace,
                    getConversationsListFailure: (error) {
                      return AppErrorWidget(onTap: _refresh);
                    },
                    getConversationsListLoading: () {
                      return const MessagesLoadingShimmer();
                    },
                    getConversationsListSuccess: (response) {
                      final fetched = response.data.data;
                      // Only the untouched "All" tab falls back to mock data
                      // when the API is empty — an empty Starred/Archived
                      // tab is a real, meaningful state, not a "no seed
                      // data yet" placeholder. This must NOT depend on the
                      // search query, otherwise typing a single character
                      // while viewing the mock fallback swaps the base list
                      // out from under the filter and the results vanish.
                      final List<TalkamConversation> conversations =
                          fetched.isEmpty &&
                                  _selectedTab == _ConversationsTab.all
                              ? MockHomeData.conversations
                              : fetched;

                      final query = _searchQuery.toLowerCase();
                      final visible = query.isEmpty
                          ? conversations
                          : conversations
                              .where((c) =>
                                  c.otherUser.name
                                      .toLowerCase()
                                      .contains(query) ||
                                  c.otherUser.username
                                      .toLowerCase()
                                      .contains(query) ||
                                  (c.lastMessage?.message
                                          .toLowerCase()
                                          .contains(query) ??
                                      false))
                              .toList();

                      return MessagesList(
                        message: visible,
                        controller: _scrollController,
                        isLoadingMore: false,
                        onRefresh: _refresh,
                        onLongPress: (conversation) {
                          if (MockHomeData.isMockConversationId(
                              conversation.id)) {
                            return;
                          }
                          CustomDialogs.showCustomDialog(
                            ConversationStateActionSheet(
                                conversation: conversation),
                            context,
                          );
                        },
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
    getConversationsListFailure: (error) => true,
    getConversationsListLoading: () => true,
    getConversationsListSuccess: (response) => true,
  );
}

class _TabChip extends StatelessWidget {
  const _TabChip(
      {required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          children: [
            TextView(
              text: label,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color:
                  isSelected ? context.colorScheme.onSurface : Pallets.grey400,
            ),
            6.verticalSpace,
            Container(
              height: 3,
              width: 28.w,
              decoration: BoxDecoration(
                color:
                    isSelected ? Pallets.blueBubbleColor : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
