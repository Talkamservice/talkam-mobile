import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/app.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/ads/data/models/promotion_data.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/ads/presentation/screens/empty_ad_page.dart';
import 'package:talkam/features/ads/presentation/widgets/promotion_item.dart';
import 'package:talkam/features/post/data/models/post_test_models.dart';

class ClosedAdsScreen extends StatefulWidget {
  ClosedAdsScreen({super.key});


  @override
  State<ClosedAdsScreen> createState() => _ClosedAdsScreenState();
}

class _ClosedAdsScreenState extends State<ClosedAdsScreen> {
  @override
  void initState() {
    bloc.fetchPromotions(status: "Inactive");
    super.initState();
  }

  final bloc = AdsCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AdsCubit, AdsState>(
        bloc: bloc,
        listener: (context, state) {},
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return 0.verticalSpace;
            },
            fetchingPromotions: () => SizedBox(
              height: 1.sh,
              child: Center(
                child: CustomDialogs.getLoading(size: 40),
              ),
            ),
            promotionsLoaded: (promotion) {
              if ((promotion as Promotion).data.data.isEmpty) {
                return EmptyAdPage();
              }

              return ListView.builder(
                itemCount: (promotion).data.data.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16, top: 16),
                    child: PromotionItem(
                      promotion: (promotion).data.data[index],
                      onAdCancelled: () {
                        bloc.fetchPromotions(status: "Inactive");
                      },
                      onAdDeleted: () {
                      }, onAdRestarted: () {
                      bloc.fetchPromotions(status: "Inactive");

                    },
                    ),
                  );
                },
              );
            },
            promotionsLoadFailed: (message) => AppErrorWidget(
              onTap: () {
                bloc.fetchPromotions(status: "Inactive");
              },
            ),
          );
        },
      ),
    );
  }
}
