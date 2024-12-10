part of 'featured_groups_cubit.dart';

@freezed
class FeaturedGroupsState with _$FeaturedGroupsState {
  const factory FeaturedGroupsState.initial() = _Initial;

  const factory FeaturedGroupsState.getRecommendedLoading() = _GetRecommendedLoading;
  const factory FeaturedGroupsState.getRecommendedSuccess(GetGroupsResponse response) = _GetRecommendedSuccess;
  const factory FeaturedGroupsState.getRecommendedFailure(String error) = _GetRecommendedFailure;


}
