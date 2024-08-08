import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';

class GenericTypeAheadField<T> extends StatelessWidget {
  final String labelText;
  final Future<List<T>> Function(String query) suggestionsCallback;
  final Widget Function(BuildContext context, T suggestion) itemBuilder;
  final void Function(T suggestion) onSuggestionSelected;
  final Widget Function(BuildContext, TextEditingController, FocusNode)?
      builder;

  const GenericTypeAheadField({
    Key? key,
    required this.labelText,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.onSuggestionSelected,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      suggestionsCallback: suggestionsCallback,
      itemBuilder: itemBuilder,
      onSelected: onSuggestionSelected,
      loadingBuilder: (context) => CustomDialogs.getLoading(size: 40),
      hideWithKeyboard: true,
      hideKeyboardOnDrag: true,
      hideOnSelect: true,
      hideOnUnfocus: true,
      // hideOnError: true,
      debounceDuration: const Duration(milliseconds: 500),
      // listBuilder: (context, children) {
      //   return ListView(
      //     children: [],
      //   );
      // },
      // direction: Axis.vertical,
      builder: builder,
    );
  }
}
