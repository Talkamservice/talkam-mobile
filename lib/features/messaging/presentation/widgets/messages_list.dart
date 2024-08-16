import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/gen/assets.gen.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({super.key});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  File? image;

  final List<String> names = [
    "MysticMaven",
    "ShadowScribe",
    "SolarFlare88",
    "HorizonHunter",
    "PhoenixFeather",
    "TurboTitan",
    "PixelPioneer",
    "QuantumQuestor",
    "ElectricEchoes",
  ];

  final List<String> messages = [
    "I will! Thanks for the heads-up.",
    "Not much.",
    "Thinking about going hiking if the weather's nice.",
    "True.",
    "All I want is nothing more than to hear you.",
    "Sounds perfect.",
    "Thanks! Enjoy your relaxing weekend.",
    "Just once. We barely made it out in time, but it was a blast.",
    "I missed it. Heard it was a close one th....",
  ];

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
      itemCount: names.length,
      itemBuilder: (BuildContext context, index) {
        bool isSeen = index % 2 == 0;
        String messageTime = "12:34 PM";

        return GestureDetector(
          onTap: () {
            context.pushNamed(PageUrl.chatScreen);
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
                    TextView(
                      text: names[index],
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 8),
                    TextView(
                      text: messages[index],
                      color: const Color(0xff666666),
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextView(
                    text: messageTime,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff888888),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffAEAEAE),
                    ),
                    child: ClipOval(
                      child: Icon(
                        Icons.check,
                        size: 12,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, _) => const SizedBox(height: 16),
    );
  }
}
