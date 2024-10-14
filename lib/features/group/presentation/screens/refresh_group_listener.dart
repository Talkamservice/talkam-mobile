import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';

class RefreshGroupListener extends StatelessWidget {
  const RefreshGroupListener({super.key, required this.child, required this.onRefresh});

  final Widget child;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupsCubit, GroupsState>(
      bloc: injector.get(),
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          refreshGroups: () => onRefresh(),
        );
      },
      child: child,
    );
  }
}
