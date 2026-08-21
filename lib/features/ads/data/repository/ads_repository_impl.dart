import 'package:dio/dio.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/ads/data/models/ad_analytics_response.dart';
import 'package:talkam/features/ads/data/models/create_promotion_payload.dart';
import 'package:talkam/features/ads/data/models/get_ads_calculation.dart';
import 'package:talkam/features/ads/data/models/get_ads_pricing.dart';
import 'package:talkam/features/ads/data/models/initiate_payment_response.dart';
import 'package:talkam/features/ads/data/models/promotion_data.dart';
import 'package:talkam/features/ads/data/models/update_stat_payload.dart';
import 'package:talkam/features/ads/dormain/repository/ads_repository.dart';

class AdsRepositoryImpl extends AdsRepository {
  final NetworkService _networkService;

  /// Post stats save/fetch have migrated to /api/v2 — the rest of this
  /// repository (promotions, payments, pricing) still uses v1.
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  /// Form-data requests must build their own [Options] so Dio can infer the
  /// multipart content type (the default options force `application/json`).
  /// The Authorization header is automatically injected by [_AuthInterceptor].
  Options get _formOptions => Options(headers: {
        "Accept": "application/json",
      });

  AdsRepositoryImpl(this._networkService);

  @override
  Future<Promotion> getPromotions({String? status}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.getPromotions, RequestMethod.get,
          queryParams: {"status": status});
      return Promotion.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PromotionData> getPromotionById(String promotionId) async {
    try {
      final response = await _networkService.call(
        '${UrlConfig.getPromotionById}/$promotionId/show',
        RequestMethod.get,
      );

      var promotion = PromotionData.fromJson(response.data["data"]);

      return promotion;
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);
      rethrow;
    }
  }

  @override
  Future<InitiatePaymentResponse> initiatePromotion(
      CreatePromotionPayload promotionData) async {
    try {
      final response = await _networkService.call(
        UrlConfig.initiatePromotion,
        RequestMethod.post,
        data: promotionData.toMap(),
      );
      return InitiatePaymentResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<dynamic> deletePromotion(String promotionId) async {
    try {
      final response = await _networkService.call(
        '${UrlConfig.promotions}/$promotionId/delete',
        RequestMethod.delete,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future paymentCallback(String reference) async {
    try {
      final response = await _networkService.call(
          UrlConfig.paymentCallback, RequestMethod.post,
          data: {"reference": reference});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future updateAd(String promotionId, String status) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.promotions}/$promotionId/update', RequestMethod.post,
          data: {"status": status});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<InitiatePaymentResponse> reinitiatePromotion(
      String promotionId) async {
    try {
      final response = await _networkService.call(
        '${UrlConfig.promotions}/$promotionId/reinitiate',
        RequestMethod.post,
      );
      return InitiatePaymentResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AdAnalyticsResponse> getAnalytics(bool isPost, String id) async {
    try {
      // v2 only covers post stats (per the spec, post_id-keyed); group stats
      // stay on v1 until a v2 equivalent exists.
      final response = isPost
          ? await _v2.call(UrlConfigV2.postStatsFetch, RequestMethod.get,
              queryParams: {"post_id": id})
          : await _networkService.call(UrlConfig.analytics, RequestMethod.get,
              queryParams: {"group_id": id});
      return AdAnalyticsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateStatPayload(UpdateStatPayLoad payload) async {
    try {
      // Same underlying PostStatsService as v1 (post_id, group_id and
      // time_spent are all independently-nullable there), just mounted
      // under the v2 route — no reason for this to stay on the v1 host.
      final response = await _v2.call(
        UrlConfigV2.postStatsSave,
        RequestMethod.post,
        data: payload.toJson(),
      );
      return response.data;
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> savePostShareStat(String postId) async {
    try {
      await _v2.call(
        UrlConfigV2.postStatsSave,
        RequestMethod.post,
        formData: FormData.fromMap({"post_id": postId, "shares": true}),
        options: _formOptions,
      );
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<GetPricingResponse> getAdsPricing() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getPricing,
        RequestMethod.get,
      );
      return GetPricingResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<GetCalculationResponse> calculateAdsCost(
      {required double amount,
      required double dailyBudget,
      required double duration,
      required double impressions}) async {
    try {
      final response = await _networkService.call(
        UrlConfig.calculatePrice,
        RequestMethod.get,
        queryParams: {
          "amount": amount,
          "daily_budget": dailyBudget,
          "duration": duration,
          "impressions": impressions
        },
      );
      return GetCalculationResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      rethrow;
    }
  }
}
