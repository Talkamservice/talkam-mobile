import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';

class CustomDropdownFieldButton<T> extends StatelessWidget {
  const CustomDropdownFieldButton({
    super.key,
    required this.hint,
    this.value,
    this.label,
    required this.items,
    required this.onChanged,
  });

  final String hint;
  final T? value;
  final String? label;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged; // Use ValueChanged for type safety

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) TextView(text: label!),
        5.verticalSpace,
        ButtonTheme(
          alignedDropdown: true,
          colorScheme: context.colorScheme,
          buttonColor: context.colorScheme.surface,
          focusColor: context.colorScheme.surface,
          child: DropdownButtonFormField<T>(
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            decoration: InputDecoration(
              filled: false,
              fillColor: context.colorScheme.surface,

              contentPadding: const EdgeInsets.all(16),
              enabledBorder: OutlineInputBorder(
                gapPadding: 2,
                borderSide: const BorderSide(
                  color: Pallets.borderGrey,
                  width: 0.7,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 2,
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 0.7,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                gapPadding: 2,
                borderSide: const BorderSide(
                  color: Pallets.borderGrey,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            dropdownColor: context.colorScheme.surface,
            hint: TextView(text: hint),
            items: items,
            onChanged: onChanged, // Directly pass the onChanged callback
          ),
        ),
      ],
    );
  }
}
