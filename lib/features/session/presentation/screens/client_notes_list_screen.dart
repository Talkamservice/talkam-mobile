import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';
import 'package:talkam/features/therapist/presentation/bloc/therapist_client_cubit/therapist_client_cubit.dart';

/// `GET /therapist/notes` (v2), searched via [_searchController]. Each row
/// already carries `session_id`, so tapping one opens the same session-scoped
/// note editor used from ClientDetailsScreen's session history rather than a
/// separate read-only detail screen.
class ClientNotesListScreen extends StatefulWidget {
  const ClientNotesListScreen({super.key});

  @override
  State<ClientNotesListScreen> createState() => _ClientNotesListScreenState();
}

class _ClientNotesListScreenState extends State<ClientNotesListScreen> {
  final cubit = TherapistClientCubit(injector.get<TherapistRepository>());
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    cubit.getNotesLibrary();
  }

  @override
  void dispose() {
    cubit.close();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      cubit.getNotesLibrary(query: query.trim().isEmpty ? null : query.trim());
    });
  }

  String _formatDate(String? raw) {
    if (raw == null) return '';
    final dt = DateTime.tryParse(raw);
    if (dt == null) return raw;
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";
    if (diff.inDays < 7) return "${diff.inDays}d ago";
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${months[dt.month - 1]} ${dt.day}";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TherapistClientCubit, TherapistClientState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Pallets.white,
          appBar: const CustomAppBar(
            tittle: TextView(
              text: "Clients Notes",
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Pallets.boldBlack,
            ),
            centerTile: false,
          ),
          body: Column(
            children: [
              12.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomTextField(
                  controller: _searchController,
                  hint: "Search notes",
                  onChanged: _onSearchChanged,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Pallets.grey400,
                    size: 22.w,
                  ),
                ),
              ),
              16.verticalSpace,
              Expanded(child: _buildBody(context, state)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, TherapistClientState state) {
    switch (state.notesLibraryStatus) {
      case LoadStatus.idle:
      case LoadStatus.loading:
        if (state.notesLibrary.isEmpty) {
          return Center(child: CustomDialogs.getLoading(size: 50));
        }
        break;
      case LoadStatus.error:
        return Center(
          child: TextView(
            text: state.notesLibraryError ?? "Something went wrong",
            fontSize: 14,
            color: Pallets.grey400,
            align: TextAlign.center,
          ),
        );
      case LoadStatus.success:
        if (state.notesLibrary.isEmpty) {
          return Center(
            child: TextView(
              text: "No notes yet",
              fontSize: 14,
              color: Pallets.grey400,
            ),
          );
        }
    }

    return RefreshIndicator(
      color: Pallets.blueBubbleColor,
      onRefresh: () => cubit.getNotesLibrary(
        query: _searchController.text.trim().isEmpty
            ? null
            : _searchController.text.trim(),
      ),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: state.notesLibrary.length,
        separatorBuilder: (context, index) => 12.verticalSpace,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        itemBuilder: (context, index) {
          final note = state.notesLibrary[index];
          return InkWell(
            onTap: () => context.pushNamed(
              PageUrl.clientNoteDetailScreen,
              extra: note.sessionId,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F9FF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.assignment_outlined,
                      color: Pallets.blueBubbleColor,
                      size: 22.w,
                    ),
                  ),
                  14.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextView(
                                text: note.title.isEmpty
                                    ? "Untitled note"
                                    : note.title,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Pallets.boldBlack,
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ),
                            8.horizontalSpace,
                            TextView(
                              text:
                                  _formatDate(note.updatedAt ?? note.createdAt),
                              fontSize: 13,
                              color: Pallets.grey400,
                            ),
                          ],
                        ),
                        4.verticalSpace,
                        TextView(
                          text: note.content.isEmpty
                              ? "No content yet"
                              : note.content,
                          fontSize: 13,
                          color: Pallets.grey400,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        if (note.status == 'draft') ...[
                          4.verticalSpace,
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFBEB),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const TextView(
                              text: "Draft",
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFD97706),
                            ),
                          ),
                        ],
                      ],
                    ),
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
