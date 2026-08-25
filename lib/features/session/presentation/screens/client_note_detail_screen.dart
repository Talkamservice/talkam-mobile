import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_switch.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/inline_select_field.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';
import 'package:talkam/features/therapist/presentation/bloc/therapist_client_cubit/therapist_client_cubit.dart';

const _kNoteStatusOptions = ['draft', 'final'];

/// `GET`/`POST /therapist/sessions/{id}/notes` — a single session's private
/// note, editable in place. Tags reuse the same interest-topics vocabulary
/// as the rest of the app (`GET /user/interest-topics`, via [PostBloc] —
/// same mechanism `TherapistSpecialtiesScreen` uses for specialties).
class ClientNoteDetailScreen extends StatefulWidget {
  final int sessionId;

  const ClientNoteDetailScreen({super.key, required this.sessionId});

  @override
  State<ClientNoteDetailScreen> createState() => _ClientNoteDetailScreenState();
}

class _ClientNoteDetailScreenState extends State<ClientNoteDetailScreen> {
  final cubit = TherapistClientCubit(injector.get<TherapistRepository>());
  final _postBloc = PostBloc(injector.get());

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  List<int> _tags = [];
  bool _sharedWithClient = false;
  String _status = 'draft';
  bool _loadedIntoForm = false;

  @override
  void initState() {
    super.initState();
    cubit.getSessionNote(widget.sessionId);
    _postBloc.add(const PostEvent.getInterestTopics());
  }

  @override
  void dispose() {
    cubit.close();
    _postBloc.close();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _populateForm(TherapistClientState state) {
    if (_loadedIntoForm || state.note == null) return;
    _loadedIntoForm = true;
    final note = state.note!;
    _titleController.text = note.title;
    _contentController.text = note.content;
    _tags = List<int>.from(note.tags);
    _sharedWithClient = note.sharedWithClient;
    _status = _kNoteStatusOptions.contains(note.status) ? note.status : 'draft';
  }

  Future<void> _save() async {
    final success = await cubit.saveSessionNote(
      widget.sessionId,
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      sharedWithClient: _sharedWithClient,
      status: _status,
      tags: _tags,
    );
    if (!mounted) return;
    if (success) {
      CustomDialogs.success("Note saved");
    } else {
      CustomDialogs.error(cubit.state.saveNoteError ?? "Couldn't save note");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TherapistClientCubit, TherapistClientState>(
      bloc: cubit,
      builder: (context, state) {
        _populateForm(state);
        final saving = state.savingNote;

        return Scaffold(
          backgroundColor: Pallets.white,
          appBar: const CustomAppBar(
            tittle: TextView(
              text: "Session Note",
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Pallets.boldBlack,
            ),
            centerTile: false,
          ),
          body: switch (state.noteStatus) {
            LoadStatus.idle ||
            LoadStatus.loading =>
              Center(child: CustomDialogs.getLoading(size: 50)),
            LoadStatus.error => AppErrorWidget(
                message: state.noteError ?? "Something went wrong",
                onTap: () => cubit.getSessionNote(widget.sessionId),
              ),
            LoadStatus.success => SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OutlinedFormField(
                      placeHolder: "Title",
                      hint: "e.g. Sleep improvement - CBT journaling assigned",
                      controller: _titleController,
                    ),
                    16.verticalSpace,
                    OutlinedFormField(
                      placeHolder: "Content",
                      hint: "Session notes…",
                      controller: _contentController,
                      maxLine: 10,
                      minLine: 6,
                    ),
                    16.verticalSpace,
                    const TextView(
                      text: "Tags",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Pallets.boldBlackV2,
                    ),
                    8.verticalSpace,
                    BlocBuilder<PostBloc, PostState>(
                      bloc: _postBloc,
                      builder: (context, postState) {
                        final categories = postState.maybeWhen(
                          orElse: () => const <PostCategory>[],
                          getInterestTopicsSuccess: (response) => response.data,
                        );
                        final isLoading = postState.maybeWhen(
                          orElse: () => false,
                          getInterestTopicsLoading: () => true,
                        );
                        if (isLoading) {
                          return Center(
                              child: CustomDialogs.getLoading(size: 32));
                        }

                        final ids = categories
                            .map((c) => int.parse(c.id.toString()))
                            .toList();
                        String labelFor(int id) => categories
                            .firstWhere((c) => int.parse(c.id.toString()) == id)
                            .name
                            .toString();

                        return InlineSelectField<int>(
                          hint: "Select tags",
                          options: ids,
                          labelBuilder: labelFor,
                          multiple: true,
                          values: _tags,
                          onMultipleChanged: (values) =>
                              setState(() => _tags = values),
                        );
                      },
                    ),
                    16.verticalSpace,
                    InlineSelectField<String>(
                      label: "Status",
                      hint: "Select status",
                      options: _kNoteStatusOptions,
                      labelBuilder: (v) => v[0].toUpperCase() + v.substring(1),
                      value: _status,
                      onSingleChanged: (v) => setState(() => _status = v),
                    ),
                    16.verticalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextView(
                                  text: "Share with client",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                4.verticalSpace,
                                const TextView(
                                  text:
                                      "Visible on the client's booking detail as a shared note.",
                                  fontSize: 12,
                                  color: Pallets.grey400,
                                ),
                              ],
                            ),
                          ),
                          CustomSwitch(
                            value: _sharedWithClient,
                            onChanged: (v) =>
                                setState(() => _sharedWithClient = v),
                          ),
                        ],
                      ),
                    ),
                    28.verticalSpace,
                    CustomButton(
                      elevation: 0,
                      onPressed: saving ? null : _save,
                      child: saving
                          ? CustomDialogs.getLoading(
                              size: 24, color: Colors.white)
                          : const TextView(
                              text: "Save Note",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                    ),
                    24.verticalSpace,
                  ],
                ),
              ),
          },
        );
      },
    );
  }
}
