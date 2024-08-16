import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_details_screen_state.dart';
part 'group_details_screen_cubit.freezed.dart';

class GroupDetailsScreenCubit extends Cubit<GroupDetailsScreenState> {
  GroupDetailsScreenCubit() : super(const GroupDetailsScreenState.initial());
}
