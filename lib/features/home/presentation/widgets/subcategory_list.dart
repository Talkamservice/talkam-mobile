import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
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
    postBloc.add(PostEvent.getCategories(categoryId: widget.category.id.toString(), mergeGroups: true));
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
              context.read<DrawerCubit>().switchView(DrawerView.category, subCategory: widget.category);
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
                getCategoriesFailure: (error) => AppErrorWidget(
                  onTap: () {
                    postBloc.add(const PostEvent.getCategories());
                  },
                ),
                getCategoriesLoading: () => SizedBox(height: 300, child: CustomDialogs.getLoading(size: 50)),
                getCategoriesSuccess: (response) {
                  if (response.data.isEmpty) {
                    return const SizedBox(
                      height: 300,
                      child: Center(
                        child: TextView(text: "There are no sub categories here"),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: response.data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: NavCategoryItem(
                        showArrow: false,
                        category: response.data[index],
                        onTap: () {
                          // logger.w(response.data[index].toJson());

                          if (response.data[index].type.toString().toLowerCase() == "category") {
                            context.pushNamed(PageUrl.categoriesScreen, extra: response.data[index]);
                          } else {
                            if (response.data[index].isSuspended ?? false) {
                              CustomDialogs.error("You have been suspended from this group");
                            } else if (!response.data[index].isPublic && !(response.data[index].isFollowing ?? false)) {
                              CustomDialogs.showInfoMessage(context, privateGroupViewText);
                            } else {
                              context.pushNamed(PageUrl.groupsInfoScreen, extra: response.data[index].id.toString());
                            }

                            // context.pushNamed(PageUrl.groupsInfoScreen, extra: response.data[index].id.toString());
                          }
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
