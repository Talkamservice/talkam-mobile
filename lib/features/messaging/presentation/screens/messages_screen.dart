import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/common/widgets/typeahead_widget.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/messaging/presentation/screens/chat_screen.dart';
import 'package:talkam/features/messaging/presentation/widgets/messages_list.dart';
import 'package:talkam/features/search/data/models/get_search_response.dart';
import 'package:talkam/features/search/presentation/blocs/search/search_cubit.dart';
import 'package:talkam/gen/assets.gen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 1, right: 18),
            child: MessageAppBar(),
          ),
          2.verticalSpace,
          Container(
            width: 1.sw,
            child: const Divider(
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GenericTypeAheadField<SearchResponse>(
              labelText: "Search messages",
              suggestionsCallback: (query) async {
                return [];
              },
              itemBuilder: (context, suggestion) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: TextView(text: suggestion.word),
                );
              },
              builder: (p0, p1, p2) {
                return MessageSearchField(
                  controller: p1,
                  focusNode: p2,
                );
              },
              onSuggestionSelected: (suggestion) {
                injector.get<SearchCubit>().fetchRecentSearches();
                context
                    .pushNamed(PageUrl.searchResultScreen,
                        extra: suggestion.word)
                    .then(
                  (value) {
                    FocusScope.of(context).unfocus();
                    injector
                        .get<SearchCubit>()
                        .fetchRecentSearches(reload: false);
                  },
                );
              },
            ),
          ),
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    context.pushNamed(PageUrl.chatScreen);
                  },
                  child: MessagesList()))
        ],
      ),
    );
  }
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
                Row(
                  children: [
                    const TextView(
                      text: "4",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const TextView(
                      text: "New",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageSearchField extends StatelessWidget {
  const MessageSearchField(
      {super.key, required this.controller, this.focusNode});

  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,

      // keyboardType: TextInputType.,

      onSubmitted: (value) {
        if (controller.text.isNotEmpty) {
          injector.get<SearchCubit>().fetchRecentSearches();
          context
              .pushNamed(PageUrl.searchResultScreen, extra: controller.text)
              .then(
            (value) {
              injector.get<SearchCubit>().fetchRecentSearches(reload: false);
            },
          );
        }
      },
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
        hintText: "Search messages",
        hintStyle: TextStyle(
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
