import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/features/ads/data/models/ad_analytics_response.dart';
import 'package:talkam/features/ads/data/models/create_promotion_payload.dart';
import 'package:talkam/features/ads/data/models/initiate_payment_response.dart';
import 'package:talkam/features/ads/data/models/promotion_data.dart';
import 'package:talkam/features/ads/data/models/update_stat_payload.dart';
import 'package:talkam/features/ads/dormain/repository/ads_repository.dart';

class AdsRepositoryImpl extends AdsRepository {
  final NetworkService _networkService;

  AdsRepositoryImpl(this._networkService);

  @override
  Future<Promotion> getPromotions({String? status}) async {
    try {
      final response = await _networkService.call(UrlConfig.getPromotions, RequestMethod.get, queryParams: {"status": status});
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
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<InitiatePaymentResponse> initiatePromotion(CreatePromotionPayload promotionData) async {
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
      final response = await _networkService.call(UrlConfig.paymentCallback, RequestMethod.post, data: {"reference": reference});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future updateAd(String promotionId, String status) async {
    try {
      final response = await _networkService.call('${UrlConfig.promotions}/$promotionId/update', RequestMethod.post, data: {"status": status});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<InitiatePaymentResponse> reinitiatePromotion(String promotionId) async {
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
  Future<AdAnalyticsResponse> getAnalytics(bool isPost, String promotionId) async {
    try {
      final response = await _networkService
          .call(UrlConfig.analytics, RequestMethod.get, queryParams: {if (isPost) "post_id": promotionId, if (!isPost) "group_id": promotionId});
      return AdAnalyticsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateStatPayload(UpdateStatPayLoad payload) async {
    try {
      final response = await _networkService.call(
        UrlConfig.updateStat,
        RequestMethod.post,
        data: payload.toJson(),
      );
      return response.data;
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      rethrow;
    }
  }
}
