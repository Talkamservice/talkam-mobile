import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/services/image_manipulation/image_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/gen/assets.gen.dart';

class CreateGroupHeader extends StatefulWidget {
  CreateGroupHeader({super.key, required this.onBannerUpdated, this.banner});

  final Function(String bannerImage) onBannerUpdated;
  String? banner;

  @override
  State<CreateGroupHeader> createState() => _CreateGroupHeaderState();
}

class _CreateGroupHeaderState extends State<CreateGroupHeader> {
  String? _banner;

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        _banner = widget.banner;
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Stack(
        children: [
          ImageWidget(
            height: 130,
            // canPreview: true,
            width: 1.sw,
            imageType: bannerImageType,
            imageUrl: _banner ?? Assets.images.jpegs.football.path,
          ),
          Column(
            children: [
              40.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: ImageWidget(
                            imageUrl: Assets.images.svgs.arrowLeft)),
                    const Spacer(),
                    if (_banner == null)
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Pallets.white,
                              foregroundColor: context.colorScheme.onSurface,
                              shape: const StadiumBorder()),
                          onPressed: () {
                            selectImage();
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add,
                              ),
                              8.horizontalSpace,
                              const TextView(text: "Add banner")
                            ],
                          )),
                    if (_banner != null)
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Pallets.white,
                              shape: const CircleBorder()),
                          onPressed: () {
                            _banner = null;
                            setState(() {});
                          },
                          child: ImageWidget(
                              imageUrl: Assets.images.svgs.icDelete))
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  ImageWidgetType get bannerImageType {
    return _banner.toString().isURL
              ? ImageWidgetType.network
              : _banner == null
                  ? ImageWidgetType.asset
                  : ImageWidgetType.file;
  }

  void selectImage() async {
    var image = await ImageManager().showPhotoSourceDialog(context);

    if (image != null) {
      _banner = image.path;
      // selectedImages.add(image);
      widget.onBannerUpdated(image.path);
      setState(() {});
    }
  }
}
