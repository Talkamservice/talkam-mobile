part of 'subscriptions_bloc_cubit.dart';


@freezed
class SubscriptionsState with _$SubscriptionsState {
  const factory SubscriptionsState.initial() = _Initial;

  // Get Plans States
  const factory SubscriptionsState.getPlansLoading() = _GetPlansLoading;
  const factory SubscriptionsState.getPlansSuccess(GetPlansResponse response) = _GetPlansSuccess;
  const factory SubscriptionsState.getPlansFailure(String error) = _GetPlansFailure;

  // Get Plan by ID States
  const factory SubscriptionsState.getPlanByIdLoading() = _GetPlanByIdLoading;
  const factory SubscriptionsState.getPlanByIdSuccess(TalkamPlan response) = _GetPlanByIdSuccess;
  const factory SubscriptionsState.getPlanByIdFailure(String error) = _GetPlanByIdFailure;

  // Get Subscriptions States
  const factory SubscriptionsState.getSubscriptionsLoading() = _GetSubscriptionsLoading;
  const factory SubscriptionsState.getSubscriptionsSuccess(GetSubscriptionsResponse response) = _GetSubscriptionsSuccess;
  const factory SubscriptionsState.getSubscriptionsFailure(String error) = _GetSubscriptionsFailure;

  // Get Subscription by ID States
  const factory SubscriptionsState.getSubscriptionByIdLoading() = _GetSubscriptionByIdLoading;
  const factory SubscriptionsState.getSubscriptionByIdSuccess(TalkamSubscription response) = _GetSubscriptionByIdSuccess;
  const factory SubscriptionsState.getSubscriptionByIdFailure(String error) = _GetSubscriptionByIdFailure;

  // Initiate Subscription States
  const factory SubscriptionsState.initiateSubscriptionLoading() = _InitiateSubscriptionLoading;
  const factory SubscriptionsState.initiateSubscriptionSuccess(InitiateSubscriptionResponse response) = _InitiateSubscriptionSuccess;
  const factory SubscriptionsState.initiateSubscriptionFailure(String error) = _InitiateSubscriptionFailure;

  // Cancel Subscription States
  const factory SubscriptionsState.cancelSubscriptionLoading() = _CancelSubscriptionLoading;
  const factory SubscriptionsState.cancelSubscriptionSuccess() = _CancelSubscriptionSuccess;
  const factory SubscriptionsState.cancelSubscriptionFailure(String error) = _CancelSubscriptionFailure;
}
