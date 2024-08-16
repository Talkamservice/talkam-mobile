import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
    String messageTime = "12:34 PM";
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 25,
        tittle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                width: 32,
                height: 32,
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
            11.horizontalSpace,
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: const TextView(
                text: "ElectricEchoes",
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        centerTile: false,
        showDivider: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Stack(
        children: [
        
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.emoji_emotions_outlined,
                            size: 20, color: Pallets.grey),
                      ),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.image_outlined,
                              size: 20, color: Pallets.grey),
                        ),
                        8.horizontalSpace,
                        GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.attach_file,
                              size: 18,
                              color: const Color.fromARGB(255, 9, 8, 8)),
                        ),
                        16.horizontalSpace,
                      ],
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Type your message here ...",
                    hintStyle: const TextStyle(
                      color: Color(0xff444444),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        color: Pallets.borderGrey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        color: Pallets.borderGrey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        color: Pallets.borderGrey,
                      ),
                    ),
                  ),
                  style: const TextStyle(height: 1.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
