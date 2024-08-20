import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/gen/assets.gen.dart';

class NewRequestList extends StatefulWidget {
  final List<String> name1;
  final List<String> message2;

  const NewRequestList({
    super.key,
    required this.name1,
    required this.message2,
  });

  @override
  _NewRequestListState createState() => _NewRequestListState();
}

class _NewRequestListState extends State<NewRequestList> {
  File? image;

  Future<void> pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage == null) {
        print('No image picked');
        return;
      }

      final imageTemporary = File(pickedImage.path);
      setState(() {
        image = imageTemporary;
      });
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: widget.name1.length,
      itemBuilder: (BuildContext context, index) {
        String messageTime = "12:34 PM";
        String name = widget.name1[index];
        String message = widget.message2[index];

        return GestureDetector(
          onTap: () {
            context.pushNamed(PageUrl.new_messageScreen);
          },
          child: Row(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: image != null
                        ? Image.file(
                            image!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(Assets.images.png.woman.path),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: name,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        TextView(
                          text: messageTime,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff888888),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextView(
                            text: message,
                            color: const Color(0xff666666),
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xffAEAEAE),
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 12,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, _) => const SizedBox(height: 16),
    );
  }
}
