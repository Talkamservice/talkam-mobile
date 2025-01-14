import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/models/get_countries_response.dart';
import 'package:talkam/common/models/get_states_response.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/ads/data/models/get_ads_pricing.dart';
import 'package:talkam/features/ads/data/models/initiate_payment_response.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/ads/presentation/screens/ads_flow_screens/preview_promotion_page.dart';
import 'package:talkam/features/ads/presentation/widgets/promotion_target_form.dart';
import 'package:talkam/features/home/dormain/mixins/refresh_app_mixin.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/presentation/bloc/create_post/create_post_cubit.dart';
import '../../../../core/theme/pallets.dart';
import 'budget_widget.dart';

class PromotePostSheet extends StatefulWidget {
  const PromotePostSheet({
    super.key,
    required this.type,
    required this.id,
    required this.onPromoted,
  });

  final String type;
  final int id;
  final VoidCallback onPromoted;

  @override
  State<PromotePostSheet> createState() => _PromotePostSheetState();
}

class _PromotePostSheetState extends State<PromotePostSheet> with RefreshAppMixin {
  late int _selectedIndex;
  CreatePostPayload? createPostPayload;
  int? _maxAge, _minAge, _dailyBudget, _duration;
  String? _selectedGender;
  List<TalkamCountry>? _country;
  TalkamState? _state;
  final AdsCubit targetsController = AdsCubit(injector.get());
  final AdsCubit budgetController = AdsCubit(injector.get());
  var bloc = CreatePostCubit(injector.get());
  var adsBloc = AdsCubit(injector.get());
  InitiatePaymentResponse? paymentInfo;
  late ScrollController _scrollController;
  GetPricingResponse? pricing;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _selectedIndex = 0;
    Future.delayed(
      Duration(milliseconds: 300),
      () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreatePostCubit>(
          create: (context) => bloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: Pallets.white,
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, bottom: 15, top: 5, left: 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button

                  Expanded(
                    flex: 2,
                    child: CustomOutlinedButton(
                      radius: 30,
                      padding: EdgeInsets.all(11),
                      onPressed: previousPage,
                      child: TextView(
                        text: _selectedIndex == 0 ? "Cancel" : "Back",
                      ),
                    ),
                  ),

                  15.horizontalSpace,

                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      bgColor: Pallets.tabBarBlue,
                      padding: EdgeInsets.all(12),
                      // padding: const EdgeInsets.symmetric(vertical: 5),
                      borderRadius: BorderRadius.circular(30),
                      onPressed: () {
                        nextPage(context);
                      },

                      elevation: 0,
                      text: getRightButtonText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    _selectedIndex == 2 ? PreviewPromotionHeader() : PromotePostHeader(type: widget.type),
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => adsBloc,
                child: BlocConsumer<AdsCubit, AdsState>(
                  listener: listener,
                  builder: (context, state) {
                    return IndexedStack(
                      index: _selectedIndex,
                      children: [
                        PromotionTargetWidget(
                            onValidated: ({
                              required country,
                              required gender,
                              required maxAge,
                              required minAge,
                            }) {
                              _country = country;
                              _selectedGender = gender;
                              _maxAge = maxAge;
                              _minAge = minAge;
                              // _state = state;

                              adsBloc.getPricing();
                            },
                            tittle: "",
                            controller: targetsController),
                        if (pricing != null)
                          BudgetWidget(
                              pricing: pricing,
                              onValidated: ({required dailyBudge, required duration}) {
                                _dailyBudget = dailyBudge;
                                _duration = duration;

                                validate(context);
                              },
                              controller: budgetController),
                        if (paymentInfo != null)
                          PreviewPromotionPage(
                            paymentInfo: paymentInfo!,
                          ),
                      ],
                    );
                  },
                ),
              ),
              20.verticalSpace
            ],
          ),
        ),
      ),
    );
  }

  void listener(BuildContext context, AdsState state) {
    state.maybeWhen(
      orElse: () {},
      promotionCreated: (result) {
        context.pop();
        setState(() {
          _selectedIndex++;
        });
        paymentInfo = result;
        setState(() {});
        // CustomDialogs.success("")
      },
      creatingPromotion: () {
        CustomDialogs.showLoading(context);
      },
      paymentSuccess: (result) {
        widget.onPromoted();
        context.pop();
        context.pop();
        CustomDialogs.success("Promotion created");
        refreshApp(reload: true);
        widget.onPromoted();
        // adsBloc.verifyPayment(result.txRef!);
      },
      paymentLoading: () {
        CustomDialogs.showLoading(context);
      },
      paymentFailed: (message) {
        context.pop();
        CustomDialogs.error(message);
      },
      verifyPaymentLoading: () {
        CustomDialogs.showLoading(context);
      },
      verifyPaymentSuccess: (result) {},
      promotionCreateFailed: (message) {
        context.pop();
        CustomDialogs.error(message);
      },
      verifyPaymentFailed: (message) {
        // context.pop();
        // CustomDialogs.error(message);
      },
      getPricingLoading: () {
        CustomDialogs.showLoading(context);
      },
      getPricingSuccess: (result) {
        context.pop();
        pricing = result;
        setState(() {
          _selectedIndex++;
        });
      },
      getPricingFailed: (error) {
        context.pop();
        CustomDialogs.error(error);
      },
    );
  }

  void validate(BuildContext context) {
    if (_country == null) {
      CustomDialogs.error("Please select country");
    } else {
      logger.i(widget.id);
      context.read<AdsCubit>().updatePayloadField(
          countryId: _country!,
          postId: widget.type.toLowerCase() == "post" ? widget.id : null,
          groupId: widget.type.toLowerCase() == "group" ? widget.id : null,
          stateId: _state,
          maxAge: _maxAge,
          minAge: _minAge,
          dailyBudget: _dailyBudget?.toDouble(),
          duration: _duration,
          gender: _selectedGender);

      context.read<AdsCubit>().createPromotion(context.read<AdsCubit>().payload!);
    }
  }

  // Navigating to the page before
  void previousPage() {
    _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    if (_selectedIndex == 0) {
      context.pop();
    }
    setState(() {
      if (_selectedIndex > 0) {
        _selectedIndex--;
      }
    });
  }

  // to navigate to the next page
  void nextPage(BuildContext context) {
    _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeIn);

    setState(() {
      if (_selectedIndex == 0) {
        targetsController.validateForms();
      } else if (_selectedIndex == 1) {
        budgetController.validateForms();
      } else if (_selectedIndex == 2) {
        pay(context);
      }
    });
  }

  void pay(BuildContext context) async {
    adsBloc.payForPromotion(paymentInfo!);
  }

  String get getRightButtonText => _selectedIndex == 1 ? "Preview" : (_selectedIndex == 2 ? "Create Promotion" : "Next");
}

class PromotePostHeader extends StatelessWidget {
  const PromotePostHeader({
    super.key,
    required this.type,
  });

  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextView(
                text: "Promote your  ${type.toLowerCase()}",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.close))
          ],
        ),
        Divider(
          thickness: 1,
        ),
        TextView(
          text: "Reach more people and make your group more visible to a large audience of people.",
          color: Pallets.textGrey,
        ),
        16.verticalSpace,
      ],
    );
  }
}

class PreviewPromotionHeader extends StatelessWidget {
  const PreviewPromotionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextView(
                text: "Preview promotion",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.close))
          ],
        ),
        Divider(
          thickness: 1,
        ),
        TextView(
          text: "Preview the information you have created.",
          color: Pallets.textGrey,
        ),
        16.verticalSpace,
      ],
    );
  }
}
