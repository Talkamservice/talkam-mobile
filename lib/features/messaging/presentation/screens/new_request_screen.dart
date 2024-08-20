import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/messaging/presentation/widgets/new_request_list.dart'; // Import the NewRequestList widget

class NewRequestScreen extends StatefulWidget {
  const NewRequestScreen({super.key});

  @override
  State<NewRequestScreen> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  final List<String> names = [
    "SolarFlare88",
    "PhoenixFeather",
  ];

  final List<String> messages = [
    "Thinking about going hiking if the weather's nice.",
    "All I want is nothing more than to hear you.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 25,
        padding: EdgeInsets.only(top: 13),
        tittle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextView(
              text: "New Requests",
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        centerTile: false,
        showDivider: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.pushNamed(PageUrl.new_messageScreen);
              },
              child: NewRequestList(
                name1: names,
                message2: messages,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
