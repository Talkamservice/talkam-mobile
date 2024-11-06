import 'package:flutter/material.dart';

class CountryEngagementsItem extends StatelessWidget {
  const CountryEngagementsItem({super.key, required this.country, required this.percentage});

  final String country;
  final String percentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$country: ", style: const TextStyle(fontSize: 16,)),
        Text("$percentage%", style: const TextStyle(fontSize: 16, color: Color(0xFF858585)),)
      ],
    );
  }
}
