import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/api_error.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/subscription/data/models/get_plans_response.dart';
import 'package:talkam/features/subscription/presentation/blocs/subscriptions_bloc/subscriptions_bloc_cubit.dart';
import 'package:talkam/features/subscription/presentation/widgets/plan_item.dart';
import 'package:talkam/gen/assets.gen.dart';

enum PlanDurations { Annually, Monthly }

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  TalkamPlanDuration? planDuration;
  TalkamPlan? currentPlan;
  int durationIndex = 0;

  // final _bloc = injector.get<SubscriptionBloc>();

  @override
  void initState() {
    injector.get<SubscriptionsCubit>().getPlans(reload: subscriptionPlans.isEmpty);
    currentPlan = subscriptionPlans.firstWhereOrNull(
      (element) => element.durations.isNotEmpty,
    );
    planDuration = firstDurations.firstOrNull;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showDivider: true,
        bgColor: Pallets.white,
        tittle: TextView(
          text: "Subscription",
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTile: false,
      ),
      body: BlocConsumer<SubscriptionsCubit, SubscriptionsState>(
        bloc: injector.get(),
        listener: (context, state) {
          state.maybeWhen(
              orElse: () => 0.verticalSpace,
              getPlansSuccess: (response) {
                if (currentPlan == null) {
                  currentPlan = subscriptionPlans.firstWhereOrNull(
                    (element) => element.durations.isNotEmpty,
                  );
                  planDuration = firstDurations.firstOrNull;
                }

                // planDuration = firstDurations.firstOrNull;
                // currentPlan = subscriptionPlans.firstWhere(
                //   (element) => element.durations.isNotEmpty,
                // );
              });
          setState(() {});
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => 0.verticalSpace,
            getPlansSuccess: (response) {
              return NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          20.verticalSpace,
                          const TextView(
                            text: 'Upgrade to TalkAM Plus',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          6.verticalSpace,
                          const TextView(
                            text: 'Enjoy great experiences with TalkAM plus.',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          20.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: PlanTab(
                              durations: firstDurations,
                              selectedDuration: planDuration,
                              firstDuration: firstDurations.firstOrNull,
                              onSelected: (TalkamPlanDuration _planDuration, index) {
                                planDuration = _planDuration;
                                durationIndex = index;
                                setState(() {});
                              },
                              currentPlan: currentPlan,
                            ),
                          ),
                          19.verticalSpace
                        ],
                      ),
                    ),
                  ];
                },
                body: OverflowBar(
                  children: [
                    SizedBox(
                      height: 1.sh,
                      child: PageView(
                        // itemCount: subscriptionPlans.length,
                        padEnds: true,
                        key: const PageStorageKey("Key"),
                        controller: PageController(viewportFraction: 0.88),
                        // itemCount: subscriptionPlans.length,

                        onPageChanged: (value) {
                          currentPlan = subscriptionPlans.toList()[value];
                          planDuration = firstDurations.firstOrNull;
                          durationIndex = 0;
                          logger.i(currentPlan?.name);
                          setState(() {});
                        },

                        children: subscriptionPlans
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  children: [
                                    PlanItem(
                                      plan: e,
                                      durationIndex: durationIndex,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
            getPlansFailure: (error) => AppErrorWidget(
              message: error,
              onTap: () {
                injector.get<SubscriptionsCubit>().getPlans();
              },
            ),
            getPlansLoading: () => Center(
              child: CustomDialogs.getLoading(size: 50),
            ),
          );
        },
      ),
    );
  }

  List<TalkamPlanDuration> get firstDurations {
    return ((currentPlan?.durations ?? []).isNotEmpty
            ? currentPlan?.durations ?? []
            : subscriptionPlans
                .firstWhereOrNull(
                  (element) => element.durations.isNotEmpty,
                )
                ?.durations) ??
        [];
  }

  List<TalkamPlan> get subscriptionPlans => injector.get<SubscriptionsCubit>().subscriptionPlans;
}

class PlanTab extends StatefulWidget {
  PlanTab({
    super.key,
    required this.durations,
    this.firstDuration,
    required this.onSelected,
    this.selectedDuration,
    required this.currentPlan,
  });

  final List<TalkamPlanDuration> durations;
  TalkamPlanDuration? firstDuration;
  final TalkamPlanDuration? selectedDuration;
  final TalkamPlan? currentPlan;
  final Function(TalkamPlanDuration, int) onSelected;

  @override
  State<PlanTab> createState() => _PlanTabState();
}

class _PlanTabState extends State<PlanTab> with AutomaticKeepAliveClientMixin {
  late TalkamPlanDuration duration;

  @override
  void initState() {
    duration = widget.durations.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<SubscriptionsCubit, SubscriptionsState>(
      bloc: injector.get(),
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            getPlansSuccess: (response) {
              duration = widget.durations.first;
              widget.onSelected(duration, widget.durations.indexOf(duration));
              logger.i(widget.durations.indexOf(duration));
            });
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(45), color: Pallets.white, border: Border.all(color: Pallets.borderGrey)),
          child: Row(
            children: widget.durations
                .map(
                  (e) => Expanded(
                    child: InkWell(
                      onTap: () {
                        duration = e;
                        widget.onSelected(duration, widget.durations.indexOf(e));
                        setState(() {});
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(33), color: isSelected(e) ? Pallets.blueBubbleColor : Pallets.white),
                        child: Center(
                            child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextView(
                              text: e.frequency,
                              fontSize: 13,
                              color: isSelected(e) ? Pallets.white : Pallets.black,
                            ),
                            5.horizontalSpace,
                            if ((widget.currentPlan?.discount ?? 0) > 0 && e.frequency.toString().toLowerCase() == "yearly")
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    gradient: const LinearGradient(colors: [
                                      Color(0xffD1F2F7),
                                      Color(0xffFDFFFF),
                                      Color(0xffD1F2F7),
                                    ])),
                                child: TextView(
                                  text: "Save ${widget.currentPlan?.discount}%",
                                  fontSize: 10,
                                ),
                              )
                          ],
                        )),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  bool isSelected(TalkamPlanDuration e) => e == widget.selectedDuration;

  @override
  bool get wantKeepAlive => true;
}
