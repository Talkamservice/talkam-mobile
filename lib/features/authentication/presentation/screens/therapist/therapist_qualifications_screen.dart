import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/document_upload_tile.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist_application/data/models/therapist_application_data.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';

/// Step 2 of 5 — document upload.
class TherapistQualificationsScreen extends StatelessWidget {
  const TherapistQualificationsScreen({super.key, required this.bloc});

  final TherapistApplicationBloc bloc;

  Future<void> _pickFile(DocumentId id) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png'],
      withData: false,
    );
    final file = result?.files.firstOrNull;
    if (file != null) {
      bloc.add(StartDocumentUploadEvent(id, file.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        bgColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<TherapistApplicationBloc, TherapistApplicationState>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StepProgressBar(
                      step: 2,
                      totalSteps: 5,
                      label: "Qualifications",
                    ),
                    20.verticalSpace,
                    const TextView(
                      text: "Upload your documents",
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Pallets.boldBlackV2,
                    ),
                    4.verticalSpace,
                    const TextView(
                      text:
                          "Documents are encrypted and reviewed by our verification team.",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Pallets.grey400,
                      lineHeight: 1.4,
                    ),
                    20.verticalSpace,
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  itemCount: DocumentId.values.length,
                  separatorBuilder: (_, __) => 14.verticalSpace,
                  itemBuilder: (context, index) {
                    final id = DocumentId.values[index];
                    final doc = state.document(id);
                    return DocumentUploadTile(
                      icon: id.icon,
                      title: id.shortLabel,
                      subtitle: id.subtitle,
                      status: doc.status,
                      progress: doc.progress,
                      fileName: doc.fileName,
                      onBrowse: () => _pickFile(id),
                      onCancel: () =>
                          bloc.add(CancelDocumentUploadEvent(id)),
                      onRemove: () => bloc.add(RemoveDocumentEvent(id)),
                      onRetry: () => _pickFile(id),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 8.h),
                child: Column(
                  children: [
                    CustomButton(
                      elevation: 0,
                      onPressed: state.allDocumentsUploaded
                          ? () => context.pushNamed(
                                PageUrl.therapistSpecialtiesScreen,
                                extra: bloc,
                              )
                          : null,
                      bgColor: Pallets.blueBubbleColor,
                      child: const TextView(
                        text: "Save and Continue",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    12.verticalSpace,
                    TextView(
                      text: "Save draft & continue later",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Pallets.grey400,
                      onTap: () => context.pop(),
                    ),
                  ],
                ),
              ),
              24.verticalSpace,
            ],
          );
        },
      ),
    );
  }
}
