import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                const Text("Customize who you want to reach"),
                20.verticalSpace,
                const Text("Location", style: TextStyle(fontWeight: FontWeight.bold),),
                10.verticalSpace,
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nigeria",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),
          ),
          10.verticalSpace,
          const Divider(color: Colors.grey),
          10.verticalSpace,
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text("Select age range"),
          ),
          RangeSlider(
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
          7.verticalSpace,
          const Divider(color: Colors.grey),
          10.verticalSpace,
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text("Select gender"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio<String>(
                value: 'Male',
                groupValue: _selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              const Text("Male"),
              Radio<String>(
                value: 'Female',
                groupValue: _selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              const Text("Female"),
              Radio<String>(
                value: 'All gender',
                groupValue: _selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              const Text("All gender"),
            ],
          ),
          5.verticalSpace,
          const Divider(color: Colors.grey),
          5.verticalSpace,
           Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("What is your budget", style: TextStyle(fontWeight: FontWeight.bold),),
                10.verticalSpace,
                const Text("Daily budget", style: TextStyle(fontSize: 12),),
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
          3.verticalSpace,
          const Divider(color: Colors.grey),
          5.verticalSpace,
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("Duration"),
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
          3.verticalSpace,
          const Divider(color: Colors.grey),
          7.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        10.horizontalSpace,
                        Text("\$ ${_dailyBudget.toInt()}", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),),
                        60.horizontalSpace,
                        const Text("For"),
                        60.horizontalSpace,
                        Text("${_duration.toInt()} ", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),),
                        const Text("Days", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue),),
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
