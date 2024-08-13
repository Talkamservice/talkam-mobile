import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';

class CategoriesChips extends StatefulWidget {
  const CategoriesChips({super.key, required this.onSelected});

  final Function(PostCategory?) onSelected;

  @override
  State<CategoriesChips> createState() => _CategoriesChipsState();
}

class _CategoriesChipsState extends State<CategoriesChips> {
  final postBloc = injector.get<PostBloc>();

  PostCategory? _selectedTile;

  @override
  void initState() {
    if (injector.get<PostBloc>().categories.isEmpty) {
      injector.get<PostBloc>().add(const PostEvent.getCategories());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      bloc: injector.get<PostBloc>(),
      listener: (context, state) {},
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => 0.verticalSpace,
          getCategoriesFailure: (error) => AppPromptWidget(
            onTap: () {
              injector.get<PostBloc>().add(const PostEvent.getSubCategories());
            },
          ),
          getCategoriesLoading: () => 0.verticalSpace,
          getCategoriesSuccess: (response) {

            // if (response.data.isEmpty) {
            //   return const Center(
            //     child: TextView(text: "There are no categories yet"),
            //   );
            // }

            return Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  scrollDirection: Axis.horizontal,
                  itemCount: injector.get<PostBloc>().categories.length,
                  separatorBuilder: (_, __) => 14.horizontalSpace,
                  itemBuilder: (_, int index) {
                    return InkWell(
                      onTap: () {
                        selectCategory(index);
                      },
                      child: _CategoryTile(
                        tile: injector.get<PostBloc>().categories[index].name,
                        key: Key(
                            injector.get<PostBloc>().categories[index].name),
                        isSelected: _selectedTile ==
                            injector.get<PostBloc>().categories[index],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void selectCategory(int index) {
    if (_selectedTile == injector.get<PostBloc>().categories[index]) {
      _selectedTile = null;
      widget.onSelected(null);
    } else {
      _selectedTile = injector.get<PostBloc>().categories[index];
      widget.onSelected(_selectedTile);
    }
    setState(() {});
  }
}

class _CategoryTile extends StatelessWidget {
  final String tile;

  final bool isSelected;

  const _CategoryTile({
    super.key,
    required this.tile,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        color: isSelected ? Pallets.tabBarBlue : Colors.transparent,
        borderRadius: BorderRadius.circular(36.0),
        border: Border.all(
          color: isSelected ? Pallets.tabBarBlue : const Color(0xFFD2D2D2),
        ),
      ),
      child: Center(
        child: TextView(
          text: tile,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : Pallets.boldBlackV2,
        ),
      ),
    );
  }
}
