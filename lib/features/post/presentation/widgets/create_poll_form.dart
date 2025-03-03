import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/presentation/bloc/create_post/create_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/create_post/create_post_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/tags_picker_widget.dart';
import 'package:talkam/features/post/presentation/widgets/time_picker_button.dart';
import 'package:talkam/gen/assets.gen.dart';

class CreatePollForm extends StatefulWidget {
  const CreatePollForm({super.key});

  @override
  State<CreatePollForm> createState() => _CreatePollFormState();
}

class _CreatePollFormState extends State<CreatePollForm> {
  final tittleController = TextEditingController();
  final List<TextEditingController> choiceControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  int pollHours = 7;
  int pollDays = 2;
  final formKey = GlobalKey<FormState>();

  List<String> _selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(color: context.theme.cardColor),
      child: Form(
        key: formKey,
        child: BlocListener<CreatePostCubit, CreatePostState>(
          listener: _listenToCreatePostState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TagsPickerWidget(
                onTagSelected: (List<String> selectedTags) {
                  _selectedTags = selectedTags;
                },
              ),
              16.verticalSpace,
              Row(
                children: [
                  TextView(
                    text: "Options",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  const TextView(
                    text: " *",
                    fontSize: 15,
                    color: Pallets.red,
                  ),
                ],
              ),
              6.verticalSpace,
              ...List.generate(
                choiceControllers.length,
                (index) => Row(
                  children: [
                    Expanded(
                        child: OutlinedFormField(
                            validator: RequiredValidator(errorText: "Field is required").call,
                            controller: choiceControllers[index],
                            hint: "Choice ${index + 1}")),
                    if (index + 1 > 2)
                      IconButton(
                          onPressed: () {
                            choiceControllers.removeAt(index);
                            setState(() {});
                          },
                          icon: ImageWidget(imageUrl: Assets.images.svgs.trash03)),
                  ],
                ),
              ),
              16.verticalSpace,
              TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      shape: const StadiumBorder(side: BorderSide(color: Pallets.borderGrey))),
                  onPressed: () {
                    choiceControllers.add(TextEditingController());
                    setState(() {});
                  },
                  child: const TextView(
                    text: "Add choice",
                    fontWeight: FontWeight.w700,
                  )),
              17.verticalSpace,
              const Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  const Expanded(
                    child: TextView(
                      text: "Duration of Poll",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TimePickerButton(
                    title: "$pollDays${pollDays == 1 ? "Day" : "Days"}",
                    onPressed: () {
                      selectDays(context);
                    },
                  ),
                  10.horizontalSpace,
                  TimePickerButton(
                    title: "$pollHours${pollHours == 1 ? "Hour" : "Hours"}",
                    onPressed: () {
                      selectHours(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void selectDays(BuildContext context) async {
    var days = await CustomDialogs.showBottomSheet(
        context,
        Container(
          height: 0.5.sh,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(
                    20,
                  ),
                  topLeft: Radius.circular(20))),
          child: Column(
            children: [
              16.verticalSpace,
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          context.pop(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextView(
                            text: "$index${index == 1 ? "Day" : "Days"}",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 0.6,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
    if (days != null) {
      pollDays = days;

      setState(() {});
    }
  }

  void selectHours(BuildContext context) async {
    var hours = await CustomDialogs.showBottomSheet(
        context,
        Container(
          height: 0.5.sh,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(
                    20,
                  ),
                  topLeft: Radius.circular(20))),
          child: Column(
            children: [
              16.verticalSpace,
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      context.pop(index);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextView(
                            text: "$index${index == 1 ? "Hour" : "Hours"}",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Divider(
                          thickness: 0.6,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));

    if (hours != null) {
      pollHours = hours;
      setState(() {});
    }
  }

  void _listenToCreatePostState(BuildContext context, CreatePostState state) {
    state.maybeWhen(
      validateFormsState: () {
        if (formKey.currentState?.validate() ?? false) {
          context.read<CreatePostCubit>().updatePayload(CreatePostPayload(
              title: tittleController.text,
              tags: _selectedTags,
              poll: Poll(
                  type: "Text",
                  options: choiceControllers
                      .map(
                        (e) => e.text,
                      )
                      .toList(),
                  duration: Duration(days: pollDays, hours: pollHours).inMinutes.toDouble())));

          context.read<CreatePostCubit>().validateFormsSuccess();
        }
      },
      orElse: () => null,
    );
  }
}
