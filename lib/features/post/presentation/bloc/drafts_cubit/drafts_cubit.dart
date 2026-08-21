import 'package:bloc/bloc.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

part 'drafts_state.dart';

/// Screen-scoped cubit backing the "My Drafts" list/edit/delete flow
/// against `GET|PUT|DELETE /user/post-drafts[/{id}]` — constructed locally
/// per screen, matching the other screen-scoped cubits in this feature
/// (e.g. [TherapistClientCubit]) rather than the GetIt singletons.
class DraftsCubit extends Cubit<DraftsState> {
  final PostRepository _repository;

  DraftsCubit(this._repository) : super(const DraftsState());

  Future<void> getDrafts() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final response = await _repository.getDrafts();
      emit(state.copyWith(status: LoadStatus.success, drafts: response.data));
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      emit(state.copyWith(status: LoadStatus.error, error: e.toString()));
    }
  }

  /// Plain content edit — status is deliberately left null so this can
  /// never accidentally publish the draft (CreatePostPayload defaults
  /// status to "Active" when unset, which [publishDraft] relies on).
  Future<bool> updateDraft(
    int draftId, {
    required int categoryId,
    required String type,
    required String title,
    required String body,
  }) async {
    emit(state.copyWith(savingId: draftId));
    try {
      final response = await _repository.updateDraft(
        draftId.toString(),
        CreatePostPayload(
          categoryId: categoryId,
          type: type,
          title: title,
          body: body,
          status: null,
        ),
      );
      final updated = state.drafts
          .map((d) => d.id == draftId ? response.data : d)
          .toList();
      emit(state.copyWith(drafts: updated, clearSavingId: true));
      return true;
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      emit(state.copyWith(clearSavingId: true));
      return false;
    }
  }

  /// Moves a draft into the real feed by flipping its status to Active —
  /// PostService::list only ever returns status=Active posts, so this is
  /// all "publish" needs to do; no separate publish endpoint exists.
  Future<bool> publishDraft(TalkamPost draft) async {
    emit(state.copyWith(savingId: draft.id));
    try {
      await _repository.updateDraft(
        draft.id.toString(),
        CreatePostPayload(
          categoryId: int.tryParse(draft.category.id.toString()),
          type: draft.type?.toString() ?? "Text",
          title: draft.title?.toString() ?? "",
          body: draft.body ?? "",
          status: "Active",
        ),
      );
      final remaining = state.drafts.where((d) => d.id != draft.id).toList();
      emit(state.copyWith(drafts: remaining, clearSavingId: true));
      return true;
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      emit(state.copyWith(clearSavingId: true));
      return false;
    }
  }

  Future<bool> deleteDraft(int draftId) async {
    emit(state.copyWith(deletingId: draftId));
    try {
      await _repository.deleteDraft(draftId.toString());
      final remaining = state.drafts.where((d) => d.id != draftId).toList();
      emit(state.copyWith(drafts: remaining, clearDeletingId: true));
      return true;
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      emit(state.copyWith(clearDeletingId: true));
      return false;
    }
  }
}
