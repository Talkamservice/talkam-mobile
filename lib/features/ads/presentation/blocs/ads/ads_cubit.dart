import 'package:bloc/bloc.dart';
import 'package:flutterwave_standard_smart/flutterwave.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/common/models/get_countries_response.dart';
import 'package:talkam/common/models/get_states_response.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/routes.dart';
import 'package:talkam/core/services/flutterwave/flutterwave_payment_helper.dart';
import 'package:talkam/features/ads/data/models/ad_analytics_response.dart';
import 'package:talkam/features/ads/data/models/create_promotion_payload.dart';
import 'package:talkam/features/ads/data/models/get_ads_calculation.dart';
import 'package:talkam/features/ads/data/models/get_ads_pricing.dart';
import 'package:talkam/features/ads/data/models/initiate_payment_response.dart';
import 'package:talkam/features/ads/data/models/promotion_data.dart';
import 'package:talkam/features/ads/data/models/update_stat_payload.dart';
import 'package:talkam/features/ads/dormain/repository/ads_repository.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/subscription/presentation/blocs/subscriptions_bloc/subscriptions_bloc_cubit.dart';

part 'ads_state.dart';

part 'ads_cubit.freezed.dart';

class AdsCubit extends Cubit<AdsState> {
  final AdsRepository adsRepository;

  AdsCubit(this.adsRepository) : super(const AdsState.initial());

  CreatePromotionPayload? payload;

  bool formsValidated = false;

  // Fetch Promotions
  Future<void> fetchPromotions({String? status}) async {
    try {
      emit(const AdsState.fetchingPromotions());
      final promotions = await adsRepository.getPromotions(status: status);
      emit(AdsState.promotionsLoaded(promotions));
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      emit(AdsState.promotionsLoadFailed(e.toString()));
    }
  }

  // Verify Payment
  Future<void> verifyPayment(String reference) async {
    try {
      emit(const AdsState.verifyPaymentLoading());
      final response = await adsRepository.paymentCallback(reference);
      emit(AdsState.verifyPaymentSuccess(response));
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      emit(AdsState.verifyPaymentFailed(e.toString()));
    }
  }

  // Fetch Promotion by ID
  Future<void> fetchPromotionById(String promotionId) async {
    try {
      emit(const AdsState.fetchingPromotionById());
      final promotion = await adsRepository.getPromotionById(promotionId);
      emit(AdsState.promotionByIdLoaded(promotion));
    } catch (e) {
      emit(AdsState.promotionByIdLoadFailed(e.toString()));
    }
  }

  // Create Promotion
  Future<void> createPromotion(CreatePromotionPayload promotionData) async {
    try {
      emit(const AdsState.creatingPromotion());
      final result = await adsRepository.initiatePromotion(promotionData);
      emit(AdsState.promotionCreated(result));
    } catch (e) {
      emit(AdsState.promotionCreateFailed(e.toString()));
    }
  }

  // Create Promotion
  Future<void> reinitiatePromotion(String promotionId) async {
    try {
      emit(const AdsState.creatingPromotion());
      final result = await adsRepository.reinitiatePromotion(promotionId);
      emit(AdsState.promotionCreated(result));
    } catch (e) {
      emit(AdsState.promotionCreateFailed(e.toString()));
    }
  }

  // Get Pricing
  Future<void> getPricing() async {
    try {
      emit(const AdsState.getPricingLoading());
      final pricing = await adsRepository.getAdsPricing();
      emit(AdsState.getPricingSuccess(pricing));
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      emit(AdsState.getPricingFailed(e.toString()));
    }
  }

  // Get Pricing
  Future<void> getCalculation(
      {required double amount,
      required double dailyBudget,
      required double duration,
      required double impressions}) async {
    try {
      emit(const AdsState.getCalculationLoading());
      final calculationResponse = await adsRepository.calculateAdsCost(
          amount: amount,
          dailyBudget: dailyBudget,
          duration: duration,
          impressions: impressions);
      emit(AdsState.getCalculationSuccess(calculationResponse));
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      emit(AdsState.getPricingFailed(e.toString()));
    }
  }

  void validateForms() {
    // Triggers form validation for create post forms
    emit(const AdsState.validateFormsState());

    // Resets State Back to initial
    emit(const AdsState.initial());
  }

