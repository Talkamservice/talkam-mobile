import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/presentation/blocs/group_members_cubit/group_members_cubit.dart';
import 'package:talkam/features/group/presentation/widgets/pending_request_item.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class PendingRequestsScreen extends StatefulWidget {
  const PendingRequestsScreen({super.key, required this.group});

  final TalkamGroup group;

  @override
  State<PendingRequestsScreen> createState() => _PendingRequestsScreenState();
}

class _PendingRequestsScreenState extends State<PendingRequestsScreen> {
  final bloc = GroupMembersCubit(injector.get());

  @override
  void initState() {
    bloc.getPendingRequests(widget.group.id.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTile: false,
        showDivider: true,
        leadingWidth: 30,

        // tittleText: ,
        tittle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageWidget(imageUrl: Assets.images.svgs.groupRequests),
            10.horizontalSpace,
            const TextView(text: "Join Requests")
          ],
        ),
      ),
      body: Column(
        children: [


          Expanded(
              child: BlocConsumer<GroupMembersCubit, GroupMembersState>(
            bloc: bloc,
            listener: (context, state) {
              state.maybeWhen(
                orElse: () => null,
                requestActionLoading: () {
                  CustomDialogs.showLoading(context);
                },
                requestActionSuccess: (response) {
                  context.pop();
                  bloc.getPendingRequests(widget.group.id.toString(),
                      refresh: false);
                },
                requestActionFailure: (error) {
                  CustomDialogs.error(error);
                },
              );
            },
            buildWhen: _buildWhen,
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return AppErrorWidget(
                    onTap: () {
                      bloc.getPendingRequests(widget.group.id.toString());
                    },
                  );
                },
                pendingRequestsSuccess: (response) {
                  if (response.data.data.isEmpty) {
                    return const Center(
                      child: EmptyState(
                        title: "No pending requests",
                        subtitle:
                            "You pending requests will show here if there are any",
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      bloc.getPendingRequests(widget.group.id.toString());
                    },
                    child: ListView.builder(
                      itemCount: response.data.data.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: PendingRequestItem(
                          pendingRequest: response.data.data[index],
                          onRequestAction: (requestAction) {
                            bloc.acceptOrDeclineRequest(
                                memberId:
                                    response.data.data[index].id.toString(),
                                action: requestAction.name,
                                groupId: widget.group.id.toString());
                          },
                        ),
                      ),
                    ),
                  );
                },
                pendingRequestsFailure: (error) {
                  return AppErrorWidget(
                    message: error,
                    onTap: () {
                      bloc.getPendingRequests(widget.group.id.toString());
                    },
                  );
                },
                pendingRequestsLoading: () {
                  return Center(
                    child: CustomDialogs.getLoading(size: 40),
                  );
                },
              );
            },
          ))
        ],
      ),
    );
  }

  bool _buildWhen(GroupMembersState previous, GroupMembersState current) {
    return current.maybeWhen(
      orElse: () => false,
      pendingRequestsLoading: () => true,
      pendingRequestsFailure: (error) => true,
      pendingRequestsSuccess: (response) => true,
    );
  }
}
