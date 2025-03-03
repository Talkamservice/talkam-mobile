import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/presentation/widgets/category_groups_sheet.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class SelectCategoryDropDownButton extends StatefulWidget {
  const SelectCategoryDropDownButton(
      {super.key,
      required this.onCategorySelected,
      required this.onGroupSelected});

  final Function(PostCategory) onCategorySelected;
  final Function(TalkamGroup) onGroupSelected;

  @override
  State<SelectCategoryDropDownButton> createState() =>
      _SelectCategoryDropDownButtonState();
}

class _SelectCategoryDropDownButtonState
    extends State<SelectCategoryDropDownButton> {
  PostCategory? selectedCategory;
  String? name;
  String? iconImage;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Pallets.borderGrey.withOpacity(0.2),
            shape: const StadiumBorder(
                side: BorderSide(color: Pallets.borderGrey)),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10)),
        onPressed: () {
          selectCategory(context);
        },
        child: Row(
          children: [
            ImageWidget(imageUrl: iconImage ?? Assets.images.png.sports.path),
            10.horizontalSpace,
            TextView(
              text: name ?? "Select sub-category or group",
              fontSize: 13,
              color: context.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            TextView(
              text: " *",
              fontSize: 14.sp,
              color: Pallets.red,
              fontWeight: FontWeight.w600,
            ),
            4.horizontalSpace,
            const Icon(

                color: Pallets.grey, Icons.keyboard_arrow_down_rounded)
          ],
        ));
  }

  Future<void> selectCategory(BuildContext context) async {
    var categoryorGroup = await CustomDialogs.showBottomSheet(
        context, const CategoryGroupsSheet());

    logger.w(categoryorGroup);

    if (categoryorGroup is PostCategory) {
      selectedCategory = categoryorGroup;
      name = selectedCategory?.name;
      iconImage = selectedCategory?.iconImage;
    } else if (categoryorGroup is TalkamGroup) {
      selectedCategory = categoryorGroup.category;
      name = categoryorGroup.name;
      iconImage = selectedCategory?.iconImage;
      widget.onGroupSelected(categoryorGroup);
      setState(() {});
    }

    if (selectedCategory != null) {
      widget.onCategorySelected(selectedCategory!);
      setState(() {});
    }
  }
}
