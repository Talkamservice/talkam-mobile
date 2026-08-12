import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/home/presentation/widgets/app_drawer.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    this.searchQuery = '',
  });

  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    // Interest topics are prefetched once on HomeScreen launch, so this just
    // reads the shared PostBloc's state — no fetch dispatched here, so
    // opening the drawer never re-triggers a loading flash.
    //
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
        BlocBuilder<PostBloc, PostState>(
          bloc: injector.get<PostBloc>(),
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              getInterestTopicsFailure: (error) => AppErrorWidget(
                onTap: () {
                  injector
                      .get<PostBloc>()
                      .add(const PostEvent.getInterestTopics());
                },
              ),
              getInterestTopicsSuccess: (response) {
                final source =
                    response.data.isEmpty ? MockHomeData.groups : response.data;
                final categories = searchQuery.isEmpty
                    ? source
                    : source
                        .where((category) => category.name
                            .toString()
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()))
                        .toList();

                if (categories.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Center(
                      child: TextView(
                        text: searchQuery.isEmpty
                            ? "There are no categories yet"
                            : "No categories match \"$searchQuery\"",
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
            );
          },
        ),
      ],
    );
  }
}
