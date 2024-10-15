import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/blocs/location_bloc/location_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

class StatePickerSheet extends StatefulWidget {
  const StatePickerSheet({super.key, required this.countryId});

  final String countryId;

  @override
  State<StatePickerSheet> createState() => _StatePickerSheetState();
}

class _StatePickerSheetState extends State<StatePickerSheet> {
  final bloc = LocationBloc();

  @override
  void initState() {
    bloc.add(GetStatesEvent(widget.countryId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
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
                return ListView.builder(
                  itemCount: state.response.data.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: InkWell(
                      onTap: () {
                        context.pop(state.response.data[index]);
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: TextView(
                              text: state.response.data[index].name,
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
