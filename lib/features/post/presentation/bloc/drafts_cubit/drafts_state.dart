part of 'drafts_cubit.dart';

enum LoadStatus { idle, loading, success, error }

class DraftsState {
  const DraftsState({
    this.status = LoadStatus.idle,
    this.drafts = const [],
    this.error,
    this.savingId,
    this.deletingId,
  });

  final LoadStatus status;
  final List<TalkamPost> drafts;
  final String? error;

  /// Id of the draft currently being saved (update), if any — drives a
  /// per-item loading indicator instead of blocking the whole list.
  final int? savingId;

  /// Id of the draft currently being deleted, if any.
  final int? deletingId;

  DraftsState copyWith({
    LoadStatus? status,
    List<TalkamPost>? drafts,
    String? error,
    int? savingId,
    bool clearSavingId = false,
    int? deletingId,
    bool clearDeletingId = false,
  }) =>
      DraftsState(
        status: status ?? this.status,
        drafts: drafts ?? this.drafts,
        error: error,
        savingId: clearSavingId ? null : (savingId ?? this.savingId),
        deletingId: clearDeletingId ? null : (deletingId ?? this.deletingId),
      );
}
