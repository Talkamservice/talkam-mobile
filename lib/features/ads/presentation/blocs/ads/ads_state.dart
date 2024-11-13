part of 'ads_cubit.dart';

@freezed
class AdsState with _$AdsState {
  // Initial state when the cubit is first created
  const factory AdsState.initial() = _Initial;

  // Fetch Promotions states
  const factory AdsState.fetchingPromotions() = _FetchingPromotions;

  const factory AdsState.promotionsLoaded(dynamic promotions) = _PromotionsLoaded;

  const factory AdsState.promotionsLoadFailed(String message) = _PromotionsLoadFailed;

  // Fetch Promotion by ID states
  const factory AdsState.fetchingPromotionById() = _FetchingPromotionById;

  const factory AdsState.promotionByIdLoaded(dynamic promotion) = _PromotionByIdLoaded;

  const factory AdsState.promotionByIdLoadFailed(String message) = _PromotionByIdLoadFailed;

  // Create Promotion states
  const factory AdsState.creatingPromotion() = _CreatingPromotion;

  const factory AdsState.promotionCreated(dynamic result) = _PromotionCreated;

  const factory AdsState.promotionCreateFailed(String message) = _PromotionCreateFailed;

  // Remove Promotion states
  const factory AdsState.removingPromotion() = _RemovingPromotion;

  const factory AdsState.promotionRemoved(dynamic result) = _PromotionRemoved;

  const factory AdsState.promotionRemoveFailed(String message) = _PromotionRemoveFailed;

  //Validation  states
  const factory AdsState.validateFormsState() = _ValidateState;

  const factory AdsState.validateFormsSuccessState() = _ValidateSuccess;

  // Remove Promotion states
  const factory AdsState.paymentLoading() = _PaymentLoading;

  const factory AdsState.paymentSuccess(ChargeResponse result) = _PaymentSuccess;

  const factory AdsState.paymentFailed(String message) = _PaymentFailed;

  // Verify Payment states
  const factory AdsState.verifyPaymentLoading() = _VerifyPaymentLoading;

  const factory AdsState.verifyPaymentSuccess(dynamic result) = _VerifyPaymentSuccess;

  const factory AdsState.verifyPaymentFailed(String message) = _VarifyPaymentFailed;

  // Update ad states
  const factory AdsState.updateAdLoading() = _UpdateAdLoading;

  const factory AdsState.updateAdSuccess(dynamic result) = _UpdateAdSuccess;

  const factory AdsState.updateAdFailed(String message) = _UpdateAdFailure;

  // Update ad states
  const factory AdsState.getAnalyticsLoading() = _GetAnalyticsLoading;

  const factory AdsState.getAnalyticsSuccess(AdAnalyticsResponse result) = _GetAnalyticsSuccess;

  const factory AdsState.getAnalyticsFailed(String message) = _GetAnalyticsFailed;
}
