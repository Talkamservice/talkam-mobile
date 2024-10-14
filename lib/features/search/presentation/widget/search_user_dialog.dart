import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/search/presentation/blocs/search/search_cubit.dart';
import 'package:talkam/gen/assets.gen.dart';

class SearchUserDialog extends StatelessWidget {
  const SearchUserDialog({super.key, required this.onUserSelected});

  final Function(String) onUserSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      constraints: const BoxConstraints(maxHeight: 200, minWidth: 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Pallets.primary.withOpacity(0.1,),border: Border.all(color: Pallets.primary)),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: BlocConsumer<SearchCubit, SearchState>(
              listener: (context, state) {},
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => 0.verticalSpace,

                  searchUserLoading: () {
                    return Center(
                      child: SizedBox(height: 100, child: CustomDialogs.getLoading(size: 40)),
                    );
                  },
                  // searchUserError: (error) {
                  //   Center(child: TextView(text: "Something went wront while trying to get users"),)
                  // },

                  searchUserSuccess: (searchResults) {
                    if (searchResults.isEmpty) {

                      return const Center(child: TextView(text: "No user found"));
                    }
                    return ListView.builder(
                      itemCount: searchResults.length,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          String username = searchResults[index].username;
                          onUserSelected(username); // Use the callback to notify parent widget
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            children: [
                              ImageWidget(
                                imageUrl: searchResults[index].avatar ?? Assets.images.svgs.user,
                                size: 50,
                                shape: BoxShape.circle,
                              ),
                              3.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    text:
                                        "@${(searchResults[index].name == null||searchResults[index].name.toString().isEmpty) ? searchResults[index]
                                            .username : searchResults[index].username}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  // 3.verticalSpace,
                                  // TextView(
                                  //   text: searchResults[index].email,
                                  //   fontSize: 13,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
