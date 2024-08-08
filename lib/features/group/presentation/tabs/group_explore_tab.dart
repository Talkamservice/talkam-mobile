import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupExploreTab extends StatefulWidget {
  const GroupExploreTab({super.key});

  @override
  State<GroupExploreTab> createState() => _GroupExploreRecentTabState();
}

class _GroupExploreRecentTabState extends State<GroupExploreTab> {
  final List<String> _groupCategories = ["Sports", "Technology", "Food & Drinks", "Health", "Politicians"];
  String _selectedTile = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallets.grey95,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                scrollDirection: Axis.horizontal,
                itemCount: _groupCategories.length,
                separatorBuilder: (_, __) => 14.horizontalSpace,
                itemBuilder: (_, int index) {
                  return _CategoryTile(
                    tile: _groupCategories[index],
                    key: Key(_groupCategories[index]),
                    isSelected: _selectedTile == _groupCategories[index],
                    onTap: (String tile) {
                      setState(() {
                        _selectedTile = tile;
                      });
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, right: 18.0, left: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "Suggested",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                const Icon(Icons.close, size: 28, color: Pallets.boldBlackV2)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 10),
            child: SizedBox(
              width: double.infinity,
              height: 100.h,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (_, __) => 14.horizontalSpace,
                itemBuilder: (_, int index) {
                  return _SuggestedTile(
                    onTap: () {

                    },
                  );
                },
              ),
            ),
          ),
          if (_selectedTile.isNotEmpty)
            for (int i = 0; i < 7; i++) ...[
              Container(
                height: 100,
                color: Colors.white,
                padding: EdgeInsets.only(left: 22.w, right: 14.w),
                child: Row(
                  children: [
                    ImageWidget(
                      imageUrl: Assets.images.jpegs.football.path,
                      width: 78.w,
                      height: 54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    14.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView(
                            text: "Arab Club Champions Cup",
                            fontWeight: FontWeight.w700,
                            color: Pallets.boldBlackV2,
                            fontSize: 14.sp,
                          ),
                          TextView(text: "328 Members"),
                        ],
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 27,
                      decoration: BoxDecoration(
                        color: Pallets.tabBarBlue,
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      child: const Center(
                        child: TextView(
                          text: "Join",
                          fontWeight: FontWeight.w700,
                          color: Pallets.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(height: 1.0, color: Pallets.borderGrey),
            ]
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String tile;
  final Function(String tile) onTap;
  final bool isSelected;

  const _CategoryTile({
    super.key,
    required this.tile,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(isSelected ? '' : tile),
      child: Container(
        height: 27.h,
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
          color: isSelected ? Pallets.tabBarBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(36.0),
          border: Border.all(
            color: isSelected ? Pallets.tabBarBlue : const Color(0xFFD2D2D2),
          ),
        ),
        child: Center(
          child: TextView(
            text: tile,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Pallets.boldBlackV2,
          ),
        ),
      ),
    );
  }
}

class _SuggestedTile extends StatelessWidget {

  final VoidCallback onTap;

  const _SuggestedTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 268.w,
      height: 100.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0), border: Border.all(color: Pallets.borderGrey, width: 1.5)),
      child: Row(
        children: [
          ImageWidget(
            imageUrl: Assets.images.jpegs.football.path,
            width: 93.w,
            height: 64.h,
            borderRadius: BorderRadius.circular(8.0),
          ),
          12.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                text: "Dating",
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                color: Pallets.boldBlackV2,
              ),
              TextView(
                text: "328 Members",
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Pallets.boldBlackV2,
              ),
              2.verticalSpace,
              Container(
                width: 70,
                height: 22,
                decoration: BoxDecoration(
                  color: Pallets.tabBarBlue,
                  borderRadius: BorderRadius.circular(22.0),
                ),
                child: const Center(
                  child: TextView(
                    text: "Join",
                    fontWeight: FontWeight.w700,
                    color: Pallets.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
