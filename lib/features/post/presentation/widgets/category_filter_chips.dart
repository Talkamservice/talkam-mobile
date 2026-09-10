import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';

/// Horizontally-scrolling category pills, used above a post feed to filter
/// it by category — purely a selector, the caller owns refetching the feed
/// when [onSelected] fires. No client-side "All"/catch-all pill: the
/// category list is entirely backend-driven (`GET /user/post-categories`),
/// and tapping the currently-selected pill deselects it, going back to the
/// unfiltered feed the same way the group-creation category picker does.
class CategoryFilterChips extends StatefulWidget {
  const CategoryFilterChips({
    super.key,
    required this.categories,
    required this.onSelected,
  });

  final List<PostCategory> categories;

  /// Called with `null` when the feed should be unfiltered (nothing
  /// selected, or the selected pill was tapped again to deselect it).
  final ValueChanged<String?> onSelected;

  @override
  State<CategoryFilterChips> createState() => _CategoryFilterChipsState();
}

class _CategoryFilterChipsState extends State<CategoryFilterChips> {
  String? _selectedId;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      height: 50.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: widget.categories.length,
          separatorBuilder: (context, index) => 8.horizontalSpace,
          itemBuilder: (context, index) {
            final category = widget.categories[index];
            final id = category.id.toString();
            return _Chip(
              label: category.name.toString(),
              selected: _selectedId == id,
              onTap: () => _select(id),
            );
          },
        ),
      ),
    );
  }

  void _select(String id) {
    setState(() => _selectedId = _selectedId == id ? null : id);
    widget.onSelected(_selectedId);
  }
}

class _Chip extends StatelessWidget {
  const _Chip(
      {required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? Pallets.blueBubbleColor.withValues(alpha: 0.08)
              : context.colorScheme.surface,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: selected ? Pallets.blueBubbleColor : Pallets.grey90,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: TextView(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: selected ? Pallets.blueBubbleColor : Pallets.boldBlackV2,
        ),
      ),
    );
  }
}
