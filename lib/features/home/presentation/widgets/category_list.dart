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
    return NestedScrollView(
        floatHeaderSlivers: true,
        clipBehavior: Clip.none,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        return Center(
                          child: TextView(
                            text: widget.searchQuery.isEmpty
                                ? "There are no categories yet"
                                : "No categories match \"${widget.searchQuery}\"",
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: NavCategoryItem(
                            category: categories[index],
                            onTap: () {
                              context.read<DrawerCubit>().switchView(DrawerView.subCategory, subCategory: categories[index]);
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
                    getCategoriesLoading: () =>
                        CustomDialogs.getLoading(size: 50),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
