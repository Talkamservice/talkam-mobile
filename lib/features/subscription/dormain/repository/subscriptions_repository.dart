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

  /// Verifies a Flutterwave transaction server-side by its `reference`.
  /// Mirrors `BookingRepository.paymentCallback` — the Flutterwave SDK's
  /// local `success` flag depends on its in-app WebView reaching a
  /// redirect page, which can misreport even when the charge actually
  /// went through, so this is called regardless of that flag and the
  /// caller re-checks the plan's real status afterward instead of
  /// trusting the SDK response directly.
  Future<void> paymentCallback(String reference);
}
