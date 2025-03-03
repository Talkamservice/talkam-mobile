import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/models/get_countries_response.dart';
import 'package:talkam/common/models/get_states_response.dart';
import 'package:talkam/common/widgets/country_state_picker.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_thumb_shape.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/ads/data/models/get_ads_pricing.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/ads/presentation/widgets/budget_widget.dart';
import 'package:talkam/features/ads/presentation/widgets/promotion_target_form.dart';
import 'package:talkam/features/post/presentation/widgets/country_picker_sheet.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key, required this.onValidated, this.pricing});

  final GetPricingResponse? pricing;

  final VoidCallback onValidated;

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  int? _maxAge;
  int? _minAge;

  // initial gender selected
  String? _selectedGender;

  //for initial daily budget
  int? _dailyBudget;

  // for duration initial value
  int? _duration;

  List<TalkamCountry>? _country;
  TalkamState? _state;
  bool _budgetValidated = false;
  final AdsCubit targetsController = AdsCubit(injector.get());
  final AdsCubit budgetController = AdsCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdsCubit, AdsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          validateFormsState: () {
            targetsController.validateForms();
            budgetController.validateForms();
            // Future.delayed(Duration(milliseconds: 300),() {
            //
            //
            // },);
          },
          validateFormsSuccessState: () {
            widget.onValidated();
          },
        );
      },
      child: Scaffold(
        backgroundColor: Pallets.white,
        body: SingleChildScrollView(
          child: Column(
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

                    if (_budgetValidated) {
                      validate(context);
                    }
                  },
                  controller: targetsController),
              const Divider(color: Colors.grey),
              16.verticalSpace,
              BudgetWidget(
                pricing: widget.pricing,
                  onValidated: ({required dailyBudge, required duration}) {
                    _dailyBudget = dailyBudge;
                    _duration = duration;
                    _budgetValidated = true;
                  },
                  controller: budgetController)
            ],
          ),
        ),
      ),
    );
  }

  void validate(BuildContext context) {
    if (_country == null) {
      CustomDialogs.error("Please select country");
    } else {
      context.read<AdsCubit>().updatePayloadField(
          countryId: _country!,
          stateId: _state,
          maxAge: _maxAge,
          minAge: _minAge,
          dailyBudget: _dailyBudget?.toDouble(),
          duration: _duration,
          gender: _selectedGender);

      context.read<AdsCubit>().validateFormsSuccess();
    }
  }
}
