import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/home/presentation/widgets/subcategory_list.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/gen/assets.gen.dart';

import 'category_list.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints:  BoxConstraints(maxWidth: 1.w),
      width: 280.w,
      decoration: BoxDecoration(color: context.theme.cardColor),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BlocConsumer<DrawerCubit, DrawerState>(
                  buildWhen: _buildWhen,
                  listener: (context, state) {},
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => CategoriesList(),
                      categoryView: () => CategoriesList(),
                      subCategoryView: (subCategory) => SubcategoryList(
                        category: subCategory,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
                child: Row(
                  children: [
                    ImageWidget(
                      imageUrl: Assets.images.png.add.path,
                      size: 30,
                      fit: BoxFit.cover,
                    ),
                    8.horizontalSpace,
                    const Expanded(
                        child: TextView(
                      text: "Submit a suggestion",
                      fontSize: 16,
                    )),
                    8.horizontalSpace,
                    ImageWidget(imageUrl: Assets.images.svgs.chevronRight)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _buildWhen(DrawerState previous, DrawerState current) {
    return current.maybeWhen(
      categoryView: () => true,
      subCategoryView: (subCategory) => true,
      orElse: () => false,
    );
  }
}

class NavCategoryItem extends StatelessWidget {
  const NavCategoryItem(
      {super.key, required this.category, required this.onTap});

  final PostCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ImageWidget(
              imageUrl: category.iconImage ?? Assets.images.png.sports.path,
              size: 26,
            ),
            8.horizontalSpace,
            Expanded(
              child: TextView(
                text: category.name,
                fontSize: 16,
              ),
            ),
            8.horizontalSpace,
            ImageWidget(imageUrl: Assets.images.svgs.chevronRight)
          ],
        ),
      ),
    );
  }
}
