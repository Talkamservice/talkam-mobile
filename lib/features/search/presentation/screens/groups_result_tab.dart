import 'package:flutter/material.dart';
import 'package:talkam/features/search/presentation/widget/group_result_item.dart';

class GroupsResultTab extends StatefulWidget {
  const GroupsResultTab({super.key});

  @override
  State<GroupsResultTab> createState() => _GroupsResultTabState();
}

class _GroupsResultTabState extends State<GroupsResultTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => const GroupResultItem(),
            ),
          )
        ],
      ),
    );
  }
}
