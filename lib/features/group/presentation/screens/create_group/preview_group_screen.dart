import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/data/models/create_group_payload.dart';
import 'package:talkam/features/group/dormain/model/group_overview_data.dart';
import 'package:talkam/features/group/presentation/blocs/create_group_cubit/create_group_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/tabs/preview_about_tab.dart';
import 'package:talkam/features/group/presentation/tabs/preview_members_tab.dart';
import 'package:talkam/features/group/presentation/tabs/preview_rules_tab.dart';
import 'package:talkam/features/group/presentation/widgets/preview_group_header.dart';
import 'package:talkam/features/group/presentation/widgets/preview_overview_section.dart';
import 'package:talkam/features/home/presentation/screens/home_screen.dart';
import 'package:talkam/gen/assets.gen.dart';

class PreviewGroupScreenParam {
  final CreateGroupPayload payload;
  final bool isEdit;
  final String? groupId;

  PreviewGroupScreenParam(this.payload, this.isEdit, {this.groupId});
}

class PreviewGroupScreen extends StatefulWidget {
  const PreviewGroupScreen({super.key, required this.payload});

  final PreviewGroupScreenParam payload;

  @override
  State<PreviewGroupScreen> createState() => _PreviewGroupScreenState();
}

class _PreviewGroupScreenState extends State<PreviewGroupScreen> {
  final tabItems = [
    TabItemModel(imagePath: Assets.images.svgs.icfeatured, tittle: "Rules"),
    TabItemModel(imagePath: Assets.images.svgs.icTrending, tittle: "Members"),
    TabItemModel(imagePath: Assets.images.svgs.icTrending, tittle: "About"),
  ];
  int selecteIndex = 0;

  final PageController _pageController = PageController();

  final createGroupBloc = CreateGroupCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      PreviewGroupHeader(
                        banner: widget.payload.payload.image,
                        isEdit: widget.payload.isEdit,
                        onSubmitted: () {
                          if (widget.payload.isEdit) {
                            createGroupBloc.updateGroup(widget.payload.groupId??'1',
                                injector.get<CreateGroupCubit>().groupPayload);
                          } else {
                            createGroupBloc.createGroup(
                                injector.get<CreateGroupCubit>().groupPayload);
                          }
                        },
                      ),
                      12.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: PreviewGroupOverViewSection(
                          showAbout: false,
                          data: widget.payload.payload.toGroupOverView(),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                )
              ];
            },
            body: BlocConsumer<CreateGroupCubit, CreateGroupState>(
              bloc: createGroupBloc,
              listener: (context, state) {
                state.maybeWhen(

                  orElse: () => null,
                  createGroupLoading: () => CustomDialogs.showLoading(context),
                  createGroupSuccess: (response) {

                    injector.get<GroupsCubit>().getGroups();
                    context.pushNamed(PageUrl.createGroupSuccessScreen,extra: response).then(
                      (value) {
                        context.goNamed(PageUrl.groupsInfoScreen,extra: response.id);

                      },);

                  },
                  createGroupFailure: (error) {
                    context.pop();
                    CustomDialogs.error(error);
                  },
                );
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Container(
                      color: context.colorScheme.surface,
                      width: 1.sw,
                      child: Center(
                        child: TabBar(
                            tabAlignment: TabAlignment.center,
                            indicatorColor: context.colorScheme.primary,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorWeight: 3,
                            onTap: (value) {
                              selecteIndex = value;
                              _pageController.jumpToPage(value);
                              setState(() {});
                            },
                            tabs: List.generate(
                              tabItems.length,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Tab(
                                  child: Row(
                                    children: [
                                      TextView(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        text: tabItems[index].tittle,
                                        color: selecteIndex == index
                                            ? context.colorScheme.onSurface
                                            : Pallets.grey60,
                                        // fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ).toList()),
                      ),
                    ),
                    Container(
                      color: Pallets.grey90,
                      height: 1,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (int index) {
                            // setState(() {});
                          },
                          children: [
                            PreviewGroupRulesTab(
                                isPreview: true, data: widget.payload.payload),
                            PreviewGroupMembersTab(
                              data: widget.payload.payload.toGroupMembersData(),
                            ),
                            PreviewGroupsAboutTab(
                              data: widget.payload.payload.toGroupAboutData(),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            )),
      ),
    );
  }
}

ButtonStyle outlinedButtonStyle() {
  return TextButton.styleFrom(
      backgroundColor: Pallets.borderGrey.withOpacity(0.1),
      shape: const StadiumBorder(side: BorderSide(color: Pallets.borderGrey)),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10));
}
