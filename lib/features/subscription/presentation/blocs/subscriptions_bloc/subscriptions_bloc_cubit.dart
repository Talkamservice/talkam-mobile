import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/subscription/data/models/get_plans_response.dart';
import 'package:talkam/features/subscription/data/models/get_subcriptions_response.dart';
import 'package:talkam/features/subscription/data/models/initiate_subscription_response.dart';
import 'package:talkam/features/subscription/dormain/repository/subscriptions_repository.dart';

part 'subscriptions_bloc_state.dart';

part 'subscriptions_bloc_cubit.freezed.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  final SubscriptionsRepository subscriptionsRepository;

  SubscriptionsCubit(this.subscriptionsRepository) : super(const SubscriptionsState.initial());
  List<TalkamPlan> subscriptionPlans = [];

  Future<void> getPlans({bool? reload = true}) async {
    if (reload!) {
      emit(const SubscriptionsState.getPlansLoading());
    }
    try {
      final response = await subscriptionsRepository.getPlans();
      subscriptionPlans = response.data;
      emit(SubscriptionsState.getPlansSuccess(response));
    } catch (e,stack) {
      logger.e(e);
      logger.e(stack);
      emit(SubscriptionsState.getPlansFailure(e.toString()));
    }
  }

  Future<void> getPlanById(int planId) async {
    emit(const SubscriptionsState.getPlanByIdLoading());
    try {
      final response = await subscriptionsRepository.getPlanById(planId);
      emit(SubscriptionsState.getPlanByIdSuccess(response));
    } catch (e) {
      emit(SubscriptionsState.getPlanByIdFailure(e.toString()));
    }
  }

  Future<void> getSubscriptions() async {
    emit(const SubscriptionsState.getSubscriptionsLoading());
    try {
      final response = await subscriptionsRepository.getSubscriptions();
      emit(SubscriptionsState.getSubscriptionsSuccess(response));
    } catch (e) {
      emit(SubscriptionsState.getSubscriptionsFailure(e.toString()));
    }
  }

  Future<void> getSubscriptionById(int subscriptionId) async {
    emit(const SubscriptionsState.getSubscriptionByIdLoading());
    try {
      final response = await subscriptionsRepository.getSubscriptionById(subscriptionId);
      emit(SubscriptionsState.getSubscriptionByIdSuccess(response));
    } catch (e) {
      emit(SubscriptionsState.getSubscriptionByIdFailure(e.toString()));
    }
  }

  Future<void> initiateSubscription(String planDurationId) async {
    emit(const SubscriptionsState.initiateSubscriptionLoading());
    try {
      final response = await subscriptionsRepository.initiateSubscription(planDurationId);
      emit(SubscriptionsState.initiateSubscriptionSuccess(response));
    }catch (e,stack) {
      logger.e(e);
      logger.e(stack);
      emit(SubscriptionsState.initiateSubscriptionFailure(e.toString()));
    }
  }

  Future<void> cancelSubscription(int subscriptionId) async {
    emit(const SubscriptionsState.cancelSubscriptionLoading());
    try {
      await subscriptionsRepository.cancelSubscription(subscriptionId);
      emit(const SubscriptionsState.cancelSubscriptionSuccess());
    } catch (e) {
      emit(SubscriptionsState.cancelSubscriptionFailure(e.toString()));
    }
  }
}
