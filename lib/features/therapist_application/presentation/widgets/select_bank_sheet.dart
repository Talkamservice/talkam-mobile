import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';

/// Searchable bottom sheet for the ~2000-entry Flutterwave bank list —
/// mirrors [SelectCategorySheet]'s search-filter-then-pop-selection shape,
/// but reads from the wizard's already-shared [TherapistApplicationBloc]
/// instead of owning its own cubit.
class SelectBankSheet extends StatefulWidget {
  const SelectBankSheet({super.key, required this.bloc});

  final TherapistApplicationBloc bloc;

  @override
  State<SelectBankSheet> createState() => _SelectBankSheetState();
}

class _SelectBankSheetState extends State<SelectBankSheet> {
  var _query = '';

  @override
  void initState() {
    super.initState();
    widget.bloc.add(const LoadBanksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7.sh,
      color: context.colorScheme.surface,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            hint: "Search bank",
            prefixIcon: const Icon(Icons.search),
            onChanged: (query) => setState(() => _query = query),
          ),
          Expanded(
            child: BlocBuilder<TherapistApplicationBloc,
                TherapistApplicationState>(
              bloc: widget.bloc,
              builder: (context, state) {
                if (state.banksLoading) {
                  return Center(child: CustomDialogs.getLoading(size: 50));
                }
                if (state.banksError != null) {
                  return AppErrorWidget(
                    message: state.banksError,
                    onTap: () => widget.bloc.add(const LoadBanksEvent()),
                  );
                }

                final allBanks = List.of(state.banks)
                  ..sort((a, b) =>
                      a.name.toLowerCase().compareTo(b.name.toLowerCase()));

                final banks = _query.isEmpty
                    ? allBanks
                    : allBanks
                        .where((b) =>
                            b.name.toLowerCase().contains(_query.toLowerCase()))
                        .toList();

                if (banks.isEmpty) {
                  return const Center(
                    child: TextView(text: "No banks found"),
                  );
                }

                return ListView.builder(
                  itemCount: banks.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () => context.pop(banks[index]),
                      child: TextView(
                        text: banks[index].name,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
