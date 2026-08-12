import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

part 'featured_groups_state.dart';

part 'featured_groups_cubit.freezed.dart';

class FeaturedGroupsCubit extends Cubit<FeaturedGroupsState> {
  FeaturedGroupsCubit(this.groupRepository)
      : super(const FeaturedGroupsState.initial());

  final GroupsRepository groupRepository;

  /// v2's suggested-groups endpoint already does interest-match +
  /// member-count ranking server-side (excluding joined/closed groups), so
  /// the old client-side recommended+promoted merge is no longer needed.
  Future<void> getRecommendedGroups({bool reload = true}) async {
    if (reload) {
      emit(const FeaturedGroupsState.getRecommendedLoading());
    }

    try {
      final GetGroupsResponse response =
          await groupRepository.getSuggestedGroups(page: 1);

      emit(FeaturedGroupsState.getRecommendedSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(FeaturedGroupsState.getRecommendedFailure(e.toString()));
    }
  }
}