  void validateFormsSuccess() {
    formsValidated = true;
    emit(const AdsState.validateFormsSuccessState());
  }

  // Remove Promotion
  Future<void> removePromotion(String promotionId) async {
    try {
      emit(const AdsState.removingPromotion());
      final result = await adsRepository.deletePromotion(promotionId);
      emit(AdsState.promotionRemoved(result));
    } catch (e) {
      emit(AdsState.promotionRemoveFailed(e.toString()));
    }
  }

  // Update Promotion

  Future<void> updatePromotion(String promotionId, String status) async {
    try {
      emit(const AdsState.updateAdLoading());
      final result = await adsRepository.updateAd(promotionId, status);
      emit(AdsState.updateAdSuccess(result));
    } catch (e) {
      emit(AdsState.updateAdFailed(e.toString()));
    }
  }

  // Update Stats
  Future<void> updateStats(UpdateStatPayLoad payload) async {
    try {
      emit(const AdsState.updateStatsLoading());
      final result = await adsRepository.updateStatPayload(payload);
      emit(AdsState.updateStatsSuccess(true));
    } catch (e) {
      emit(AdsState.updateStatsFailed(e.toString()));
    }
  }

  // Save Post Share Stat (v2) — best-effort, matching how callers already
  // treat the share action as fire-and-forget alongside the native share
  // sheet.
  Future<void> savePostShareStat(String postId) async {
    try {
      await adsRepository.savePostShareStat(postId);
    } catch (e) {
      logger.e(e);
    }
  }

  // Get Analytics/Stats

  Future<void> getAnalytics(
    bool isPost,
    String id,
  ) async {
    try {
      emit(const AdsState.getAnalyticsLoading());
      final result = await adsRepository.getAnalytics(isPost, id);
      emit(AdsState.getAnalyticsSuccess(result));
    } catch (e) {
      emit(AdsState.getAnalyticsFailed(e.toString()));
    }
  }

  Future<void> payForPromotion(InitiatePaymentResponse paymentInfo) async {
    try {
      emit(const AdsState.paymentLoading());

      var user = injector.get<ProfileBloc>().appUser;

      logger.i(paymentInfo.data.metadata);

      var paymentResponse = await PaymentHelper().makePayment(
          rootNavigatorKey.currentContext!,
          FlutterRequirements(
            amount: paymentInfo.data.amount,
            referenceNumber: paymentInfo.data.reference,
            currency: paymentInfo.data.currency,
            meta: paymentInfo.data.metadata,
            email: user?.email,
            fullName: user?.name,
          ));

      injector.get<ProfileBloc>().add(const GetRemoteUser());

      if (paymentResponse != null && (paymentResponse.success ?? false)) {
        Future.delayed(
          Duration(seconds: 3),
          () {
            emit(AdsState.paymentSuccess(paymentResponse));
          },
        );
      } else {
        emit(AdsState.paymentFailed("Payment failed"));
      }
      injector.get<SubscriptionsCubit>().getPlans(reload: true);
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      emit(AdsState.paymentFailed(e.toString()));
    }
  }

  void updatePayloadField({
    int? postId,
    int? groupId,
    List<TalkamCountry>? countryId,
    TalkamState? stateId,
    int? minAge,
    int? maxAge,
    String? gender,
    String? type,
    double? dailyBudget,
    int? duration,
    Map<String, dynamic>? data,
  }) {
    if (payload == null) {
      payload = CreatePromotionPayload(
          postId: postId,
          country: countryId,
          state: stateId,
          minAge: minAge,
          maxAge: maxAge,
          gender: gender,
          dailyBudget: dailyBudget,
          duration: duration,
          data: data,
          groupId: groupId);
    } else {
      payload = payload?.copyWith(
        postId: postId ?? payload?.postId,
        groupId: groupId ?? payload?.groupId,
        country: countryId ?? payload?.country,
        state: stateId ?? payload?.state,
        minAge: minAge ?? payload?.minAge,
        maxAge: maxAge ?? payload?.maxAge,
        gender: gender ?? payload?.gender,
        dailyBudget: dailyBudget ?? payload?.dailyBudget,
        duration: duration ?? payload?.duration,
        data: data ?? payload?.data,
      );
    }
  }
}
