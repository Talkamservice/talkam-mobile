// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drawer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DrawerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() categoryView,
    required TResult Function(PostCategory subCategory) subCategoryView,
    required TResult Function() openDrawer,
    required TResult Function() closeDrawer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? categoryView,
    TResult? Function(PostCategory subCategory)? subCategoryView,
    TResult? Function()? openDrawer,
    TResult? Function()? closeDrawer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? categoryView,
    TResult Function(PostCategory subCategory)? subCategoryView,
    TResult Function()? openDrawer,
    TResult Function()? closeDrawer,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CategoryViewState value) categoryView,
    required TResult Function(SubCategoryViewState value) subCategoryView,
    required TResult Function(OpenDrawerState value) openDrawer,
    required TResult Function(CloseDrawerState value) closeDrawer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CategoryViewState value)? categoryView,
    TResult? Function(SubCategoryViewState value)? subCategoryView,
    TResult? Function(OpenDrawerState value)? openDrawer,
    TResult? Function(CloseDrawerState value)? closeDrawer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CategoryViewState value)? categoryView,
    TResult Function(SubCategoryViewState value)? subCategoryView,
    TResult Function(OpenDrawerState value)? openDrawer,
    TResult Function(CloseDrawerState value)? closeDrawer,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrawerStateCopyWith<$Res> {
  factory $DrawerStateCopyWith(
          DrawerState value, $Res Function(DrawerState) then) =
      _$DrawerStateCopyWithImpl<$Res, DrawerState>;
}

/// @nodoc
class _$DrawerStateCopyWithImpl<$Res, $Val extends DrawerState>
    implements $DrawerStateCopyWith<$Res> {
  _$DrawerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CategoryViewStateImplCopyWith<$Res> {
  factory _$$CategoryViewStateImplCopyWith(_$CategoryViewStateImpl value,
          $Res Function(_$CategoryViewStateImpl) then) =
      __$$CategoryViewStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CategoryViewStateImplCopyWithImpl<$Res>
    extends _$DrawerStateCopyWithImpl<$Res, _$CategoryViewStateImpl>
    implements _$$CategoryViewStateImplCopyWith<$Res> {
  __$$CategoryViewStateImplCopyWithImpl(_$CategoryViewStateImpl _value,
      $Res Function(_$CategoryViewStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CategoryViewStateImpl implements CategoryViewState {
  const _$CategoryViewStateImpl();

  @override
  String toString() {
    return 'DrawerState.categoryView()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CategoryViewStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() categoryView,
    required TResult Function(PostCategory subCategory) subCategoryView,
    required TResult Function() openDrawer,
    required TResult Function() closeDrawer,
  }) {
    return categoryView();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? categoryView,
    TResult? Function(PostCategory subCategory)? subCategoryView,
    TResult? Function()? openDrawer,
    TResult? Function()? closeDrawer,
  }) {
    return categoryView?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? categoryView,
    TResult Function(PostCategory subCategory)? subCategoryView,
    TResult Function()? openDrawer,
    TResult Function()? closeDrawer,
    required TResult orElse(),
  }) {
    if (categoryView != null) {
      return categoryView();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CategoryViewState value) categoryView,
    required TResult Function(SubCategoryViewState value) subCategoryView,
    required TResult Function(OpenDrawerState value) openDrawer,
    required TResult Function(CloseDrawerState value) closeDrawer,
  }) {
    return categoryView(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CategoryViewState value)? categoryView,
    TResult? Function(SubCategoryViewState value)? subCategoryView,
    TResult? Function(OpenDrawerState value)? openDrawer,
    TResult? Function(CloseDrawerState value)? closeDrawer,
  }) {
    return categoryView?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CategoryViewState value)? categoryView,
    TResult Function(SubCategoryViewState value)? subCategoryView,
    TResult Function(OpenDrawerState value)? openDrawer,
    TResult Function(CloseDrawerState value)? closeDrawer,
    required TResult orElse(),
  }) {
    if (categoryView != null) {
      return categoryView(this);
    }
    return orElse();
  }
}

abstract class CategoryViewState implements DrawerState {
  const factory CategoryViewState() = _$CategoryViewStateImpl;
}

/// @nodoc
abstract class _$$SubCategoryViewStateImplCopyWith<$Res> {
  factory _$$SubCategoryViewStateImplCopyWith(_$SubCategoryViewStateImpl value,
          $Res Function(_$SubCategoryViewStateImpl) then) =
      __$$SubCategoryViewStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PostCategory subCategory});
}

