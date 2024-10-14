import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:talkam/core/theme/pallets.dart';

class CustomEmojiPicker extends StatelessWidget {
  final TextEditingController textEditingController;
  final ScrollController scrollController;
  final TextStyle? emojiTextStyle;
  final Color? backgroundColor;
  final Color? dividerColor;
  final Color? indicatorColor;
  final Color? iconColorSelected;
  final Color? iconColor;
  final Color? buttonColor;
  final Color? buttonIconColor;
  final bool? checkPlatformCompatibility;
  final bool? swapCategoryAndBottomBar;

  const CustomEmojiPicker({
    Key? key,
    required this.textEditingController,
    required this.scrollController,
    this.emojiTextStyle,
    this.backgroundColor = Colors.white,
    this.dividerColor = Colors.white,
    this.indicatorColor = Colors.blueAccent,
    this.iconColorSelected = Colors.black,
    this.iconColor = Colors.grey,
    this.buttonColor = Colors.white,
    this.buttonIconColor = Colors.grey,
    this.checkPlatformCompatibility = true,
    this.swapCategoryAndBottomBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      textEditingController: textEditingController,
      scrollController: scrollController,
      config: Config(
        height: 256,
        checkPlatformCompatibility: checkPlatformCompatibility ?? true,
        emojiTextStyle: emojiTextStyle,
        emojiViewConfig: EmojiViewConfig(
          backgroundColor: backgroundColor ?? Colors.white,
        ),
        swapCategoryAndBottomBar: swapCategoryAndBottomBar ?? true,
        skinToneConfig: const SkinToneConfig(),
        categoryViewConfig: CategoryViewConfig(
          backgroundColor: backgroundColor ?? Colors.white,
          dividerColor: dividerColor ?? Colors.white,
          indicatorColor: indicatorColor ?? Colors.blueAccent,
          iconColorSelected: iconColorSelected ?? Colors.black,
          iconColor: iconColor ?? Colors.grey,
          customCategoryView: (
              config,
              state,
              tabController,
              pageController,
              ) {
            return WhatsAppCategoryView(
              config,
              state,
              tabController,
              pageController,
            );
          },
          categoryIcons: const CategoryIcons(
            recentIcon: Icons.access_time_outlined,
            smileyIcon: Icons.emoji_emotions_outlined,
            animalIcon: Icons.cruelty_free_outlined,
            foodIcon: Icons.coffee_outlined,
            activityIcon: Icons.sports_soccer_outlined,
            travelIcon: Icons.directions_car_filled_outlined,
            objectIcon: Icons.lightbulb_outline,
            symbolIcon: Icons.emoji_symbols_outlined,
            flagIcon: Icons.flag_outlined,
          ),
        ),
        bottomActionBarConfig: BottomActionBarConfig(
          backgroundColor: backgroundColor ?? Colors.white,
          buttonColor: buttonColor ?? Colors.white,
          buttonIconColor: buttonIconColor ?? Colors.grey,
        ),
        searchViewConfig: SearchViewConfig(
          backgroundColor: backgroundColor ?? Colors.white,
          customSearchView: (
              config,
              state,
              showEmojiView,
              ) {
            return WhatsAppSearchView(
              config,
              state,
              showEmojiView,
            );
          },
        ),
      ),
    );
  }
}


/// Customized Whatsapp category view
class WhatsAppCategoryView extends CategoryView {
  const WhatsAppCategoryView(
      super.config,
      super.state,
      super.tabController,
      super.pageController, {
        super.key,
      });

  @override
  WhatsAppCategoryViewState createState() => WhatsAppCategoryViewState();
}

class WhatsAppCategoryViewState extends State<WhatsAppCategoryView>
    with SkinToneOverlayStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.config.categoryViewConfig.backgroundColor,
      child: Row(
        children: [
          Expanded(
            child: WhatsAppTabBar(
              widget.config,
              widget.tabController,
              widget.pageController,
              widget.state.categoryEmoji,
              closeSkinToneOverlay,
            ),
          ),
          // _buildExtraTab(widget.config.categoryViewConfig.extraTab),
        ],
      ),
    );
  }

// Widget _buildExtraTab(extraTab) {
//   if (extraTab == CategoryExtraTab.BACKSPACE) {
//     return BackspaceButton(
//       widget.config,
//       widget.state.onBackspacePressed,
//       widget.state.onBackspaceLongPressed,
//       widget.config.categoryViewConfig.backspaceColor,
//     );
//   } else if (extraTab == CategoryExtraTab.SEARCH) {
//     return SearchButton(
//       widget.config,
//       widget.state.,
//       widget.config.categoryViewConfig.iconColor,
//     );
//   } else {
//     return const SizedBox.shrink();
//   }
// }
}

class WhatsAppTabBar extends StatelessWidget {
  const WhatsAppTabBar(
      this.config,
      this.tabController,
      this.pageController,
      this.categoryEmojis,
      this.closeSkinToneOverlay, {
        super.key,
      });

  final Config config;

  final TabController tabController;

  final PageController pageController;

  final List<CategoryEmoji> categoryEmojis;

  final VoidCallback closeSkinToneOverlay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: config.categoryViewConfig.tabBarHeight,
      child: TabBar(
        labelColor: config.categoryViewConfig.iconColorSelected,
        indicatorColor: config.categoryViewConfig.indicatorColor,
        unselectedLabelColor: config.categoryViewConfig.iconColor,
        dividerColor: config.categoryViewConfig.dividerColor,
        controller: tabController,
        labelPadding: const EdgeInsets.only(top: 1.0),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black12,
        ),
        onTap: (index) {
          closeSkinToneOverlay();
          pageController.jumpToPage(index);
        },
        tabs: categoryEmojis
            .asMap()
            .entries
            .map<Widget>(
                (item) => _buildCategory(item.key, item.value.category))
            .toList(),
      ),
    );
  }

  Widget _buildCategory(int index, Category category) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(
          getIconForCategory(
            config.categoryViewConfig.categoryIcons,
            category,
          ),
          size: 20,
        ),
      ),
    );
  }
}

/// Custom Whatsapp Search view implementation
class WhatsAppSearchView extends SearchView {
  const WhatsAppSearchView(super.config, super.state, super.showEmojiView,
      {super.key});

  @override
  WhatsAppSearchViewState createState() => WhatsAppSearchViewState();
}

class WhatsAppSearchViewState extends SearchViewState {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final emojiSize =
      widget.config.emojiViewConfig.getEmojiSize(constraints.maxWidth);
      final emojiBoxSize =
      widget.config.emojiViewConfig.getEmojiBoxSize(constraints.maxWidth);
      return Container(
        color: widget.config.searchViewConfig.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: emojiBoxSize + 8.0,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                scrollDirection: Axis.horizontal,
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return buildEmoji(
                    results[index],
                    emojiSize,
                    emojiBoxSize,
                  );
                },
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: widget.showEmojiView,
                  color: widget.config.searchViewConfig.buttonIconColor,
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 20.0,
                  ),
                ),
                Expanded(
                  child: TextField(
                    onChanged: onTextInputChanged,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.config.searchViewConfig.hintText,
                      hintStyle: const TextStyle(
                        color: Pallets.grey400,
                        fontWeight: FontWeight.normal,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
