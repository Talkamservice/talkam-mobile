import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/messaging/data/models/conversation_state_response.dart';
import 'package:talkam/features/messaging/data/models/conversations_filter.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/data/models/get_messages_response.dart'
    show PaginationMeta;
import 'package:talkam/features/messaging/dormain/repository/messaging_repository.dart';

part 'conversations_state.dart';

part 'conversations_cubit.freezed.dart';

class ConversationsCubit extends Cubit<ConversationsState> {
  final MessagingRepository conversationsRepository;

  ConversationsCubit(this.conversationsRepository)
      : super(const ConversationsState.initial());

  Future<void> getConversations(
      {ConversationsFilter? filter, bool? reload = true}) async {
    if (SessionManager().isLoggedIn) {
      if (reload!) {
        emit(const ConversationsState.getConversationsLoading());
      }
      try {
        final response = await conversationsRepository.getConversations(
            filter:
                filter ?? ConversationsFilter(status: '', search: '', tab: ''));

        emit(ConversationsState.getConversationsSuccess(response));
      } catch (e, stack) {
        emit(ConversationsState.getConversationsFailure(e.toString()));
      }
    }
  }

  /// `GET /user/messaging/conversations?archived=&starred=` (v2, paginated)
  /// — drives [MessagesScreen]'s main list. [getConversations] above stays
  /// on v1 for the pending-requests tab only.
  Future<void> getConversationsList(
      {bool? archived, bool? starred, bool? reload = true}) async {
    if (!SessionManager().isLoggedIn) return;
    if (reload!) {
      emit(const ConversationsState.getConversationsListLoading());
    }
    try {
      final response = await conversationsRepository.getConversationsList(
          page: 1, archived: archived, starred: starred);
      emit(ConversationsState.getConversationsListSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(ConversationsState.getConversationsListFailure(e.toString()));
    }
  }

  Future<void> fetchNextConversationsPage(
      List<TalkamConversation> conversations, PaginationMeta paginationData,
      {bool? archived, bool? starred}) async {
    if (!paginationData.canLoadMore) return;
    try {
      final response = await conversationsRepository.getConversationsList(
        page: paginationData.currentPage + 1,
        archived: archived,
        starred: starred,
      );
      emit(ConversationsState.getConversationsListSuccess(
        GetConversationsListResponse(
          message: response.message,
          data: ConversationsListData(
            paginationMeta: response.data.paginationMeta,
            data: [...conversations, ...response.data.data],
          ),
          success: response.success,
          code: response.code,
        ),
      ));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(ConversationsState.getConversationsListFailure(e.toString()));
    }
  }

  Future<void> muteConversation(String conversationId, {String? mutedUntil}) =>
      _updateConversationState('mute', conversationId, mutedUntil: mutedUntil);

  Future<void> unmuteConversation(String conversationId) =>
      _updateConversationState('unmute', conversationId);

  Future<void> archiveConversation(String conversationId) =>
      _updateConversationState('archive', conversationId);

  Future<void> unarchiveConversation(String conversationId) =>
      _updateConversationState('unarchive', conversationId);

  Future<void> starConversation(String conversationId) =>
      _updateConversationState('star', conversationId);

  Future<void> unstarConversation(String conversationId) =>
      _updateConversationState('unstar', conversationId);

  Future<void> markConversationSeen(String conversationId) =>
      _updateConversationState('seen', conversationId);

  Future<void> _updateConversationState(String action, String conversationId,
      {String? mutedUntil}) async {
    emit(const ConversationsState.conversationStateLoading());
    try {
      final response = await conversationsRepository.updateConversationState(
        action: action,
        conversationId: conversationId,
        mutedUntil: mutedUntil,
      );
      emit(ConversationsState.conversationStateSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(ConversationsState.conversationStateFailure(e.toString()));
    }
  }

  Future<void> getPendingRequest() async {
    emit(const ConversationsState.getPendingRequestsLoading());
    try {
      final response = await conversationsRepository.getConversations(
          filter: ConversationsFilter(status: '', search: '', tab: 'request'));
      emit(ConversationsState.getPendingRequestsSuccess(response));
    } catch (e, stack) {
      emit(ConversationsState.getPendingRequestsFailure(e.toString()));
    }
  }

  Future<void> getConversationById(String id, {bool? reload = true}) async {
    if (reload!) {
      emit(const ConversationsState.getConversationByIdLoading());
    }
    try {
      final response = await conversationsRepository.getConversationById(id);
      emit(ConversationsState.getConversationByIdSuccess(response));
    } catch (e, stack) {
      emit(ConversationsState.getConversationByIdFailure(e.toString()));
    }
  }

  Future<void> deleteConversationById(String id) async {
    emit(const ConversationsState.deleteConversationByIdLoading());
    try {
      await conversationsRepository.deleteConversationById(id);
      emit(const ConversationsState.deleteConversationByIdSuccess());
    } catch (e, stack) {
      emit(ConversationsState.deleteConversationByIdFailure(e.toString()));
    }
  }

  Future<void> createConversation(Map<String, dynamic> conversationData) async {
    emit(const ConversationsState.createConversationLoading());
    try {
      final response =
          await conversationsRepository.createConversation(conversationData);
      emit(ConversationsState.createConversationSuccess(response));
    } catch (e, stack) {
      emit(ConversationsState.createConversationFailure(e.toString()));
    }
  }

  Future<void> fetchCurrentConversation(String receiverId) async {
    emit(const ConversationsState.fetchCurrentConversationLoading());
    try {
      final response =
          await conversationsRepository.fetchCurrentConversation(receiverId);
      emit(ConversationsState.fetchCurrentConversationSuccess(response));
    } catch (e, stack) {
      emit(ConversationsState.fetchCurrentConversationFailure(e.toString()));
    }
  }

  Future<void> updateConversationById(String id, bool status) async {
    emit(const ConversationsState.updateConversationByIdLoading());
    try {
      final response =
          await conversationsRepository.updateConversationById(id, status);
      emit(ConversationsState.updateConversationByIdSuccess(response));
    } catch (e, stack) {
      emit(ConversationsState.updateConversationByIdFailure(e.toString()));
    }
  }

  Future<void> updateConversationStatus(
      {required String conversationId, required String status}) async {
    emit(const ConversationsState.updateConversationStatusLoading());
    try {
      final response = await conversationsRepository.updateConversationStatus(
          conversationId: conversationId, status: status);
      emit(ConversationsState.updateConversationStatusSuccess(response));
    } catch (e, stack) {
      emit(ConversationsState.updateConversationStatusFailure(e.toString()));
    }
  }

  Future<void> reportConversation(Map<String, dynamic> reportData) async {
    emit(const ConversationsState.reportConversationLoading());
    try {
      final response =
          await conversationsRepository.reportConversation(reportData);
      emit(ConversationsState.reportConversationSuccess(response));
    } catch (e, stack) {
      emit(ConversationsState.reportConversationFailure(e.toString()));
    }
  }
}
