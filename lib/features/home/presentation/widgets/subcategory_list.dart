import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

import 'app_drawer.dart';

class SubcategoryList extends StatefulWidget {
  const SubcategoryList({super.key, required this.category});

  final PostCategory category;

  @override
  State<SubcategoryList> createState() => _SubcategoryListState();
}

class _SubcategoryListState extends State<SubcategoryList> {
  @override
  void initState() {
    logger.w(widget.category.id);
    postBloc.add(
        PostEvent.getCategories(categoryId: widget.category.id.toString()));
    super.initState();
  }

  final postBloc = PostBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          10.verticalSpace,
          InkWell(
            onTap: () {
              context.read<DrawerCubit>().switchView(DrawerView.category,
                  subCategory: widget.category);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  IgnorePointer(
                    child: ImageWidget(
                      imageUrl: Assets.images.png.back1.path,
                      size: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: TextView(
                      text: widget.category.name,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(color: context.colorScheme.onSurface, Icons.close))
                ],
              ),
            ),
          ),
          8.verticalSpace,
          BlocConsumer<PostBloc, PostState>(
            bloc: postBloc,
            listener: (context, state) {},
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => 0.verticalSpace,
                getCategoriesFailure: (error) => AppPromptWidget(
                  onTap: () {
                    postBloc.add(const PostEvent.getCategories());
                  },
                ),
                getCategoriesLoading: () => CustomDialogs.getLoading(size: 50),
                getCategoriesSuccess: (response) {
                  if (response.data.isEmpty) {
                    return const Center(
                      child: TextView(text: "There are no categories yet"),
                    );
                  }

                  return ListView.builder(
                    itemCount: response.data.length,
                    shrinkWrap: true,
                    // physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: NavCategoryItem(
                        category: response.data[index],
                        onTap: () {
                          context.read<DrawerCubit>().switchView(
                              DrawerView.subCategory,
                              subCategory: response.data[index]);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
