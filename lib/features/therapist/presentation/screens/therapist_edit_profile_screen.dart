import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/outlined_form_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/profile/presentation/widgets/select_avater_sheet.dart';
import 'package:talkam/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';

class TherapistEditProfileScreen extends StatefulWidget {
  const TherapistEditProfileScreen({super.key});

  @override
  State<TherapistEditProfileScreen> createState() => _TherapistEditProfileScreenState();
}

class _TherapistEditProfileScreenState extends State<TherapistEditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  dynamic selectedImage;
  String _selectedExperience = '8 years';

  static const int _bioMaxLength = 300;

  final List<String> experienceOptions = [
    '1 year',
    '2 years',
    '3 years',
    '4 years',
    '5 years',
    '6 years',
    '7 years',
    '8 years',
    '9 years',
    '10+ years'
  ];

  final List<String> availableSlots = [
    'Today 4:00 PM',
    'Tomorrow 10:00 AM',
    'Monday 1:30 PM',
    'Tuesday 3:15 PM',
    'Wednesday 11:45 AM',
    'Thursday 2:00 PM',
  ];
  
  final List<String> selectedSlots = ['Today 4:00 PM', 'Tomorrow 10:00 AM'];

  @override
  void dispose() {
    nameController.dispose();
    titleController.dispose();
    bioController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        padding: EdgeInsets.all(0.0),
        tittleText: "Edit Profile",
        centerTile: false,
        actions: [],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.verticalSpace,

                  // ── Avatar + Change Photo ─────────────────────────
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => selectImage(context),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ImageWidget(
                                size: 100,
                                shape: BoxShape.circle,
                                imageUrl: selectedImage ?? Assets.images.svgs.user,
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: EdgeInsets.all(6.r),
                                  decoration: const BoxDecoration(
                                    color: Pallets.blueBubbleColor,
                                    shape: BoxShape.circle,
                                    border: Border.fromBorderSide(
                                      BorderSide(color: Colors.white, width: 2),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    size: 14.r,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        8.verticalSpace,
                        InkWell(
                          onTap: () => selectImage(context),
                          child: const TextView(
                            text: "Change Photo",
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Pallets.grey400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  28.verticalSpace,

                  // ── Full Name ─────────────────────────────────────
                  TextView(
                    text: "Full Name",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlackV2,
                  ),
                  8.verticalSpace,
                  OutlinedFormField(
                    placeHolder: "Dr. Adewale Kehinde",
                    hint: "Dr. Adewale Kehinde",
                    controller: nameController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Field is required"),
                    ]).call,
                  ),
                  16.verticalSpace,

                  // ── Title/Credential ─────────────────────────────
                  TextView(
                    text: "Title/Credential",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlackV2,
                  ),
                  8.verticalSpace,
                  OutlinedFormField(
                    placeHolder: "Clinical Psychologist - PhD",
                    hint: "Clinical Psychologist - PhD",
                    controller: titleController,
                  ),
                  16.verticalSpace,

                  // ── Years of Experience ──────────────────────────────────
                  TextView(
                    text: "Years of Experience",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlackV2,
                  ),
                  8.verticalSpace,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Pallets.grey75.withValues(alpha: 0.3)),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedExperience,
                        icon: const Icon(Icons.keyboard_arrow_down, color: Pallets.boldBlackV2),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Pallets.boldBlackV2,
                        ),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedExperience = newValue;
                            });
                          }
                        },
                        items: experienceOptions.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  
                  // ── AVAILABLE SLOTS ──────────────────────────────────
                  TextView(
                    text: "AVAILABLE SLOTS",
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Pallets.grey400,
                  ),
                  12.verticalSpace,
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: availableSlots.map((slot) {
                      final isSelected = selectedSlots.contains(slot);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedSlots.remove(slot);
                            } else {
                              selectedSlots.add(slot);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: isSelected ? Pallets.blueBubbleColor : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: TextView(
                            text: slot,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Pallets.boldBlackV2,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  16.verticalSpace,

                  // ── Bio ───────────────────────────────────────────
                  TextView(
                    text: "Bio",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlackV2,
                  ),
                  8.verticalSpace,
                  OutlinedFormField(
                    placeHolder: "Bio",
                    hint: "Finding my way through life, one day at a time.",
                    controller: bioController,
                    maxLine: 5,
                    minLine: 5,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(_bioMaxLength),
                    ],
                  ),
                  6.verticalSpace,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextView(
                      text: "${bioController.text.length}/$_bioMaxLength",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Pallets.grey400,
                    ),
                  ),
                  16.verticalSpace,
                  
                  // ── Session Rate ───────────────────────────────────────────
                  TextView(
                    text: "Session Rate (per 50 min)",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlackV2,
                  ),
                  8.verticalSpace,
                  OutlinedFormField(
                    placeHolder: "e.g. 15000",
                    hint: "e.g. 15000",
                    controller: rateController,
                    inputType: TextInputType.number,
                  ),

                  32.verticalSpace,

                  // ── Save ──────────────────────────────────────────
                  CustomButton(
                    elevation: 0,
                    bgColor: Pallets.blueBubbleColor,
                    onPressed: _onSave,
                    child: const TextView(
                      text: "Save Changes",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  24.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSave() {
    if (formkey.currentState?.validate() ?? false) {
      // TODO: Handle save functionality for therapist profile
      CustomDialogs.success("Therapist profile updated");
      if (mounted) {
        context.pop();
      }
    }
  }

  Future<void> selectImage(BuildContext context) async {
    var image = await CustomDialogs.showBottomSheet(
        context,
        SelectAvatarSheet(
          onAvatarSelected: (p0) {},
          onBackgroundSelector: (p0) {},
        ));
    if (image != null) {
      selectedImage = image;
    }
    setState(() {});
  }
}
