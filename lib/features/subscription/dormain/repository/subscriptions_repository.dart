import 'package:talkam/features/subscription/data/models/cancel_subscription_response.dart';
import 'package:talkam/features/subscription/data/models/get_plans_response.dart';
import 'package:talkam/features/subscription/data/models/get_subcriptions_response.dart';
import 'package:talkam/features/subscription/data/models/initiate_subscription_response.dart';

abstract class SubscriptionsRepository {
  Future<GetPlansResponse> getPlans();
  Future<TalkamPlan> getPlanById(int planId);
  Future<GetSubscriptionsResponse> getSubscriptions();
  Future<TalkamSubscription> getSubscriptionById(int subscriptionId);
  Future<InitiateSubscriptionResponse> initiateSubscription(String planDurationId);
  Future<CancelSubscriptionResponse> cancelSubscription(int subscriptionId);
}
