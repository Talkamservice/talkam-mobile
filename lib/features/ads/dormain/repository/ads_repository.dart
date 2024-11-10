import 'package:talkam/features/ads/data/models/create_promotion_payload.dart';
import 'package:talkam/features/ads/data/models/initiate_payment_response.dart';
import 'package:talkam/features/ads/data/models/promotion_data.dart';

abstract class AdsRepository {
  Future<Promotion> getPromotions({String? status});

  Future<PromotionData> getPromotionById(String promotionId);

  Future<InitiatePaymentResponse> initiatePromotion(CreatePromotionPayload promotionData);

  Future<dynamic> deletePromotion(String promotionId);

  Future<dynamic> paymentCallback(String reference);
}
