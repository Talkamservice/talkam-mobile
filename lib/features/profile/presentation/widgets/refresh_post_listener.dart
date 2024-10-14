import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/presentation/bloc/trending_post/trending_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/trending_post/trending_post_cubit.dart';

class RefreshPostListener extends StatelessWidget {
  const RefreshPostListener({super.key, required this.child, required this.onRefresh});

  final Widget child;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrendingPostCubit, TrendingPostState>(
      bloc: injector.get(),
      listener: (context, state) {
        state.maybeWhen(
            orElse: () => null,
            getTrendingPostsSuccess: (va) {
              onRefresh();
            });
      },
      child: child,
    );
  }
}
