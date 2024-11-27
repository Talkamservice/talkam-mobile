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
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/ads/presentation/widgets/budget_widget.dart';
import 'package:talkam/features/post/presentation/widgets/country_picker_sheet.dart';

import 'ad_country_picker.dart';

class PromotionTargetWidget extends StatefulWidget {
  const PromotionTargetWidget({super.key, required this.onValidated, required this.controller, this.tittle});

  final Function({required List<TalkamCountry> country,  required int maxAge, required int minAge, required String gender}) onValidated;
  final AdsCubit controller;
  final String? tittle;

  @override
  State<PromotionTargetWidget> createState() => _PromotionTargetWidgetState();
}

class _PromotionTargetWidgetState extends State<PromotionTargetWidget> {
  // for initial range values
  RangeValues _currentRangeValues = const RangeValues(20, 60);

  // initial gender selected
  String _selectedGender = 'All gender';

  List<TalkamCountry>? _country;
  TalkamState? _state;
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
  @override
  Widget build(BuildContext context) {
    return BlocListener<AdsCubit, AdsState>(
      bloc: widget.controller,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          validateFormsState: () {
            validate(context);
          },
          validateFormsSuccessState: () {
            widget.onValidated(
                gender: _selectedGender,
                minAge: _currentRangeValues.start.round(),
                maxAge: _currentRangeValues.end.round(),
                country: _country!,
               );
          },
        );
      },
      child: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                   if(widget.tittle?.isNotEmpty??false)
                   Padding(
                    padding: EdgeInsets.only(left: 4, right: 4),
                    child: Text(
                    widget.tittle??  "Customize who you want to reach",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  if(widget.tittle?.isNotEmpty??false)

                  18.verticalSpace,
                  AdCountryPicker(
                    onChanged: (country,) {
                      _country = country;

                    },
                  )
                ],
              ),
            ),
            16.verticalSpace,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(color: Colors.grey),
            ),
            16.verticalSpace,
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text("Select age range", style: TextStyle(fontSize: 10)),
            ),
            SliderTheme(
              data: SliderThemeData(
                rangeThumbShape: CustomRangeSliderThumbImage(image: AssetImage('assets/images/png/thumb.png')),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
              ),
              child: RangeSlider(
                values: _currentRangeValues,
                min: 18,
                max: 60,
                divisions: 200,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
            ),
            7.verticalSpace,
            const Divider(color: Colors.grey),
            16.verticalSpace,
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text("Select gender", style: TextStyle(fontSize: 10, color: Pallets.textGrey)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Wrap(

                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: _selectedGender,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _selectedGender = value;
                            });
                          }
                        },
                        activeColor: const Color(0xFFFDAC0E),
                      ),
                      const Text("Male")
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Radio<String>(
                        value: 'Female',
                        groupValue: _selectedGender,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _selectedGender = value;
                            });
                          }
                        },
                        activeColor: const Color(0xFFFDAC0E),
                      ),
                      const Text("Female")
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Radio<String>(
                        value: 'Choose not to specify',
                        groupValue: _selectedGender,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _selectedGender = value;
                            });
                          }
                        },
                        activeColor: const Color(0xFFFDAC0E),
                      ),
                      const Text("Choose not to specify")
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Radio<String>(
                        value: 'All gender',
                        groupValue: _selectedGender,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _selectedGender = value;
                            });
                          }
                        },
                        activeColor: const Color(0xFFFDAC0E),
                      ),
                      const Text("All gender")
                    ],
                  ),

                ],
              ),
            ),
            5.verticalSpace,
          ],
        ),
      ),
    );
  }



  void validate(BuildContext context) {
    if (_country == null) {
      CustomDialogs.error("Please select country");
    }  else {
      // context.read<AdsCubit>().updatePayloadField(
      //     countryId: _country,
      //     stateId: _state,
      //     maxAge: _currentRangeValues.end.round(),
      //     minAge: _currentRangeValues.start.round(),
      //     dailyBudget: _dailyBudget,
      //     duration: _duration.round(),
      //     gender: _selectedGender);

      widget.controller.validateFormsSuccess();
    }
  }
}
