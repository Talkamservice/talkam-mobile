import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_colored_controller.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/presentation/bloc/create_post/create_post_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/tags_picker_widget.dart';
import 'package:talkam/features/subscription/presentation/widgets/talkam_subscription_prompt.dart';

class TextPostForm extends StatefulWidget {
  const TextPostForm({super.key});

  @override
  State<TextPostForm> createState() => _TextPostFormState();
}

class _TextPostFormState extends State<TextPostForm> with AutomaticKeepAliveClientMixin {
  final tittleController = TextEditingController();
  final bodyController = CustomColoredTextController(maxText: 20);
  final formKey = GlobalKey<FormState>();
  bool showLimitedCharacterWarning = false;

  List<String> _selectedTags = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
      ),
      child: BlocListener<CreatePostCubit, CreatePostState>(
        listener: _listenToCreatePostState,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Column(
                  children: [
                    OutlinedFormField(
                        maxLine: 8,
                        fillColor: Pallets.borderGrey.withOpacity(0.15),
                        radius: 4,
                        filled: true,
                        textCapitalization: TextCapitalization.sentences,

                        // validator:
                        //     RequiredValidator(errorText: "Field is required").call,
                        controller: bodyController,
                        onChange: (d) {
                          setState(() {});
                          if (bodyController.text.length > 20) {
                            showLimitedCharacterWarning = true;
                          } else {
                            showLimitedCharacterWarning = false;
                          }


                        },
                        showRequiredAsterics: true,
                        hint: "Write the rest of your text here. (optional)"),
                    if(showLimitedCharacterWarning)
                    const TalkamSubscriptionPrompt(
                      padding: EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                      tittle: "To have access to unlimited characters,",
                    )
                  ],
                ),
              ),
              16.verticalSpace,

              TagsPickerWidget(
                onTagSelected: (List<String> selectedTags) {
                  _selectedTags = selectedTags;
                },
              ),

              // OutlinedFormField(
              //     placeHolder: "Tags",
              //     fillColor: Pallets.borderGrey.withOpacity(0.1),
              //     radius: 4,
              //     filled: true,
              //     suffix: const Icon(Icons.arrow_forward_ios),
              //     controller: tittleController,
              //     onChange: (d) {
              //       setState(() {});
              //     },
              //     showRequiredAsterics: true,
              //     hint: "Add at least one tag"),
            ],
          ),
        ),
      ),
    );
  }

  void _listenToCreatePostState(BuildContext context, CreatePostState state) {
    state.maybeWhen(
      validateFormsState: () {
        if (formKey.currentState?.validate() ?? false) {
          context.read<CreatePostCubit>().updatePayload(CreatePostPayload(title: tittleController.text, body: bodyController.text, tags: _selectedTags));
          context.read<CreatePostCubit>().validateFormsSuccess();
        }
      },
      orElse: () => null,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
