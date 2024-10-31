import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/dropdown_field_form.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/group/presentation/blocs/create_group_cubit/create_group_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/tabs/group_rules_tab.dart';
import 'package:talkam/features/group/presentation/widgets/create_group_header.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/presentation/widgets/select_category_sheet.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/features/subscription/presentation/widgets/talkam_subscription_prompt.dart';
import 'package:talkam/features/subscription/utils/subscription_helper.dart';
import 'package:talkam/gen/assets.gen.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key, this.group});

  final TalkamGroup? group;

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final groupNameController = TextEditingController();
  final categoryController = TextEditingController();
  final purposeController = TextEditingController();
  final groupInfoController = TextEditingController();
  final discoverabilityController = TextEditingController();
  PostCategory? selectedCategory;
  var discoverability = null;
  var formKey = GlobalKey<FormState>();

  // final createGroupBloc = CreateGroupCubit(injector.get());

  String? _bannerImage;

  final _createGroupBloc = CreateGroupCubit(injector.get());

  bool canCreate = SubscriptionHelper.canCreatePublicGroup;

  @override
  void initState() {
    _prefill();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Row(
              children: [
                const Spacer(),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Pallets.primary,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        foregroundColor: Pallets.white),
                    onPressed: () {
                      validateAndSubmit(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextView(text: widget.group != null ? "Save changes" : "Next"),
                        4.horizontalSpace,
                        const Icon(Icons.keyboard_arrow_right_rounded)
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
      body: BlocConsumer<CreateGroupCubit, CreateGroupState>(
        bloc: _createGroupBloc,
        listener: (context, state) {
          state.maybeWhen(
            orElse: () => null,
            updateGroupLoading: () => CustomDialogs.showLoading(context),
            updateGroupSuccess: (response) {
              context.pop();
              injector.get<GroupsCubit>().refreshGroups();
              injector.get<GroupsCubit>().getGroups();
              context.goNamed(
                PageUrl.groups,
              );
              // context
              //     .pushNamed(PageUrl.groupsInfoScreen,
              //         extra: response.id.toString())
              //     .then(
              //   (value) {
              //
              //   },
              // );
            },
            updateGroupFailure: (error) {
              context.pop();
              CustomDialogs.error(error);
            },
          );
        },
        builder: (context, state) {
          return Column(
            children: [
              CreateGroupHeader(
                banner: _bannerImage ?? widget.group?.image,
                onBannerUpdated: (String bannerImage) {
                  _bannerImage = bannerImage;
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        25.verticalSpace,
                        OutlinedFormField(
                            maxLine: 1,
                            radius: 8,
                            filled: true,
                            textCapitalization: TextCapitalization.sentences,
                            // padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                            placeHolder: "Name",
                            validator: RequiredValidator(errorText: "Field is required").call,
                            controller: groupNameController,
                            onChange: (d) {
                              setState(() {});
                            },
                            showRequiredAsterics: false,
                            hint: "Enter your group name"),
                        16.verticalSpace,
                        InkWell(
                          onTap: () {
                            selectCategory(context);
                          },
                          child: OutlinedFormField(
                              maxLine: 1,
                              radius: 8,
                              enabled: false,
                              filled: true,
                              textCapitalization: TextCapitalization.sentences,
                              preffix: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ImageWidget(imageUrl: selectedCategory?.iconImage ?? Assets.images.png.sports.path),
                              ),
                              suffix: const Icon(Icons.keyboard_arrow_down_rounded),
                              // padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                              placeHolder: "Category",
                              // validator:
                              //     RequiredValidator(errorText: "Field is required")
                              //         .call,
                              controller: categoryController,
                              onChange: (d) {
                                setState(() {});
                              },
                              hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              showRequiredAsterics: false,
                              hint: "Select category"),
                        ),
                        const TextView(
                          text: "All groups must be under a specific category.",
                        ),
                        16.verticalSpace,
                        OutlinedFormField(
                            maxLine: 10,
                            radius: 8,
                            minLine: 4,
                            filled: true,
                            maxLength: 100,
                            textCapitalization: TextCapitalization.sentences,

                            // padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                            placeHolder: "Group purpose",
                            validator: RequiredValidator(errorText: "Field is required").call,
                            controller: purposeController,
                            onChange: (d) {
                              setState(() {});
                            },
                            showRequiredAsterics: false,
                            hint: "A short description of your group"),
                        16.verticalSpace,
                        OutlinedFormField(
                            maxLine: 10,
                            radius: 8,
                            minLine: 4,
                            filled: true,
                            maxLength: 500,
                            textCapitalization: TextCapitalization.sentences,

                            // padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                            placeHolder: "Group information",
                            validator: RequiredValidator(errorText: "Field is required").call,
                            controller: groupInfoController,
                            onChange: (d) {
                              setState(() {});
                            },
                            showRequiredAsterics: false,
                            hint: "Any and all information for this group"),
                        16.verticalSpace,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircularBorder(child: ImageWidget(imageUrl: Assets.images.svgs.keylock)),
                            8.horizontalSpace,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomDropdownFieldButton<String>(
                                    label: "Discoverability",
                                    hint: "Public / Open to everyone",
                                    value: discoverability,
                                    onChanged: (p0) {
                                      logger.i(p0);


                                        discoverability = p0!;
                                        canCreate = SubscriptionHelper.canCreatePublicGroup;


                                      setState(() {});
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: "Opened",
                                        enabled: SubscriptionHelper.canCreatePublicGroup,
                                        child: SubscriptionHelper.isSubscribed
                                            ? const TextView(
                                                text: "Opened",
                                              )
                                            : IgnorePointer(

                                          ignoring: SubscriptionHelper.canCreatePublicGroup,
                                              child: GestureDetector(
                                                                                        onTap: () {
                                              if (!SubscriptionHelper.canCreatePublicGroup) {
                                                canCreate = false;
                                                setState(() {

                                                });
                                              }
                                                                                        },
                                                child: TextView(
                                                    text: "Opened (${injector.get<ProfileBloc>().appUser?.publicGroupCount}/5)",
                                                    color: SubscriptionHelper.canCreatePublicGroup ? null : Pallets.borderGrey,
                                                  ),
                                              ),
                                            ),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "Closed",
                                        enabled: SubscriptionHelper.isSubscribed,
                                        child: IgnorePointer(
                                          ignoring: SubscriptionHelper.isSubscribed,
                                          child: InkWell(
                                            onTap: () {
                                              if (!SubscriptionHelper.isSubscribed) {
                                                canCreate = false;
                                                setState(() {});
                                              }
                                            },
                                            child: TextView(
                                              text: "Closed",
                                              color: SubscriptionHelper.isSubscribed ? null : Pallets.borderGrey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                10.verticalSpace,
                                TextView(
                                  text: discoverability == "Opened" ? publicGroupInfo : privateGroupInfo,
                                ),
                                5.verticalSpace,
                                if (!canCreate)
                                  TalkamSubscriptionPrompt(
                                    tittle: "Open unlimited public and private groups when you ",
                                    onReturnFromSubscription: () {
                                      canCreate = SubscriptionHelper.canCreatePublicGroup;
                                      setState(() {});
                                    },
                                  ),
                              ],
                            ))
                          ],
                        ),
                        50.verticalSpace
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void validateAndSubmit(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      if (selectedCategory == null) {
        logger.e("No Category");

        CustomDialogs.error("Select category");
      } else if (_bannerImage == null) {
        CustomDialogs.error("Select banner image");
      } else if (discoverability == null) {
        CustomDialogs.error("Select group discoverability");
      }else {
        updatePayload();
        if (widget.group != null) {
          updateGroup();
        } else {
          context.pushNamed(PageUrl.createGroupRulesScreen);
        }
      }
    }
  }

  void updatePayload() {
    injector.get<CreateGroupCubit>().updateGroupPayload(
        name: groupNameController.text,
        image: _bannerImage,
        categoryId: selectedCategory!.id,
        about: purposeController.text,
        categoryImage: selectedCategory!.iconImage,
        categoryName: selectedCategory!.name,
        description: groupInfoController.text,
        status: "Active",
        groupAccess: discoverability);
  }

  Future<void> selectCategory(BuildContext context) async {
    var categoryorGroup = await CustomDialogs.showBottomSheet(context, const SelectCategorySheet());

    if (categoryorGroup is PostCategory) {
      selectedCategory = categoryorGroup;
      categoryController.text = categoryorGroup.name;
      setState(() {});
    }

    // if (selectedCategory != null) {
    //   widget.onCategorySelected(selectedCategory!);
    //   setState(() {});
    // }
  }

  void _prefill() {
    if (widget.group != null) {
      Future.delayed(
        Duration.zero,
        () {
          var group = widget.group!;
          logger.w(group.image.toString());
          _bannerImage = group.image;
          groupNameController.text = group.name.toString();
          purposeController.text = group.about.toString();
          groupInfoController.text = group.description.toString();
          selectedCategory = group.category;
          categoryController.text = selectedCategory!.name.toString();
          discoverability = group.groupAccess!;
          setState(() {});
        },
      );
    }
  }

  void updateGroup() {
    _createGroupBloc.updateGroup(widget.group!.id.toString(), injector.get<CreateGroupCubit>().groupPayload);
  }
}
