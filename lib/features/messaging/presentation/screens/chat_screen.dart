import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/messaging/presentation/widgets/message_bubbles/blue_bubbles.dart';
import 'package:talkam/features/messaging/presentation/widgets/message_bubbles/gray_bubbles.dart';
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
        padding: EdgeInsets.only(top: 13),
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
            const TextView(
              text: "ElectricEchoes",
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        centerTile: false,
        showDivider: true,
        actions: [
          IconButton(
              onPressed: () {
                CustomDialogs.showBottomSheet(
                  context,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFFF),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildOptionRow(
                          icon: Icons.person_outline,
                          text: 'View Profile',
                          onTap: () {},
                        ),
                        Container(
                          width: double.infinity,
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        _buildOptionRow(
                          icon: Icons.notifications_off_outlined,
                          text: 'Mute notifications',
                          onTap: () {},
                        ),
                        Container(
                          width: double.infinity,
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        _buildOptionRow(
                          icon: Icons.delete_outline_outlined,
                          text: 'Delete chat',
                          onTap: () {},
                        ),
                        Container(
                          width: double.infinity,
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        _buildOptionRow(
                          icon: Icons.block_outlined,
                          text: 'Block daphne322',
                          onTap: () {},
                        ),
                        Container(
                          width: double.infinity,
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        _buildOptionRow(
                          icon: Icons.flag_outlined,
                          text: 'Report',
                          onTap: () {},
                        ),
                        Container(
                          width: double.infinity,
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 320, left: 151),
            child: Container(
              height: 24,
              width: 115,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Color(0xFFDDDDDD),
                  width: 1.0,
                ),
              ),
              child: Center(
                child: TextView(
                  text: 'Today 11:53 AM',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 110),
                  child: BlueBubbles(
                    message:
                        "Yeah, I watched that new sci-fi movie Galactic Odyssey. It was epic!",
                    time: "11:53 AM",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 110),
                  child: GrayBubbles(
                    message:
                        "Oh, I've heard about that one! Is it worth watching?",
                    time: "11:53 AM",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: BlueBubbles(
                    message: "Definitely!",
                    time: "11:53 AM",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 110),
                  child: GrayBubbles(
                    message:
                        "Cool, I'll add it to my watchlist. By the way, are you free this weekend? Thinking of having a game night.",
                    time: "11:53 AM",
                  ),
                ),
              ],
            ),
          ),
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

Widget _buildOptionRow(
    {required IconData icon,
    required String text,
    required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: Color(0xff212121),
          ),
          SizedBox(width: 16),
          TextView(
            color: Color(0xff212121),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            text: text,
          ),
        ],
      ),
    ),
  );
}
