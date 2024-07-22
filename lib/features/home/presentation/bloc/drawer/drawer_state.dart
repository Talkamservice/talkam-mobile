part of 'drawer_cubit.dart';

@freezed
class DrawerState with _$DrawerState {


  const factory DrawerState.categoryView() = CategoryViewState;

  const factory DrawerState.subCategoryView({required PostCategory subCategory}) =
      SubCategoryViewState;

  const factory DrawerState.openDrawer() = OpenDrawerState;

  const factory DrawerState.closeDrawer() = CloseDrawerState;
}

