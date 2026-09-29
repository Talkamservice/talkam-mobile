import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/chat_local_store.dart';
import 'package:talkam/core/services/data/resettable_on_logout.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/messaging/data/models/conversation_state_response.dart';
import 'package:talkam/features/messaging/data/models/conversations_filter.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/data/models/get_messages_response.dart'
    show PaginationMeta;
import 'package:talkam/features/messaging/dormain/repository/messaging_repository.dart';

part 'conversations_state.dart';

part 'conversations_cubit.freezed.dart';

class ConversationsCubit extends Cubit<ConversationsState>
    implements ResettableOnLogout {
  final MessagingRepository conversationsRepository;

  ConversationsCubit(this.conversationsRepository)
      : super(const ConversationsState.initial());

  @override
  void resetForLogout() => emit(const ConversationsState.initial());

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
      {bool? archived,
      bool? starred,
      bool? reload = true,
      bool forceRefresh = false}) async {
    if (!SessionManager().isLoggedIn) return;

    // Only the default ("All") tab has a local snapshot — Starred/Archived
    // combinations aren't cached, since they're visited far less often.
    final isDefaultTab = archived != true && starred != true;
    var shownFromCache = false;

    // `forceRefresh` (an explicit pull-to-refresh) skips the cache read
    // entirely — otherwise, with a cache already on screen, the loading
    // state below gets suppressed and a user-initiated refresh visibly
    // does nothing until the background fetch happens to land.
    if (isDefaultTab && !forceRefresh) {
      // A corrupt/incompatible cached snapshot must never block the real
      // fetch below — this being unguarded previously meant any parse
      // failure here silently aborted the whole method with no emit at
      // all, leaving the screen stuck blank indefinitely.
      try {
        final cached = ChatLocalStore.instance.getCachedConversationsList();
        final cachedConversations = (cached?['conversations'] as List?)
            ?.map((e) =>
                TalkamConversation.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        if (cachedConversations != null && cachedConversations.isNotEmpty) {
          emit(ConversationsState.getConversationsListSuccess(
            GetConversationsListResponse(
              message: 'Cached',
              data: ConversationsListData(
                paginationMeta: PaginationMeta.fromJson(
                    Map<String, dynamic>.from(cached!['pagination_meta'])),
                data: _sortByNewest(cachedConversations),
              ),
              success: true,
              code: 200,
            ),
          ));
          shownFromCache = true;
        }
      } catch (e, stack) {
        logger.e('Failed reading cached conversations list', error: e, stackTrace: stack);
      }
    }

    if (reload! && !shownFromCache) {
      emit(const ConversationsState.getConversationsListLoading());
    }
    try {
      final response = await conversationsRepository.getConversationsList(
          page: 1, archived: archived, starred: starred);
      final merged = _mergePreservingNewerLocalPreview(response.data.data);
      final sorted = _sortByNewest(merged);
      emit(ConversationsState.getConversationsListSuccess(
        GetConversationsListResponse(
          message: response.message,
          data: ConversationsListData(
            paginationMeta: response.data.paginationMeta,
            data: sorted,
          ),
          success: response.success,
          code: response.code,
        ),
      ));
      if (isDefaultTab) {
        await ChatLocalStore.instance.saveConversationsList(
          sorted.map((c) => c.toJson()).toList(),
          response.data.paginationMeta.toJson(),
        );
      }
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      // Don't wipe an already-visible cached list with an error screen over
      // a background refresh failure — just leave what's shown.
      if (!shownFromCache) {
        emit(ConversationsState.getConversationsListFailure(e.toString()));
      }
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
      final merged = _sortByNewest([...conversations, ...response.data.data]);
      emit(ConversationsState.getConversationsListSuccess(
        GetConversationsListResponse(
          message: response.message,
          data: ConversationsListData(
            paginationMeta: response.data.paginationMeta,
            data: merged,
          ),
          success: response.success,
          code: response.code,
        ),
      ));
      if (archived != true && starred != true) {
        await ChatLocalStore.instance.saveConversationsList(
          merged.map((c) => c.toJson()).toList(),
          response.data.paginationMeta.toJson(),
        );
      }
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(ConversationsState.getConversationsListFailure(e.toString()));
    }
  }

  /// Locally updates one conversation's preview/ordering without a network
  /// round trip — used when [MessagingCubit] receives a live message for
  /// the conversation currently open. No-op if the list hasn't been loaded
  /// into this cubit yet (the next real fetch picks up fresh data anyway).
  void patchConversationPreview({
    required String conversationId,
    required int lastMessageId,
    required int senderId,
    required String message,
    required DateTime createdAt,
    String assetUrl = '',
  }) {
    logger.i(
        'PATCH PREVIEW -> conversationId=$conversationId, currentState=${state.runtimeType}');
    state.maybeWhen(
      orElse: () => logger.w(
          'PATCH PREVIEW SKIPPED -> state was not getConversationsListSuccess (was ${state.runtimeType})'),
      getConversationsListSuccess: (response) {
        final index = response.data.data
            .indexWhere((c) => c.id.toString() == conversationId);
        if (index == -1) {
          logger.w(
              'PATCH PREVIEW SKIPPED -> conversation $conversationId not found among ${response.data.data.map((c) => c.id).toList()}');
          return;
        }
        logger.i('PATCH PREVIEW APPLYING -> conversation $conversationId found at index $index');

        final updated = [...response.data.data];
        updated[index] = updated[index].copyWith(
          lastMessage: LastMessage(
            id: lastMessageId,
            senderId: senderId,
            message: message,
            assetUrl: assetUrl,
            createdAt: createdAt,
          ),
        );
        final sorted = _sortByNewest(updated);

        emit(ConversationsState.getConversationsListSuccess(
          GetConversationsListResponse(
            message: response.message,
            data: ConversationsListData(
              paginationMeta: response.data.paginationMeta,
              data: sorted,
            ),
            success: response.success,
            code: response.code,
          ),
        ));
        ChatLocalStore.instance.saveConversationsList(
          sorted.map((c) => c.toJson()).toList(),
          response.data.paginationMeta.toJson(),
        );
      },
    );
  }

  /// A network fetch of the list can be in flight concurrently with a
  /// send/receive that already patched a conversation locally via
  /// [patchConversationPreview] — e.g. leaving the chat screen right after
  /// sending triggers MessagesScreen's own `getConversationsList()`, whose
  /// GET can reach the server before the send's POST has committed there.
  /// That's a legitimately stale (not wrong) server response — but applying
  /// it wholesale would silently overwrite the newer local patch with it.
  /// Per conversation, keep whichever last_message is actually more recent.
  List<TalkamConversation> _mergePreservingNewerLocalPreview(
      List<TalkamConversation> incoming) {
    final currentById = <String, TalkamConversation>{};
    state.maybeWhen(
      orElse: () {},
      getConversationsListSuccess: (response) {
        for (final c in response.data.data) {
          currentById[c.id.toString()] = c;
        }
      },
    );
    return incoming.map((c) {
      final current = currentById[c.id.toString()];
      final currentTime = current?.lastMessage?.createdAt;
      final incomingTime = c.lastMessage?.createdAt;
      if (currentTime != null &&
          (incomingTime == null || currentTime.isAfter(incomingTime))) {
        return c.copyWith(lastMessage: current!.lastMessage);
      }
      return c;
    }).toList();
  }

  /// Newest activity first. A conversation with no messages yet (brand new)
  /// sorts to the top, same as a freshly-sent message would.
  List<TalkamConversation> _sortByNewest(
      List<TalkamConversation> conversations) {
    final sorted = [...conversations];
    sorted.sort((a, b) {
      final aTime = a.lastMessage?.createdAt;
      final bTime = b.lastMessage?.createdAt;
      if (aTime == null && bTime == null) return 0;
      if (aTime == null) return -1;
      if (bTime == null) return 1;
      return bTime.compareTo(aTime);
    });
    return sorted;
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
      // The action sheet mutated this conversation server-side — refresh the
      // list (without the loading shimmer, since it's already visible) so
      // the row reflects it without a manual pull-to-refresh. Skip this for
      // `seen`, which fires on every single conversation tap (the user is
      // navigating away to the chat anyway) — refetching the whole list
      // that often is wasteful and risks tripping the backend's rate limit.
      if (action != 'seen') {
        getConversationsList(reload: false);
      }
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
