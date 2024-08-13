import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/presentation/screens/create_post_screen.dart';
import 'package:talkam/features/post/presentation/screens/post_details_screen.dart';
import 'package:talkam/features/post/presentation/widgets/rules_button.dart';
import 'package:talkam/features/post/presentation/widgets/select_category_dropdown_button.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class CreatePostHeader extends StatefulWidget {
  const CreatePostHeader({
    super.key,
    required this.onPostTypeChanged,
    required this.onIsAnonymousChanged,
    required this.onCategorySelected,
    required this.onGroupSelected,
  });

  final Function(PostType type) onPostTypeChanged;
  final Function(bool isAnonymous) onIsAnonymousChanged;
  final Function(PostCategory category) onCategorySelected;
  final Function(TalkamGroup group) onGroupSelected;

  @override
  State<CreatePostHeader> createState() => _CreatePostHeaderState();
}

class _CreatePostHeaderState extends State<CreatePostHeader> {
  PostType _postType = PostType.text;
  bool _isAnonymous = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.cardColor,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectCategoryDropDownButton(
                onCategorySelected: widget.onCategorySelected,
                onGroupSelected: widget.onGroupSelected,
              ),
              const RulesButton(),
            ],
          ),
          const Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PostTypeButton(
                      icon: Assets.images.svgs.text,
                      postType: PostType.text,
                      isSelected: _postType == PostType.text,
                      onTap: () => _updatePostType(PostType.text),
                    ),
                    PostTypeButton(
                      icon: Assets.images.svgs.image03,
                      postType: PostType.file,
                      isSelected: _postType == PostType.file,
                      onTap: () => _updatePostType(PostType.file),
                    ),
                    PostTypeButton(
                      icon: Assets.images.svgs.list,
                      postType: PostType.poll,
                      isSelected: _postType == PostType.poll,
                      onTap: () => _updatePostType(PostType.poll),
                    ),
                    const VerticalDivider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
              AnonymousSwitcher(
                value: _isAnonymous,
                onChanged: (value) {
                  setState(() {
                    _isAnonymous = value;
                  });

                  widget.onIsAnonymousChanged(_isAnonymous);
                },
              ),
            ],
          ),
          const Divider(thickness: 1),
        ],
      ),
    );
  }

  void _updatePostType(PostType postType) {
    setState(() {
      _postType = postType;
    });
    widget.onPostTypeChanged(_postType);
  }
}

class PostTypeButton extends StatelessWidget {
  const PostTypeButton({
    super.key,
    required this.icon,
    required this.postType,
    required this.isSelected,
    required this.onTap,
  });

  final String icon;
  final PostType postType;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          const VerticalDivider(
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9.0.h, horizontal: 16.w),
            child: ImageWidget(
              color:
                  isSelected ? context.colorScheme.onSurface : Pallets.grey60,
              imageUrl: icon,
            ),
          ),
        ],
      ),
    );
  }
}