/// @nodoc
class __$$SubCategoryViewStateImplCopyWithImpl<$Res>
    extends _$DrawerStateCopyWithImpl<$Res, _$SubCategoryViewStateImpl>
    implements _$$SubCategoryViewStateImplCopyWith<$Res> {
  __$$SubCategoryViewStateImplCopyWithImpl(_$SubCategoryViewStateImpl _value,
      $Res Function(_$SubCategoryViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subCategory = null,
  }) {
    return _then(_$SubCategoryViewStateImpl(
      subCategory: null == subCategory
          ? _value.subCategory
          : subCategory // ignore: cast_nullable_to_non_nullable
              as PostCategory,
    ));
  }
}

/// @nodoc

class _$SubCategoryViewStateImpl implements SubCategoryViewState {
  const _$SubCategoryViewStateImpl({required this.subCategory});

  @override
  final PostCategory subCategory;

  @override
  String toString() {
    return 'DrawerState.subCategoryView(subCategory: $subCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubCategoryViewStateImpl &&
            (identical(other.subCategory, subCategory) ||
                other.subCategory == subCategory));
  }

  @override
  int get hashCode => Object.hash(runtimeType, subCategory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubCategoryViewStateImplCopyWith<_$SubCategoryViewStateImpl>
      get copyWith =>
          __$$SubCategoryViewStateImplCopyWithImpl<_$SubCategoryViewStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() categoryView,
    required TResult Function(PostCategory subCategory) subCategoryView,
    required TResult Function() openDrawer,
    required TResult Function() closeDrawer,
  }) {
    return subCategoryView(subCategory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? categoryView,
    TResult? Function(PostCategory subCategory)? subCategoryView,
    TResult? Function()? openDrawer,
    TResult? Function()? closeDrawer,
  }) {
    return subCategoryView?.call(subCategory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? categoryView,
    TResult Function(PostCategory subCategory)? subCategoryView,
    TResult Function()? openDrawer,
    TResult Function()? closeDrawer,
    required TResult orElse(),
  }) {
    if (subCategoryView != null) {
      return subCategoryView(subCategory);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CategoryViewState value) categoryView,
    required TResult Function(SubCategoryViewState value) subCategoryView,
    required TResult Function(OpenDrawerState value) openDrawer,
    required TResult Function(CloseDrawerState value) closeDrawer,
  }) {
    return subCategoryView(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CategoryViewState value)? categoryView,
    TResult? Function(SubCategoryViewState value)? subCategoryView,
    TResult? Function(OpenDrawerState value)? openDrawer,
    TResult? Function(CloseDrawerState value)? closeDrawer,
  }) {
    return subCategoryView?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CategoryViewState value)? categoryView,
    TResult Function(SubCategoryViewState value)? subCategoryView,
    TResult Function(OpenDrawerState value)? openDrawer,
    TResult Function(CloseDrawerState value)? closeDrawer,
    required TResult orElse(),
  }) {
    if (subCategoryView != null) {
      return subCategoryView(this);
    }
    return orElse();
  }
}

abstract class SubCategoryViewState implements DrawerState {
  const factory SubCategoryViewState(
      {required final PostCategory subCategory}) = _$SubCategoryViewStateImpl;

