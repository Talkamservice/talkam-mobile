import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/presentation/widgets/rules_button.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class CategoriesScreenHeader extends StatefulWidget {
  const CategoriesScreenHeader({super.key, required this.category});

  final PostCategory category;

  @override
  State<CategoriesScreenHeader> createState() => _CategoriesScreenHeaderState();
}

class _CategoriesScreenHeaderState extends State<CategoriesScreenHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              child: Stack(
                children: [
                  ImageWidget(
                    imageUrl: widget.category.backgroundImage,
                    height: 210,
                    width: 1.sw,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 210.h,
                    padding: const EdgeInsets.all(16),
                    width: 1.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        40.verticalSpace,
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  context.pop();
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Pallets.white,
                                )),
                            const Spacer(),
                            FollowCategoryButton(category: widget.category),
                            17.horizontalSpace,
                            const Icon(
                              Icons.info_outline,
                              color: Pallets.white,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ImageWidget(
                          size: 50,
                          fit: BoxFit.contain,
                          imageUrl: widget.category.iconImage.toString()),
                      10.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: widget.category.name,
                              fontSize: 16,
                            ),
                            TextView(
                              text:
                                  "${widget.category.followersCount} Followers",
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ),
                      const RulesButton()
                    ],
                  ),
                  // 21.verticalSpace,
                  // Wrap(
                  //   spacing: 4,
                  //   runSpacing: 8,
                  //   children: List.generate(
                  //     widget.category.,
                  //     (index) => Container(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 10, vertical: 5),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(100.r),
                  //           border: Border.all(
                  //             width: 1,
                  //             color: Pallets.borderGrey,
                  //           )),
                  //       child: const TextView(text: "Sports"),
                  //     ),
                  //   ),
                  // ),
                  15.verticalSpace,
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class FollowCategoryButton extends StatefulWidget {
  FollowCategoryButton({
    super.key,
    required this.category,
  });

  final PostCategory category;

  @override
  State<FollowCategoryButton> createState() => _FollowCategoryButtonState();
}

class _FollowCategoryButtonState extends State<FollowCategoryButton> {
  final bloc = ProfileBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is UpdateInterestFailureState) {
          CustomDialogs.error(state.error);
        }
        if (state is UpdateInterestSuccessState) {
          widget.category.isFollowing = !widget.category.isFollowing;
        }
      },
      builder: (context, state) {
        return TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Pallets.primary,
                foregroundColor: Pallets.white,
                shape: const StadiumBorder()),
            onPressed: () {
              // var userInterests =
              //     injector.get<ProfileBloc>().appUser!.interests;
              bloc.add(UpdateInterestEvent(widget.category.id.toString()));
            },
            child: Builder(builder: (context) {
              if (state is UpdateInterestLoadingState) {
                return const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Pallets.white,
                  ),
                );
              }

              return Row(
                children: [
                  if (!widget.category.isFollowing)
                    const Icon(
                      Icons.add,
                      color: Pallets.white,
                    ),
                  if (!widget.category.isFollowing)

                  5.horizontalSpace,
                  TextView(
                      text:
                          widget.category.isFollowing ? "Unfollow" : "Follow"),
                ],
              );
              // CustomDialogs.success("");
            }));
      },
    );
  }
}
