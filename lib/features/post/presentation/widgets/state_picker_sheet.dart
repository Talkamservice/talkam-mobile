import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/blocs/location_bloc/location_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/messaging/presentation/screens/messages_screen.dart';
import 'package:talkam/features/search/presentation/screens/search_screen.dart';

class StatePickerSheet extends StatefulWidget {
  const StatePickerSheet({super.key, required this.countryId});

  final String countryId;

  @override
  State<StatePickerSheet> createState() => _StatePickerSheetState();
}

class _StatePickerSheetState extends State<StatePickerSheet> {
  final bloc = LocationBloc();
  String searchTerm = ""; // Add a state variable for search term

  @override
  void initState() {
    bloc.add(GetStatesEvent(widget.countryId));
    super.initState();
  }

  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh * 0.5,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Pallets.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextView(
            text: "Select state",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          8.verticalSpace,
          // Add Search Bar
          CustomSearchField(
            hint: "Search states...",
            onChanged: (value) {
              setState(() {
                searchTerm = value.toLowerCase();
              });
            },
            controller: textEditingController,
          ),
          8.verticalSpace,
          Expanded(
              child: BlocConsumer<LocationBloc, LocationState>(
            bloc: bloc,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LocationLoading) {
                return Center(
                    child: SizedBox(
                  height: 100,
                  child: Center(child: CustomDialogs.getLoading(size: 50)),
                ));
              }

              if (state is GetStateSuccessState) {
                if (state.response.data.isEmpty) {
                  return const Center(
                    child: TextView(
                      text: "No states for this country",
                    ),
                  );
                }

                // Filter the list based on search term
                final filteredList = state.response.data.where((state) => state.name.toLowerCase().contains(searchTerm)).toList();

                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: InkWell(
                      onTap: () {
                        context.pop(filteredList[index]);
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: TextView(
                              text: filteredList[index].name,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_right_sharp)
                        ],
                      ),
                    ),
                  ),
                );
              }

              if (state is LocationFailure) {
                return AppErrorWidget(
                  message: state.error,
                  onTap: () {
                    bloc.add(GetStatesEvent(widget.countryId));
                  },
                );
              }

              return AppErrorWidget(
                onTap: () {
                  bloc.add(GetStatesEvent(widget.countryId));
                },
              );
            },
          ))
        ],
      ),
    );
  }
}
