import 'package:flutter/material.dart';
import 'package:talkam/features/ads/data/models/ad_analytics_response.dart';

import 'country_engagements_item.dart';

class CountryEngagementsWidget extends StatelessWidget {
  const CountryEngagementsWidget({
    super.key,
    required this.countryStats,
  });

  final List<CountryStat> countryStats;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: countryStats
          .map(
            (e) => CountryEngagementsItem(country: e.name, percentage: "${e.percentage}"),
          )
          .toList(),
    );
  }
}
