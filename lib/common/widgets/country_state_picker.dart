import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/models/get_countries_response.dart';
import 'package:talkam/common/models/get_states_response.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/presentation/widgets/country_picker_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/state_picker_sheet.dart';

class TalkamCountryStatePicker extends StatefulWidget {
  const TalkamCountryStatePicker({super.key, required this.onChanged, this.country, this.state});

  final Function(TalkamCountry? country, TalkamState? state) onChanged;
  final TalkamCountry? country;
  final TalkamState? state;

  @override
  State<TalkamCountryStatePicker> createState() => _TalkamCountryStatePickerState();
}

class _TalkamCountryStatePickerState extends State<TalkamCountryStatePicker> {
  TalkamCountry? country;
  TalkamState? state;

  @override
  void initState() {
    country = widget.country;
    state = widget.state;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextView(
              text: "Select country",
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
            TextView(
              text: " *",
              fontSize: 15.sp,
              color: Pallets.red,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        8.verticalSpace,
        TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                foregroundColor: Pallets.grey, padding: const EdgeInsets.all(16), side: const BorderSide(color: Pallets.borderGrey, width: 0.7)),
            onPressed: () {
              pickCountry(context);
            },
            child: Row(
              children: [
                const Icon(Icons.language_rounded),
                5.horizontalSpace,
                Expanded(child: TextView(fontSize: 16, fontWeight: FontWeight.w600, text: country != null ? country!.name : "Select country")),
                const Icon(Icons.keyboard_arrow_down_rounded)
              ],
            )),
        if (country != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              25.verticalSpace,
              Row(
                children: [
                  TextView(
                    text: "Select state",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  TextView(
                    text: " *",
                    fontSize: 15.sp,
                    color: Pallets.red,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              8.verticalSpace,
              TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Pallets.grey, padding: const EdgeInsets.all(16), side: const BorderSide(color: Pallets.borderGrey, width: 0.7)),
                  onPressed: () {
                    pickState(context, country!.id.toString());
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.language_rounded),
                      5.horizontalSpace,
                      Expanded(child: TextView(fontSize: 16, fontWeight: FontWeight.w600, text: state != null ? state!.name : "Select state")),
                      const Icon(Icons.keyboard_arrow_down_rounded)
                    ],
                  )),
            ],
          )
      ],
    );
  }

  void pickCountry(BuildContext context) async {
    country = await CustomDialogs.showBottomSheet(context, const CountryPickerSheet(), constraints: BoxConstraints(maxHeight: 1.sh * 0.5));
    if (country != null) {
      state = null;
    }
    widget.onChanged(country, state);
    setState(() {});
  }

  void pickState(BuildContext context, String countryId) async {
    state = await CustomDialogs.showBottomSheet(
        context,
        StatePickerSheet(
          countryId: countryId,
        ),
        constraints: BoxConstraints(maxHeight: 1.sh * 0.5));
    widget.onChanged(country, state);

    setState(() {});
  }
}
