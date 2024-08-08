import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/components/talkam_tab_bar.dart';
import 'package:talkam/features/group/presentation/tabs/group_explore_tab.dart';
import 'package:talkam/features/group/presentation/tabs/group_recent_tab.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/gen/assets.gen.dart';

enum _GroupsTabOptions {
  recent,
  explore;

  String get title {
    switch (this) {
      case recent:
        return "Recent";

      case explore:
        return "Explore";

      default:
        return "";
    }
  }
}

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
