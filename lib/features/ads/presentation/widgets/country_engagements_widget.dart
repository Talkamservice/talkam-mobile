import 'package:flutter/material.dart';

import 'country_engagements_item.dart';

class CountryEngagementsWidget extends StatelessWidget {
  const CountryEngagementsWidget({super.key, required this.country1, required this.country2, required this.country3, required this.countryPer1, required this.countryPer2, required this.countryPer3});

  final String country1;
  final String country2;
  final String country3;

  final String countryPer1;
  final String countryPer2;
  final String countryPer3;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CountryEngagementsItem(country: country1, percentage: countryPer1),
        CountryEngagementsItem(country: country2, percentage: countryPer2),
        CountryEngagementsItem(country: country3, percentage: countryPer3),
      ],
    );
  }
}
