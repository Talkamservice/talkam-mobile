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

class BudgetWidget extends StatefulWidget {
  const BudgetWidget({super.key, required this.onValidated, required this.controller});

  final Function({required int dailyBudge, required int duration}) onValidated;
  final AdsCubit controller;

  @override
  State<BudgetWidget> createState() => _BudgetWidgetState();
}

class _BudgetWidgetState extends State<BudgetWidget> {
  //for initial daily budget
  double _dailyBudget = 16;

  // for duration initial value
  double _duration = 15;


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
            widget.onValidated(dailyBudge: _dailyBudget.round(), duration: _duration.round());
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
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

              width: 1.sw,
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


    );
  }

  void validate(BuildContext context) {
    widget.controller.validateFormsSuccess();
  }
}
