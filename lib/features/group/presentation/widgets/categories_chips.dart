import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final _postBloc = PostBloc(injector.get());
  PostCategory? _selected;

  @override
  void initState() {
    _postBloc.add(const PostEvent.getInterestTopics());
    super.initState();
  }

  @override
  void dispose() {
    _postBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      bloc: _postBloc,
      builder: (context, state) {
        final categories = state.maybeWhen(
          orElse: () => const <PostCategory>[],
          getInterestTopicsSuccess: (response) => response.data,
        );

        if (categories.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: SizedBox(
            width: double.infinity,
            height: 33,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => 14.horizontalSpace,
              itemBuilder: (_, int index) {
                final category = categories[index];
                return InkWell(
                  onTap: () => _selectCategory(category),
                  child: _CategoryTile(
                    tile: category.name.toString(),
                    key: Key(category.id.toString()),
                    isSelected: _selected?.id == category.id,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _selectCategory(PostCategory category) {
    setState(() {
      _selected = _selected?.id == category.id ? null : category;
    });
    widget.onSelected(_selected);
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
      height: 25.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: isSelected
            ? Pallets.tabBarBlue.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(36.0),
        border: Border.all(
          color: isSelected ? Pallets.tabBarBlue : const Color(0xFFD2D2D2),
        ),
      ),
      child: Center(
        child: TextView(
          text: tile,
          fontWeight: FontWeight.w500,
          color: isSelected ? Pallets.tabBarBlue : Pallets.boldBlackV2,
        ),
      ),
    );
  }
}
