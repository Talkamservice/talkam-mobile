import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/presentation/widgets/select_category_sheet.dart';
import 'package:talkam/gen/assets.gen.dart';

class SelectCategoryDropDownButton extends StatefulWidget {
  const SelectCategoryDropDownButton(
      {super.key, required this.onCategorySelected});

  final Function(PostCategory) onCategorySelected;

  @override
  State<SelectCategoryDropDownButton> createState() =>
      _SelectCategoryDropDownButtonState();
}

class _SelectCategoryDropDownButtonState
    extends State<SelectCategoryDropDownButton> {
  PostCategory? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Pallets.borderGrey.withOpacity(0.2),
            shape: const StadiumBorder(
                side: BorderSide(color: Pallets.borderGrey)),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10)),
        onPressed: () {
          selecteCategory(context);
        },
        child: Row(
          children: [
            ImageWidget(
                imageUrl: selectedCategory?.iconImage ??
                    Assets.images.png.sports.path),
            10.horizontalSpace,
            TextView(
              text: selectedCategory?.name ?? "Select category or group",
              fontSize: 14,
              color: context.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            14.horizontalSpace,
            const Icon(color: Pallets.grey, Icons.keyboard_arrow_down_rounded)
          ],
        ));
  }

  Future<void> selecteCategory(BuildContext context) async {
    selectedCategory = await CustomDialogs.showBottomSheet(
        context, const SelectCategorySheet());

    if (selectedCategory != null) {
      widget.onCategorySelected(selectedCategory!);
      setState(() {});
    }
  }
}
