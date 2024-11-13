import 'package:talkam/features/ads/data/models/ad_analytics_response.dart';
import 'package:talkam/features/ads/data/models/create_promotion_payload.dart';
import 'package:talkam/features/ads/data/models/initiate_payment_response.dart';
import 'package:talkam/features/ads/data/models/promotion_data.dart';

abstract class AdsRepository {
  Future<Promotion> getPromotions({String? status});

  Future<PromotionData> getPromotionById(String promotionId);
  Future<AdAnalyticsResponse> getAnalytics(bool isPost,String promotionId);

  Future<InitiatePaymentResponse> initiatePromotion(CreatePromotionPayload promotionData);

  Future<dynamic> deletePromotion(String promotionId);
  Future<InitiatePaymentResponse> reinitiatePromotion(String promotionId);

  Future<dynamic> paymentCallback(String reference);
  Future<dynamic> updateAd(String promotionId,String status);
}
