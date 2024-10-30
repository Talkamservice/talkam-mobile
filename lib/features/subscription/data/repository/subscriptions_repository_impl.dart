import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/features/subscription/data/models/cancel_subscription_response.dart';
import 'package:talkam/features/subscription/data/models/get_plans_response.dart';
import 'package:talkam/features/subscription/data/models/get_subcriptions_response.dart';
import 'package:talkam/features/subscription/data/models/initiate_subscription_response.dart';
import 'package:talkam/features/subscription/dormain/repository/subscriptions_repository.dart';

class SubscriptionsRepositoryImpl extends SubscriptionsRepository {
  final NetworkService _networkService;

  SubscriptionsRepositoryImpl(this._networkService);

  @override
  Future<GetPlansResponse> getPlans() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getPlans,
        RequestMethod.get,
      );
      return GetPlansResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TalkamPlan> getPlanById(int planId) async {
    try {
      final response = await _networkService.call(
        '${UrlConfig.getPlanById}/$planId/show',
        RequestMethod.get,
      );
      return TalkamPlan.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetSubscriptionsResponse> getSubscriptions() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getSubscriptions,
        RequestMethod.get,
      );
      return GetSubscriptionsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TalkamSubscription> getSubscriptionById(int subscriptionId) async {
    try {
      final response = await _networkService.call(
        '${UrlConfig.getSubscriptionById}/$subscriptionId/show',
        RequestMethod.get,
      );
      return TalkamSubscription.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<InitiateSubscriptionResponse> initiateSubscription(String planDurationId) async {
    try {
      final response = await _networkService.call(
        UrlConfig.initiateSubscription,
        RequestMethod.post,
        data: {
          "plan_duration_id": planDurationId
        },
      );
      return InitiateSubscriptionResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CancelSubscriptionResponse> cancelSubscription(int subscriptionId) async {
    try {
      final response = await _networkService.call(
        '${UrlConfig.cancelSubscription}/$subscriptionId/cancel',
        RequestMethod.post,
      );
      return CancelSubscriptionResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
