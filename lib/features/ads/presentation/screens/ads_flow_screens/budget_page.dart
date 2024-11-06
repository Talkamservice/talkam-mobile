import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_thumb_shape.dart';
import 'package:talkam/core/theme/pallets.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

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

  String? _selectedCountry;

  final List<String> _countries = [
    "Nigeria",
    "USA",
    "Poland",
    "Canada",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Text("Customize who you want to reach", style: TextStyle(fontSize: 12),),
                ),
                18.verticalSpace,
                const Text("Location", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                5.verticalSpace,
                DropdownButton<String>(
                  value: _selectedCountry,
                  hint: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nigeria",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
                      ],
                    ),
                  ),
                  items: _countries.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(category),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCountry = newValue;
                    });
                  },
                  underline: const SizedBox(),
                  icon: const SizedBox.shrink(),
                  itemHeight: 70,
                  isExpanded: true,
                ),
              ],
            ),
          ),
          12.verticalSpace,
          const Divider(color: Colors.grey),
          11.verticalSpace,
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Text("Select age range", style: TextStyle(fontSize: 10)),
          ),
          SliderTheme(

            data: SliderTheme.of(context).copyWith(
              thumbShape: CustomThumbShape(), // Use the custom thumb shape
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
          10.verticalSpace,
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Text("Select gender", style: TextStyle(fontSize: 10)),
          ),
          Padding(
            padding: const EdgeInsets.only( right: 16),
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
          5.verticalSpace,
           Padding(
            padding: const EdgeInsets.only(left: 23, right: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("What is your budget.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                10.verticalSpace,
                const Text("Daily budget", style: TextStyle(fontSize: 10),),
              ],
            ),
          ),
          Slider(
            value: _dailyBudget,
            min: 5,
            max: 5000,
            divisions: 5000,
            label: _dailyBudget.round().toString(),
            onChanged: (double value) {
              setState(() {
                _dailyBudget = value.round().toDouble();
              });
            },
          ),
          const Padding(
            padding: EdgeInsets.only(left: 23, right: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$5", style: TextStyle(fontSize: 10),),
                Text("\$5000", style: TextStyle(fontSize: 10),),
              ],
            ),
          ),
          3.verticalSpace,
          const Divider(color: Colors.grey),
          5.verticalSpace,
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("Duration", style: TextStyle(fontSize: 10),),
          ),
          Slider(
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
          const Padding(
            padding: EdgeInsets.only(left: 23, right: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("1 day", style: TextStyle(fontSize: 10),),
                Text("30 days", style: TextStyle(fontSize: 10),),
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
              decoration: BoxDecoration(
                color:  const Color(0xffF1FAFF),
                border: Border.all(color: const Color(0xffE5F6FF)),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        10.horizontalSpace,
                        Text("\$ ${_dailyBudget.toInt()}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF017FC8)),),
                        60.horizontalSpace,
                        const Text("For"),
                        60.horizontalSpace,
                        Text("${_duration.toInt()} ", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF017FC8) ),),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: 8,),
                            Text("Days", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF017FC8)),),
                          ],
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Text(
                      "Estimated reach within ${_duration.toInt()}days is ${((_duration * _dailyBudget)/10).toInt()}k",
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
}
