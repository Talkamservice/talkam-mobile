import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/models/get_countries_response.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/presentation/widgets/country_picker_sheet.dart';

class AdCountryPicker extends StatefulWidget {
  const AdCountryPicker({super.key, required this.onChanged, this.selectedCountries});

  final Function(List<TalkamCountry> selectedCountries) onChanged;
  final List<TalkamCountry>? selectedCountries;

  @override
  State<AdCountryPicker> createState() => _AdCountryPickerState();
}

class _AdCountryPickerState extends State<AdCountryPicker> {
  List<TalkamCountry> selectedCountries = [];

  @override
  void initState() {
    selectedCountries = widget.selectedCountries ?? [];
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
              text: "Select countries",
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
            foregroundColor: Pallets.grey,
            padding: const EdgeInsets.all(16),
            side: const BorderSide(color: Pallets.borderGrey, width: 0.7),
          ),
          onPressed: () {
            pickCountries(context);
          },
          child: Row(
            children: [
              const Icon(Icons.language_rounded),
              5.horizontalSpace,
              Expanded(
                child: selectedCountries.isNotEmpty
                    ? Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: selectedCountries.map((country) {
                          return Chip(
                            label: Text(country.name),
                            onDeleted: () {
                              setState(() {
                                selectedCountries.remove(country);
                                widget.onChanged(selectedCountries);
                              });
                            },
                          );
                        }).toList(),
                      )
                    : TextView(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        text: "Select countries",
                      ),
              ),
              Icon(selectedCountries.isNotEmpty ? Icons.add : Icons.keyboard_arrow_down_rounded),
            ],
          ),
        ),
      ],
    );
  }

  void pickCountries(BuildContext context) async {
    var newCountry = await CustomDialogs.showBottomSheet(
      context,
      Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const CountryPickerSheet(),
      ),
    );

    if (newCountry != null && !selectedCountries.any((element) => element.name.contains(newCountry.name),)) {
      setState(() {
        selectedCountries.add(newCountry);
        widget.onChanged(selectedCountries);
      });
    }
  }
}
