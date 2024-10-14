import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:path/path.dart' as path;
import 'package:talkam/features/post/presentation/widgets/selected_videos_widget.dart';
import 'package:talkam/features/post/presentation/widgets/tags_picker_widget.dart';

class MediaPostForm extends StatefulWidget {
  const MediaPostForm({super.key});

  @override
  State<MediaPostForm> createState() => _MediaPostFormState();
}

class _MediaPostFormState extends State<MediaPostForm> with AutomaticKeepAliveClientMixin {
  final tittleController = TextEditingController();
  final tagsController = TextEditingController();
  List<File> selectedFiles = [];
  final formKey = GlobalKey<FormState>();

  List<String> _selectedTags = [];

  bool isImage = true;

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
              TagsPickerWidget(
                onTagSelected: (List<String> selectedTags) {
                  _selectedTags = selectedTags;
                },
              ),
              16.verticalSpace,
              if (selectedFiles.isEmpty)
                InkWell(
                  onTap: () {
                    getImages();
                  },
                  child: EmptyPhotoCard(
                    height: 167,
                    width: 1.sw,
                    icon: Icon(Icons.add),
                  ),
                ),
              if (selectedFiles.isNotEmpty)
                Builder(
                  builder: (context) {
                    if (selectedFiles.isNotEmpty && isImage) {
                      return SelectedImageWidget(
                        images: selectedFiles,
                        onAddImage: () {
                          getImages();
                        },
                        onDelete: (File image) {
                          if (selectedFiles.length <= 1) {
                            selectedFiles.clear();
                          } else {
                            selectedFiles.remove(image);
                          }
                          setState(() {});
                        },
                      );
                    }

                    return SelectedVideosWidget(
                      images: selectedFiles,
                      onAddImage: () {
                        getImages(allowedExtensions: videoExtensions);
                      },
                      onDelete: (File video) {
                        if (selectedFiles.length <= 1) {
                          selectedFiles.clear();
                        } else {
                          selectedFiles.remove(video);
                        }
                        setState(() {});
                      },
                    );
                  },
                ),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void getImages({List<String>? allowedExtensions}) async {
    // var image = await ImageManager().showPhotoSourceDialog(context);
    //
    // if (image != null) {
    //   selectedImages.add(image);
    //   setState(() {});
    // }

    var files = await ImageManager()
        .fetchFiles(fileType: FileType.custom, allowedExtensions: allowedExtensions ?? [...videoExtensions, ...imageExtensions], allowMultiple: false);

    if (files.isNotEmpty) {
      isImage = imageExtensions.contains(path.extension(files.first).substring(1));
      logger.w(isImage);
      logger.w(path.extension(files.first));
      selectedFiles.add(File(files.first));
      setState(() {});
    }
  }

  void _listenToCreatePostState(BuildContext context, CreatePostState state) {
    state.maybeWhen(
      validateFormsState: () {
        if (formKey.currentState?.validate() ?? false) {
          if (selectedFiles.isNotEmpty) {
            context.read<CreatePostCubit>().updatePayload(CreatePostPayload(
                title: tittleController.text,
                tags: _selectedTags,
                type: isImage ? "Image" : "Video",
                attachments: selectedFiles
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

var videoExtensions = [
  "mp4",
  "mov",
  "webm",
];

var imageExtensions = ["png", "jpg", "svg", "gif"];
