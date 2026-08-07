import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/home/presentation/widgets/app_drawer.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';

class CategoryList extends StatefulWidget {
  CategoryList({
    super.key,
    this.searchQuery = '',
  });

  final String searchQuery;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
    injector.get<PostBloc>().add(const PostEvent.getCategories(refresh: false));
    super.initState();
  }

  final postBloc = injector.get<PostBloc>();

  @override
  Widget build(BuildContext context) {
    // No scrolling of its own — this is embedded inside the drawer's single
    // outer SingleChildScrollView, which handles scrolling for everything
    // from "Following" down.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        24.verticalSpace,
        const TextView(
          text: "Categories",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        12.verticalSpace,
        BlocConsumer<PostBloc, PostState>(
          bloc: injector.get<PostBloc>(),
          listener: (context, state) {},
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                final response = injector.get<PostBloc>();
                final source = response.categories.isEmpty
                    ? MockHomeData.groups // It contains mock categories
                    : response.categories;
                final categories = widget.searchQuery.isEmpty
                    ? source
                    : source
                        .where((category) => category.name
                            .toString()
                            .toLowerCase()
                            .contains(widget.searchQuery.toLowerCase()))
                        .toList();

                if (categories.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Center(
                      child: TextView(
                        text: widget.searchQuery.isEmpty
                            ? "There are no categories yet"
                            : "No categories match \"${widget.searchQuery}\"",
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: NavCategoryItem(
                      category: categories[index],
                      onTap: () {
                        context.read<DrawerCubit>().switchView(
                            DrawerView.subCategory,
                            subCategory: categories[index]);
                      },
                    ),
                  ),
                );
              },
              getCategoriesFailure: (error) => AppErrorWidget(
                onTap: () {
                  injector
                      .get<PostBloc>()
                      .add(const PostEvent.getCategories(refresh: false));
                },
              ),
              getCategoriesLoading: () => Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Center(child: CustomDialogs.getLoading(size: 50)),
              ),
            );
          },
        ),
      ],
    );
  }
}
