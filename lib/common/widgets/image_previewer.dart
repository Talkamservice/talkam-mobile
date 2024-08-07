import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:talkam/common/blocs/image_downloader/image_downloader_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/utils/download_manager.dart';
import 'package:talkam/core/utils/image_downloader.dart';
import 'package:path/path.dart' as path;

enum ImageType {
  asset,
  file,
  network,
}

class ImagePreviewer extends StatelessWidget {
  final String imageUrl;
  final bool? tightMode;
  final String? heroTag;
  final ImageType? imageType;

  ImagePreviewer(
      {Key? key,
      required this.imageUrl,
      this.tightMode,
      this.heroTag,
      this.imageType = ImageType.network})
      : super(key: key);

  final downloadBloc = ImageDownloaderBloc();

  @override
  Widget build(BuildContext context) {
    // log('{imageUrl.replaceRange(0, 1,'')}');
    return BlocConsumer<ImageDownloaderBloc, ImageDownloaderState>(
      bloc: downloadBloc,
      listener: (context, state) {
        if (state is DownloadImageSuccess) {
          context.pop();
          CustomDialogs.success("Image saved to gallery");
        }

        if (state is DownloadImageFailure) {
          context.pop();
          CustomDialogs.error(state.error);
        }

        if (state is DownloadImageLoading) {
          CustomDialogs.showLoading(context);
        }
      },
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          // alignment: Alignment.topLeft,
          children: [
            PhotoView(
              // backgroundDecoration: const BoxDecoration(color: Colors.transparent),
              imageProvider: imageType == ImageType.asset
                  ? AssetImage(imageUrl)
                  : imageType == ImageType.file
                      ? FileImage(File(imageUrl)) as ImageProvider
                      : NetworkImage(imageUrl),
              heroAttributes: PhotoViewHeroAttributes(tag: heroTag ?? ""),
              basePosition: Alignment.center,
              tightMode: tightMode,
              errorBuilder: (context, object, stackTrace) => const Center(
                child: Text('Error loading image'),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                    )),
              ),
            ),
            if (imageType! == ImageType.network)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.all(16),
                          foregroundColor: Colors.white),
                      onPressed: () async {
                        // var downloadDir =
                        //     Directory('/storage/emulated/0/PICTURES').path;
                        // DownloadManager().downloadFile(imageUrl,
                        //     "$downloadDir/${DateTime.now().microsecondsSinceEpoch.toString()}.png");

                        downloadBloc.add(DownloadImageEvent(imageUrl));
                      },
                      child: const Text('Download image')),
                ),
              )
          ],
        );
      },
    );
  }
}
