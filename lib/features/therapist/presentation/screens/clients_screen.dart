import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist/data/models/client_model.dart';
import 'package:talkam/gen/assets.gen.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine whether to show the empty state or populated list.
    final clients = MockClientData.clients;
    bool isEmptyState = clients.isEmpty; // Set to true to view empty state

    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: CustomAppBar(
        titleAlign: TextAlign.start,
        centerTile: false,
        canGoBack: false,
        leadingWidth: 0,
        titleSpacing: 24.w,
        tittle: const TextView(
          text: "Clients",
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Pallets.boldBlack,
        ),
      ),
      body: isEmptyState
          ? _buildEmptyState(context)
          : _buildClientsList(context, clients),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: EmptyState(
        imageUrl: Assets.images.svgV2.emptyState,
        title: "This page is currently empty.",
        subtitle:
            "Find clients here for easy management. Post on social\nmedia, join groups, and showcase skills.",
      ),
    );
  }

  Widget _buildClientsList(BuildContext context, List<ClientModel> clients) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      itemCount: clients.length,
      separatorBuilder: (context, index) => 16.verticalSpace,
      itemBuilder: (context, index) {
        final client = clients[index];
        return GestureDetector(
          onTap: () {
            context.pushNamed(
              PageUrl.clientDetailsScreen,
              extra: client,
            );
          },
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Pallets.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Pallets.grey90),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: const Color(0xFFF2F9FF),
                  backgroundImage: client.avatarUrl.isNotEmpty
                      ? NetworkImage(client.avatarUrl)
                      : null,
                  child: client.avatarUrl.isEmpty
                      ? TextView(
                          text: client.initial,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Pallets.primary,
                        )
                      : null,
                ),
                16.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: client.name,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Pallets.boldBlack,
                      ),
                      4.verticalSpace,
                      TextView(
                        text: client.diagnosis,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Pallets.grey400,
                      ),
                      4.verticalSpace,
                      TextView(
                        text: "${client.totalSessions} sessions",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Pallets.grey400,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Pallets.grey400,
                  size: 24.w,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
