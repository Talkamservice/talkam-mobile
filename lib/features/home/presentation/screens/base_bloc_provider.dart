import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';

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
    ], child: widget.child);
  }
}
