import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/empty_photo_card.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/image_manipulation/image_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/presentation/bloc/create_post/create_post_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/add_tags_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/selected_image_widget.dart';

class ImagePostForm extends StatefulWidget {
  const ImagePostForm({super.key});

  @override
  State<ImagePostForm> createState() => _ImagePostFormState();
}

class _ImagePostFormState extends State<ImagePostForm>
    with AutomaticKeepAliveClientMixin {
  final tittleController = TextEditingController();
  final tagsController = TextEditingController();
  List<File> selectedImages = [];
  final formKey = GlobalKey<FormState>();

  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostCubit, CreatePostState>(
      listener: _listenToCreatePostState,
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.cardColor,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 16.verticalSpace,
              InkWell(
                onTap: () {
                  selectTags(context);
                },
                child: OutlinedFormField(
                    placeHolder: "Tags",
                    fillColor: Pallets.borderGrey.withOpacity(0.1),
                    radius: 4,
                    filled: true,
                    enabled: false,
                    suffix: const Icon(Icons.arrow_forward_ios),
                    controller: tagsController,
                    onChange: (d) {
                      setState(() {});
                    },
                    showRequiredAsterics: true,
                    hint: "Add at least one tag"),
              ),
              16.verticalSpace,
              if (selectedImages.isEmpty)
                InkWell(
                  onTap: () {
                    getImages();
                  },
                  child: const EmptyPhotoCard(
                    height: 167,
                    width: 168,
                  ),
                ),
              if (selectedImages.isNotEmpty)
                SelectedImageWidget(
                  images: selectedImages,
                  onAddImage: () {
                    getImages();
                  },
                  onDelete: (File image) {
                    if (selectedImages.length <= 1) {
                      selectedImages.clear();
                    } else {
                      selectedImages.remove(image);
                    }
                    setState(() {});
                  },
                ),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void getImages() async {
    var image = await ImageManager().showPhotoSourceDialog(context);

    if (image != null) {
      selectedImages.add(image);
      setState(() {});
    }
  }

  void _listenToCreatePostState(BuildContext context, CreatePostState state) {
    state.maybeWhen(

      validateFormsState: () {
        if (formKey.currentState?.validate() ?? false) {
          if (selectedImages.isNotEmpty) {
            context.read<CreatePostCubit>().updatePayload(CreatePostPayload(
                title: tittleController.text,
                tags: selectedTags,
                attachments: selectedImages
                    .map(
                      (e) => Attachment.image(e.path),
                    )
                    .toList()));
            context.read<CreatePostCubit>().validateFormsSuccess();
          } else {
            CustomDialogs.error("Please upload an image to continue");
          }
        }
      },
      orElse: () => null,
    );
  }

  void selectTags(BuildContext context) async {
    List<String>? tags = await CustomDialogs.showBottomSheet(
        context,
        AddTagsSheet(
          initialTAgs: selectedTags,
        ));

    if (tags != null && tags.isNotEmpty) {
      tagsController.text = tags.join(',');
      selectedTags = tags;

      logger.w(selectedTags.length);
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
