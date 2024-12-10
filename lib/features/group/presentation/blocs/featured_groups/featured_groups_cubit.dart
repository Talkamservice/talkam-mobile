import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/data/models/groups_filter_model.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

part 'featured_groups_state.dart';

part 'featured_groups_cubit.freezed.dart';

class FeaturedGroupsCubit extends Cubit<FeaturedGroupsState> {
  FeaturedGroupsCubit(this.groupRepository) : super(const FeaturedGroupsState.initial());

  final GroupsRepository groupRepository;

  List<TalkamGroup> _promotedGroups = []; // Track promoted groups
  int _promotedIndex = 0; // Current index of promoted groups

  Future<void> getRecommendedGroups({bool reload = true}) async {
    if (reload) {
      emit(const FeaturedGroupsState.getRecommendedLoading());
    }

    try {
      // Fetch recommended and promoted groups
      final GetGroupsResponse recommendedResponse = await groupRepository.getGroups(
        page: 1,
        filter: GroupsFilterModel.recommended(),
      );
      final GetGroupsResponse promotedResponse = await groupRepository.getPromotedGroups();

      // Save promoted groups and reset index
      _promotedGroups = promotedResponse.groups ?? [];
      _promotedIndex = 0;

      // Merge groups
      final mergedGroups = _mergeGroups(recommendedResponse.groups ?? [], _promotedGroups);

      // Emit success state with merged groups
      final mergedResponse = recommendedResponse.copyWith(
        groups: mergedGroups,
      );

      emit(FeaturedGroupsState.getRecommendedSuccess(mergedResponse));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(FeaturedGroupsState.getRecommendedFailure(e.toString()));
    }
  }

  // Future<void> loadMore(GetGroupsResponse previousGroups) async {
  //   try {
  //     // Fetch more recommended groups
  //     final GetGroupsResponse recommendedResponse = await groupRepository.getGroups(
  //       page: previousGroups.data.paginationMeta.currentPage + 1,
  //       filter: GroupsFilterModel.recommended(),
  //     );
  //
  //     // Check if promoted groups are exhausted
  //     if (_promotedIndex >= _promotedGroups.length) {
  //       final GetGroupsResponse promotedResponse = await groupRepository.getPromotedGroups();
  //       _promotedGroups = promotedResponse.data.data;
  //       _promotedIndex = 0;
  //     }
  //
  //     // Merge new recommended groups with remaining promoted groups
  //     final mergedGroups = _mergeGroups(
  //       [...previousGroups.data.data, ...recommendedResponse.data.data],
  //       _promotedGroups,
  //     );
  //
  //     // Emit success state with updated groups
  //     final updatedResponse = recommendedResponse.copyWith(
  //       data: recommendedResponse.data.copyWith(data: mergedGroups),
  //     );
  //
  //     emit(FeaturedGroupsState.getRecommendedSuccess(updatedResponse));
  //   } catch (e, stack) {
  //     logger.e(e.toString(), stackTrace: stack);
  //     emit(FeaturedGroupsState.getRecommendedFailure(e.toString()));
  //   }
  // }

  List<TalkamGroup> _mergeGroups(List<TalkamGroup> recommendedGroups, List<TalkamGroup> promotedGroups) {
    final List<TalkamGroup> mergedGroups = [];
    int recommendedIndex = 0;
    int count = 0;

    // Merge recommended and promoted groups
    while (recommendedIndex < recommendedGroups.length) {
      mergedGroups.add(recommendedGroups[recommendedIndex]);
      recommendedIndex++;
      count++;

      if (count == 2 && _promotedIndex < promotedGroups.length) {
        mergedGroups.add(promotedGroups[_promotedIndex]);
        _promotedIndex++;
        count = 0;
      }
    }

    // Add remaining promoted groups if any
    while (_promotedIndex < promotedGroups.length) {
      mergedGroups.add(promotedGroups[_promotedIndex]);
      _promotedIndex++;
    }

    return mergedGroups;
  }
}
