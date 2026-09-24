import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/home/presentation/widgets/app_drawer.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    super.key,
    this.searchQuery = '',
  });

  final String searchQuery;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  static const _kInitialVisibleCount = 3;
  static const _kShowMoreIncrement = 10;

  int _visibleCount = _kInitialVisibleCount;

  @override
  void didUpdateWidget(covariant CategoryList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // A new search collapses back to the default 3 rather than keeping
    // whatever "Show more" count was reached for the previous query.
    if (oldWidget.searchQuery != widget.searchQuery) {
      setState(() => _visibleCount = _kInitialVisibleCount);
    }
  }

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
                final source = response.data;
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

                final visibleCategories =
                    categories.take(_visibleCount).toList();
                final hasMore = _visibleCount < categories.length;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      itemCount: visibleCategories.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: NavCategoryItem(
                          category: visibleCategories[index],
                          onTap: () {
                            context.read<DrawerCubit>().switchView(
                                DrawerView.subCategory,
                                subCategory: visibleCategories[index]);
                          },
                        ),
                      ),
                    ),
                    if (hasMore)
                      InkWell(
                        onTap: () => setState(
                            () => _visibleCount += _kShowMoreIncrement),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 8.w),
                          child: TextView(
                            text: "Show more",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Pallets.blueBubbleColor,
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