  PostCategory get subCategory;
  @JsonKey(ignore: true)
  _$$SubCategoryViewStateImplCopyWith<_$SubCategoryViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OpenDrawerStateImplCopyWith<$Res> {
  factory _$$OpenDrawerStateImplCopyWith(_$OpenDrawerStateImpl value,
          $Res Function(_$OpenDrawerStateImpl) then) =
      __$$OpenDrawerStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OpenDrawerStateImplCopyWithImpl<$Res>
    extends _$DrawerStateCopyWithImpl<$Res, _$OpenDrawerStateImpl>
    implements _$$OpenDrawerStateImplCopyWith<$Res> {
  __$$OpenDrawerStateImplCopyWithImpl(
      _$OpenDrawerStateImpl _value, $Res Function(_$OpenDrawerStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OpenDrawerStateImpl implements OpenDrawerState {
  const _$OpenDrawerStateImpl();

  @override
  String toString() {
    return 'DrawerState.openDrawer()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OpenDrawerStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() categoryView,
    required TResult Function(PostCategory subCategory) subCategoryView,
    required TResult Function() openDrawer,
    required TResult Function() closeDrawer,
  }) {
    return openDrawer();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? categoryView,
    TResult? Function(PostCategory subCategory)? subCategoryView,
    TResult? Function()? openDrawer,
    TResult? Function()? closeDrawer,
  }) {
    return openDrawer?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? categoryView,
    TResult Function(PostCategory subCategory)? subCategoryView,
    TResult Function()? openDrawer,
    TResult Function()? closeDrawer,
    required TResult orElse(),
  }) {
    if (openDrawer != null) {
      return openDrawer();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CategoryViewState value) categoryView,
    required TResult Function(SubCategoryViewState value) subCategoryView,
    required TResult Function(OpenDrawerState value) openDrawer,
    required TResult Function(CloseDrawerState value) closeDrawer,
  }) {
    return openDrawer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CategoryViewState value)? categoryView,
    TResult? Function(SubCategoryViewState value)? subCategoryView,
    TResult? Function(OpenDrawerState value)? openDrawer,
    TResult? Function(CloseDrawerState value)? closeDrawer,
  }) {
    return openDrawer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CategoryViewState value)? categoryView,
    TResult Function(SubCategoryViewState value)? subCategoryView,
    TResult Function(OpenDrawerState value)? openDrawer,
    TResult Function(CloseDrawerState value)? closeDrawer,
    required TResult orElse(),
  }) {
    if (openDrawer != null) {
      return openDrawer(this);
    }
    return orElse();
  }
}

abstract class OpenDrawerState implements DrawerState {
  const factory OpenDrawerState() = _$OpenDrawerStateImpl;
}

/// @nodoc
abstract class _$$CloseDrawerStateImplCopyWith<$Res> {
  factory _$$CloseDrawerStateImplCopyWith(_$CloseDrawerStateImpl value,
          $Res Function(_$CloseDrawerStateImpl) then) =
      __$$CloseDrawerStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CloseDrawerStateImplCopyWithImpl<$Res>
    extends _$DrawerStateCopyWithImpl<$Res, _$CloseDrawerStateImpl>
    implements _$$CloseDrawerStateImplCopyWith<$Res> {
  __$$CloseDrawerStateImplCopyWithImpl(_$CloseDrawerStateImpl _value,
      $Res Function(_$CloseDrawerStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CloseDrawerStateImpl implements CloseDrawerState {
  const _$CloseDrawerStateImpl();

  @override
  String toString() {
    return 'DrawerState.closeDrawer()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CloseDrawerStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() categoryView,
    required TResult Function(PostCategory subCategory) subCategoryView,
    required TResult Function() openDrawer,
    required TResult Function() closeDrawer,
  }) {
    return closeDrawer();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? categoryView,
    TResult? Function(PostCategory subCategory)? subCategoryView,
    TResult? Function()? openDrawer,
    TResult? Function()? closeDrawer,
  }) {
    return closeDrawer?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? categoryView,
    TResult Function(PostCategory subCategory)? subCategoryView,
    TResult Function()? openDrawer,
    TResult Function()? closeDrawer,
    required TResult orElse(),
  }) {
    if (closeDrawer != null) {
      return closeDrawer();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CategoryViewState value) categoryView,
    required TResult Function(SubCategoryViewState value) subCategoryView,
    required TResult Function(OpenDrawerState value) openDrawer,
    required TResult Function(CloseDrawerState value) closeDrawer,
  }) {
    return closeDrawer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CategoryViewState value)? categoryView,
    TResult? Function(SubCategoryViewState value)? subCategoryView,
    TResult? Function(OpenDrawerState value)? openDrawer,
    TResult? Function(CloseDrawerState value)? closeDrawer,
  }) {
    return closeDrawer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CategoryViewState value)? categoryView,
    TResult Function(SubCategoryViewState value)? subCategoryView,
    TResult Function(OpenDrawerState value)? openDrawer,
    TResult Function(CloseDrawerState value)? closeDrawer,
    required TResult orElse(),
  }) {
    if (closeDrawer != null) {
      return closeDrawer(this);
    }
    return orElse();
  }
}

abstract class CloseDrawerState implements DrawerState {
  const factory CloseDrawerState() = _$CloseDrawerStateImpl;
}
