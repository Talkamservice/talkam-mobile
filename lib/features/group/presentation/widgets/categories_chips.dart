import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';

class CategoriesChips extends StatefulWidget {
  const CategoriesChips({super.key, required this.onSelected});

  final Function(PostCategory?) onSelected;

  @override
  State<CategoriesChips> createState() => _CategoriesChipsState();
}

class _CategoriesChipsState extends State<CategoriesChips> {
  final List<String> categories = [
    "Anxiety",
    "Depression",
    "Relationships",
    "Work",
  ];

  String? _selectedTile;
  
  @override
  void initState() {
    _selectedTile = categories[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: SizedBox(
        width: double.infinity,
        height: 33,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder: (_, __) => 14.horizontalSpace,
          itemBuilder: (_, int index) {
            return InkWell(
              onTap: () {
                selectCategory(index);
              },
              child: _CategoryTile(
                tile: categories[index],
                key: Key(categories[index]),
                isSelected: _selectedTile == categories[index],
              ),
            );
          },
        ),
      ),
    );
  }

  void selectCategory(int index) {
    if (_selectedTile == categories[index]) {
      _selectedTile = null;
      widget.onSelected(null);
    } else {
      _selectedTile = categories[index];
      widget.onSelected(null);
    }
    setState(() {});
  }
}

class _CategoryTile extends StatelessWidget {
  final String tile;
  final bool isSelected;

  const _CategoryTile({
    super.key,
    required this.tile,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: isSelected ? Pallets.tabBarBlue.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(36.0),
        border: Border.all(
          color: isSelected ? Pallets.tabBarBlue : const Color(0xFFD2D2D2),
        ),
      ),
      child: Center(
        child: TextView(
          text: tile,
          fontWeight: FontWeight.w500,
          color: isSelected ? Pallets.tabBarBlue : Pallets.boldBlackV2,
        ),
      ),
    );
  }
}
