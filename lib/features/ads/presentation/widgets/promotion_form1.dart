import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/models/get_countries_response.dart';
import 'package:talkam/common/models/get_states_response.dart';
import 'package:talkam/common/widgets/country_state_picker.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_thumb_shape.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/country_picker_sheet.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key, required this.onValidated});

  final VoidCallback onValidated;

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  // for initial range values
  RangeValues _currentRangeValues = const RangeValues(20, 60);

  // initial gender selected
  String? _selectedGender = 'All gender';

  //for initial daily budget
  double _dailyBudget = 16;

  // for duration initial value
  double _duration = 15;

  TalkamCountry? _country;
  TalkamState? _state;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdsCubit, AdsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          validateFormsState: () {
            validate(context);
          },
          validateFormsSuccessState: () {
            widget.onValidated();
          },
        );
      },
      child: Scaffold(
        backgroundColor: Pallets.white,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  const Padding(
                    padding: EdgeInsets.only(left: 4, right: 4),
                    child: Text(
                      "Customize who you want to reach",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  18.verticalSpace,
                  TalkamCountryStatePicker(
                    onChanged: (country, state) {
                      _country = country;
                      _state = state;
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: _selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                        activeColor: const Color(0xFFFDAC0E),
                      ),
                      const Text("Male")
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Female',
                        groupValue: _selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                        activeColor: const Color(0xFFFDAC0E),
                      ),
                      const Text("Female")
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'All gender',
                        groupValue: _selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedGender = value;
                          });
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
            const Divider(color: Colors.grey),
            16.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(left: 23, right: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "What is your budget.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  10.verticalSpace,
                  const Text(
                    "Daily budget",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            SliderTheme(
              data: SliderThemeData(thumbShape: CustomThumbShape()),
              child: Slider(
                value: _dailyBudget,
                min: 5,
                max: 2000,
                divisions: 5000,
                label: _dailyBudget.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _dailyBudget = value.round().toDouble();
                  });
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 23, right: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$5",
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    "\$2000",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            3.verticalSpace,
            const Divider(color: Colors.grey),
            5.verticalSpace,
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Duration",
                style: TextStyle(fontSize: 10),
              ),
            ),
            SliderTheme(
              data: SliderThemeData(thumbShape: CustomThumbShape()),
              child: Slider(
                value: _duration,
                min: 1,
                max: 30,
                divisions: 200,
                label: _duration.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _duration = value.round().toDouble();
                  });
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 23, right: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "1 day",
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    "30 days",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            3.verticalSpace,
            const Divider(color: Colors.grey),
            7.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: 200,
                decoration:
                BoxDecoration(color: const Color(0xffF1FAFF), border: Border.all(color: const Color(0xffE5F6FF)), borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          10.horizontalSpace,
                          Text(
                            "\$ ${_dailyBudget.toInt()}",
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF017FC8)),
                          ),
                          60.horizontalSpace,
                          const Text("For"),
                          60.horizontalSpace,
                          Text(
                            "${_duration.toInt()} ",
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF017FC8)),
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Days",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF017FC8)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      Text(
                        "Estimated reach within ${_duration.toInt()}days is ${((_duration * _dailyBudget) / 10).toInt()}k",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void validate(BuildContext context) {
    if (_country == null) {
      CustomDialogs.error("Please select country");
    } else if (_state == null) {
      CustomDialogs.error("Please select state");
    } else {
      context.read<AdsCubit>().updatePayloadField(
          countryId: _country,
          stateId: _state,
          maxAge: _currentRangeValues.end.round(),
          minAge: _currentRangeValues.start.round(),
          dailyBudget: _dailyBudget,
          duration: _duration.round(),
          gender: _selectedGender);

      context.read<AdsCubit>().validateFormsSuccess();
    }
  }
}
