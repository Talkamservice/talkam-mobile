import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist/data/models/therapist_client.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';
import 'package:talkam/features/therapist/presentation/bloc/therapist_client_cubit/therapist_client_cubit.dart';
import 'package:talkam/gen/assets.gen.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final cubit = TherapistClientCubit(injector.get<TherapistRepository>());

  @override
  void initState() {
    super.initState();
    cubit.getClients();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TherapistClientCubit, TherapistClientState>(
      bloc: cubit,
      builder: (context, state) {
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
          body: switch (state.clientsStatus) {
            LoadStatus.loading ||
            LoadStatus.idle =>
              Center(child: CustomDialogs.getLoading(size: 50)),
            LoadStatus.error => Center(
                child: TextView(
                  text: state.clientsError ?? "Something went wrong",
                  fontSize: 14,
                  color: Pallets.grey400,
                  align: TextAlign.center,
                ),
              ),
            LoadStatus.success => state.clients.isEmpty
                ? _buildEmptyState(context)
                : _buildClientsList(context, state.clients),
          },
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: EmptyState(
        imageUrl: Assets.images.svgV2.emptyState,
        title: "This page is currently empty.",
        subtitle:
            "Clients show up here once you've had at least one confirmed session with them.",
      ),
    );
  }

  Widget _buildClientsList(
      BuildContext context, List<TherapistClientListItem> clients) {
    return RefreshIndicator(
      color: Pallets.blueBubbleColor,
      onRefresh: () => cubit.getClients(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        itemCount: clients.length,
        separatorBuilder: (context, index) => 16.verticalSpace,
        itemBuilder: (context, index) {
          final client = clients[index];
          return GestureDetector(
            onTap: () {
              context.pushNamed(
                PageUrl.clientDetailsScreen,
                extra: client.id,
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
                    backgroundImage: (client.avatar?.isNotEmpty ?? false)
                        ? NetworkImage(client.avatar!)
                        : null,
                    child: (client.avatar?.isNotEmpty ?? false)
                        ? null
                        : TextView(
                            text: client.name.isNotEmpty
                                ? client.name[0].toUpperCase()
                                : "?",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Pallets.primary,
                          ),
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
                          text: client.topics.join(' • '),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Pallets.grey400,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        4.verticalSpace,
                        TextView(
                          text: "${client.sessionsCount} sessions",
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
      ),
    );
  }
}
