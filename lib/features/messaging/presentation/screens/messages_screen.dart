import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/common/widgets/typeahead_widget.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/messaging/data/models/conversations_filter.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/messaging/presentation/widgets/messages_list.dart';
import 'package:talkam/features/messaging/presentation/widgets/messages_loading_shimmer.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/search/data/models/get_search_response.dart';
import 'package:talkam/features/search/presentation/blocs/search/search_cubit.dart';
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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, left: 1, right: 18),
            child: MessageAppBar(),
          ),
          2.verticalSpace,
          SizedBox(
            width: 1.sw,
            child: const Divider(
              thickness: 1,
            ),
          ),

          GuestUserHelper.guestUserWidget(widget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomSearchField(
              controller: _searchController,
              onChanged: (p0) {
                GuestUserHelper.handleGuestUserAction(
                  action: () {

                    Debouncer(milliseconds: 100).run(
                          () {
                        injector
                            .get<ConversationsCubit>()
                            .getConversations(reload: false, filter: ConversationsFilter(status: "", search: _searchController.text, tab: ""));
                      },
                    );
                  },
                );
              },
              // focusNode: p2,
            ),
          ),guestWidget: 0.verticalSpace ),
          GuestUserHelper.guestUserWidget(
              guestWidget:  AppErrorWidget(
                title: "You are a guest",
                retryText: "Sign In",
                onTap: () {

                  context.pushNamed(PageUrl.onboardingIntro);
                },
                message: "You cannot view messages because you are a guest, Please signin to view messages.",
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
                      return MessagesList(
                        message: response.data,
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

class MessageAppBar extends StatelessWidget {
  const MessageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 1, right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      context.read<DrawerCubit>().closeDrawer();
                      context.read<DrawerCubit>().openDrawer();
                      /**/
                    },
                    icon: Icon(
                      Icons.menu_outlined,
                      color: context.colorScheme.onSurface,
                    )),
                const TextView(
                  text: "Messages",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                const Spacer(),
                20.horizontalSpace,
                GuestUserHelper.guestUserWidget(
                  widget: InkWell(
                    onTap: () => context.pushNamed(PageUrl.new_requestScreen),
                    child: BlocBuilder<NotificationsBloc, NotificationsState>(
                      bloc: injector.get<NotificationsBloc>(),
                      builder: (context, state) {
                        final stat = injector.get<NotificationsBloc>().stats;
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(PageUrl.new_requestScreen);
                              },
                              child: const TextView(
                                text: "Requests",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (stat.totalRequests != 0)
                              Positioned(
                                top: -10,
                                right: -10,
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  child: TextView(
                                    text: stat.totalRequests.toString(),
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  guestWidget: const SizedBox.shrink(), // Or your desired guest widget
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key, required this.controller, this.focusNode, this.onSubmitted, this.onChanged, this.hint});

  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      // keyboardType: TextInputType.,

      onSubmitted: onSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(13.0),
          child: ImageWidget(
            imageUrl: Assets.images.svgs.search,
            color: Pallets.grey,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hint ?? "Search messages",
        hintStyle: const TextStyle(
          color: Color(0xff212121),
        ),
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Pallets.borderGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Pallets.borderGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Pallets.borderGrey,
          ),
        ),
      ),
    );
  }
}
