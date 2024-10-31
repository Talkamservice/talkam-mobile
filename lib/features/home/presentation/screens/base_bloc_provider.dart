import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class BaseBlocProvider extends StatefulWidget {
  const BaseBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  State<BaseBlocProvider> createState() => _BaseBlocProviderState();
}

class _BaseBlocProviderState extends State<BaseBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DrawerCubit(),
          )
        ],
        child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: injector.get(),
          builder: (context, state) {
            return widget.child;
          },
        ));
  }
}
