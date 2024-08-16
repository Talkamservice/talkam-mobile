import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/features/messaging/presentation/widgets/message_bubbles/blue_bubbles.dart';
import 'package:talkam/gen/assets.gen.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
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
              padding: const EdgeInsets.only(top: 2),
              child: const TextView(
                text: "SolarFlare88",
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            )
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 151),
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
            padding: const EdgeInsets.only(right: 110, top: 20),
            child: BlueBubbles(
              message:
                  "Yeah, I watched that new sci-fi movie Galactic Odyssey. It was epic!",
              time: "11:53 AM",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 450, left: 16),
            child: Center(
              child: TextView(
                color: Color(0xff212121),
                text:
                    '     SolarFlare88 is sending you a message to\nconnect. Do you want to accept their request to\n                send and receive messages?',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 39),
            child: Row(
              children: [
                Container(
                  height: 44,
                  width: 175,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFFFFA9A9),
                      width: 1.0,
                    ),
                  ),
                  child: Center(
                    child: TextView(
                      color: Color(0xFFEE1414),
                      text: 'Reject',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
                Container(
                  height: 44,
                  width: 175,
                  decoration: BoxDecoration(
                    color: Color(0xFF272727),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: TextView(
                      color: Color(0xFFFFFFFF),
                      text: 'Accept',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          )
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
