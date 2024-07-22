import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/home/presentation/widgets/app_drawer.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';

class CategoriesList extends StatefulWidget {
  CategoriesList({
    super.key,
  });

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  void initState() {
    postBloc.add(const PostEvent.getCategories());
    super.initState();
  }

  final postBloc = PostBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        floatHeaderSlivers: true,
        clipBehavior: Clip.none,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // SliverToBoxAdapter(
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           const Expanded(
            //             child: TextView(
            //               text: "Following",
            //               fontSize: 16,
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //           IconButton(
            //               onPressed: () {
            //                 Navigator.pop(context);
            //                 // context.read<DrawerCubit>().closeDrawer();
            //                 // context.read<DrawerCubit>().closeDrawer();
            //               },
            //               icon: Icon(
            //                   color: context.colorScheme.onSurface,
            //                   Icons.close))
            //         ],
            //       ),
            //       8.verticalSpace,
            //       Builder(builder: (context) {
            //         return ListView.builder(
            //           itemCount: 3,
            //           shrinkWrap: true,
            //           // physics: const BouncingScrollPhysics(),
            //           itemBuilder: (context, index) => const NavCategoryItem(),
            //         );
            //       }),
            //       24.verticalSpace,
            //       const Divider(
            //         thickness: 1,
            //       ),
            //     ],
            //   ),
            // )
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            24.verticalSpace,
            const TextView(
              text: "Categories",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            12.verticalSpace,
            Expanded(
              child: BlocConsumer<PostBloc, PostState>(
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
                    getCategoriesLoading: () =>
                        CustomDialogs.getLoading(size: 50),
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
            ),
          ],
        ));
  }
}
