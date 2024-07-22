import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';

part 'drawer_state.dart';

part 'drawer_cubit.freezed.dart';

// drawer_view.dart
enum DrawerView { category, subCategory }

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(const DrawerState.categoryView());

  void openDrawer() {
    emit(const DrawerState.openDrawer());
  }

  void closeDrawer() {
    emit(const DrawerState.closeDrawer());
  }

  void switchView(DrawerView view, {required PostCategory subCategory}) {
    if (view == DrawerView.category) {
      emit(const DrawerState.categoryView());
    } else if (view == DrawerView.subCategory) {
      emit(DrawerState.subCategoryView(subCategory: subCategory));
    }
  }
}
