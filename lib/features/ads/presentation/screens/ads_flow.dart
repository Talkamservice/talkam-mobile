import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/app.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/navigation/routes.dart';
import 'package:talkam/core/services/flutterwave/flutterwave_payment_helper.dart';
import 'package:talkam/features/ads/data/models/get_ads_pricing.dart';
import 'package:talkam/features/ads/data/models/initiate_payment_response.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/ads/presentation/screens/ads_flow_screens/budget_page.dart';
import 'package:talkam/features/ads/presentation/screens/ads_flow_screens/create_ad_page.dart';
import 'package:talkam/features/ads/presentation/screens/ads_flow_screens/preview_promotion_page.dart';
import 'package:talkam/features/ads/presentation/screens/ads_review_screen.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/presentation/bloc/create_post/create_post_cubit.dart';
import 'package:talkam/features/post/presentation/screens/create_post_form.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/subscription/presentation/blocs/subscriptions_bloc/subscriptions_bloc_cubit.dart';

import '../../../../core/theme/pallets.dart';

class AdsFlowPage extends StatefulWidget {
  const AdsFlowPage({
    super.key,
  });

  @override
  State<AdsFlowPage> createState() => _AdsFlowPageState();
}

class _AdsFlowPageState extends State<AdsFlowPage> {
  late int _selectedIndex = 0;
  CreatePostPayload? createPostPayload;
  GetPricingResponse? pricing;


  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(milliseconds: 300),
      () {
        setState(() {});
      },
    );
  }

  // Navigating to the page before
  void previousPage() {
    setState(() {
      if (_selectedIndex > 0) {
        _selectedIndex--;
      }
    });
  }

  // to navigate to the next page
  void nextPage(BuildContext context) {
    setState(() {
      if (_selectedIndex == 0) {
        bloc.validateForms();
      }

      if (_selectedIndex == 1) {
        adsBloc.validateForms();
        return;
      }

      if (_selectedIndex == 2) {
        pay(context);
        return;
      }
    });
  }

  void pay(BuildContext context) async {
    adsBloc.payForPromotion(paymentInfo!);
  }

  var bloc = CreatePostCubit(injector.get());
  var adsBloc = AdsCubit(injector.get());

  InitiatePaymentResponse? paymentInfo;


  String getRightButtonText() {
    if (_selectedIndex == 1) {
      return "Preview";
    } else if (_selectedIndex == 2) {
      return "Create Promotion";
    } else {
      return "Next";

    }
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
        appBar: const CustomAppBar(
          padding: EdgeInsets.only(right: 10.0),
          tittleText: "Ads",
          centerTile: false,
          showDivider: true,
          // actions: [Icon(Icons.more_vert)],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, bottom: 15, top: 5),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  if (_selectedIndex != 0)
                    GestureDetector(
                      onTap: previousPage,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          "Back",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      nextPage(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                      decoration: BoxDecoration(
                        color: Pallets.tabBarBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        getRightButtonText(),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => adsBloc,
          child: BlocConsumer<AdsCubit, AdsState>(
            listener: (context, state) {
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
                  context.pop();
                  context.pop();
                  CustomDialogs.success("Promotion created");
                  CustomRoutes.goRouter.pushNamed(PageUrl.adsPage);
                },
                paymentFailed: (message) {
                  CustomDialogs.error(message);
                },

                verifyPaymentLoading: () {
                  CustomDialogs.showLoading(context);
                },
                verifyPaymentSuccess: (result) {
                  context.pop();
                  CustomDialogs.success("Promotion created");
                  CustomRoutes.goRouter.pushNamed(PageUrl.adsPage);
                },
                verifyPaymentFailed: (message) {
                  // context.pop();
                  // CustomDialogs.error(message);
                  context.pop();
                  CustomDialogs.success("Promotion created");
                  CustomRoutes.goRouter.pushNamed(PageUrl.adsPage);
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
            },
            builder: (context, state) {
              return IndexedStack(
                index: _selectedIndex,
                children: [
                  CreatePostForm(
                    onValidated: (payload) {
                      createPostPayload = payload;

                      context.read<AdsCubit>().updatePayloadField(data: {"type": "Post", "data": createPostPayload!.toJson()});

                      adsBloc.getPricing();
                      // logger.i(context.read<AdsCubit>().payload?.toMap());

                    },
                  ),
                  if (pricing != null)
                    BudgetPage(
                      pricing:pricing,
                    onValidated: () {
                      adsBloc.createPromotion(adsBloc.payload!);
                    },
                  ),
                  if (paymentInfo != null)
                    PreviewPromotionPage(
                      paymentInfo: paymentInfo!,
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
