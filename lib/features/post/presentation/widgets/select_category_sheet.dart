import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class SelectCategorySheet extends StatefulWidget {
  const SelectCategorySheet({super.key});

  @override
  State<SelectCategorySheet> createState() => _SelectCategorySheetState();
}

class _SelectCategorySheetState extends State<SelectCategorySheet> {
  @override
  void initState() {
    postBloc.add(const PostEvent.getCategories());
    super.initState();
  }

  final postBloc = PostBloc(injector.get());
  var filteredList = <PostCategory>[];
  var allLists = <PostCategory>[];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7.sh,
      color: context.colorScheme.surface,
      padding: const EdgeInsets.all(16),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedFormField(
            hint: "Search ",
            radius: 100.r,
            onChange: (d) {
              filterList(d);
            },
            preffix: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ImageWidget(imageUrl: Assets.images.svgs.searchMd),
            ),
          ),
          Expanded(
            child: BlocConsumer<PostBloc, PostState>(
              bloc: postBloc,
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () => null,
                  getCategoriesSuccess: (response) {
                    allLists = response.data;
                    filteredList = response.data;
                    setState(() {});
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => 0.verticalSpace,
                  getCategoriesFailure: (error) => AppErrorWidget(
                    onTap: () {
                      postBloc.add(const PostEvent.getCategories());
                    },
                  ),
                  getCategoriesLoading: () => CustomDialogs.getLoading(size: 50),
                  getCategoriesSuccess: (response) {
                    if (filteredList.isEmpty) {
                      return const Center(
                        child: TextView(text: "There are no categories yet"),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredList.length,
                      shrinkWrap: true,
                      // physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CategoryItem(
                          postCategory: filteredList[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void filterList(String query) {
    if (query.isEmpty) {
      filteredList = allLists;
    } else {
      filteredList = allLists
          .where(
            (element) => element.name.toLowerCase().contains(query),
          )
          .toList();
    }

    setState(() {});
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.postCategory});

  final PostCategory postCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop(postCategory);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            ImageWidget(
              imageUrl: postCategory.iconImage ?? Assets.images.png.dating.path,
              size: 30,
            ),
            8.horizontalSpace,
            Expanded(
              child: TextView(
                text: postCategory.name,
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
