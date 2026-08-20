import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:talkam/features/therapist/data/models/availability_slot.dart';
import 'package:talkam/features/therapist/data/models/session_rate.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';

/// Hard ceiling on the bio, matching the member Edit Profile screen.
const int kBioMaxLength = 300;

/// Range offered by the Years of Experience picker.
const int kMinYearsExperience = 1;
const int kMaxYearsExperience = 40;

/// The slice of a therapist's record they can edit themselves.
///
/// Deliberately separate from [TherapistModel]: most of that model is
/// server-owned (rating, reviewsCount, totalSessions, isVerified), and folding
/// the two together would make "has this draft changed?" meaningless.
class TherapistEditableProfile extends Equatable {
  const TherapistEditableProfile({
    this.fullName = '',
    this.title = '',
    this.yearsExperience,
    this.bio = '',
    this.avatarUrl = '',
    this.pendingAvatarPath,
    this.specialties = const [],
    this.sessionRate = '',
    this.availability = const WeeklyAvailability(),
    this.sessionDurationMinutes = kDefaultSessionDurationMinutes,
  });

  final String fullName;
  final String title;
  final int? yearsExperience;
  final String bio;
  final String avatarUrl;

  /// Local file path for a photo just picked but not yet uploaded — takes
  /// display priority over [avatarUrl]. Deliberately excluded from
  /// [toJson]/[encode]: an unsaved pick is ephemeral, like any other unsaved
  /// edit, and a stale local path surviving an app restart would be worse
  /// than just losing the pending pick.
  final String? pendingAvatarPath;
  final List<String> specialties;

  /// Raw digits — see [SessionRate].
  final String sessionRate;

  final WeeklyAvailability availability;
  final int sessionDurationMinutes;

  SessionRate get rate => SessionRate(sessionRate);

  bool get isFullNameValid => fullName.trim().isNotEmpty;
  bool get isTitleValid => title.trim().isNotEmpty;
  // Code units, matching LengthLimitingTextInputFormatter and the on-screen
  // counter — all three must agree or the count and the limit disagree.
  bool get isBioValid => bio.trim().isNotEmpty && bio.length <= kBioMaxLength;
  bool get hasAvailability => availability.isNotEmpty;
  bool get hasSpecialties => specialties.isNotEmpty;

  bool get isValid =>
      isFullNameValid &&
      isTitleValid &&
      yearsExperience != null &&
      isBioValid &&
      hasSpecialties &&
      hasAvailability &&
      rate.isValid;

  TherapistEditableProfile copyWith({
    String? fullName,
    String? title,
    int? yearsExperience,
    String? bio,
    String? avatarUrl,
    String? pendingAvatarPath,
    List<String>? specialties,
    String? sessionRate,
    WeeklyAvailability? availability,
    int? sessionDurationMinutes,
  }) =>
      TherapistEditableProfile(
        fullName: fullName ?? this.fullName,
        title: title ?? this.title,
        yearsExperience: yearsExperience ?? this.yearsExperience,
        bio: bio ?? this.bio,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        pendingAvatarPath: pendingAvatarPath ?? this.pendingAvatarPath,
        specialties: specialties ?? this.specialties,
        sessionRate: sessionRate ?? this.sessionRate,
        availability: availability ?? this.availability,
        sessionDurationMinutes:
            sessionDurationMinutes ?? this.sessionDurationMinutes,
      );

  /// Seeds a draft from the therapist's current record, so opening the screen
  /// shows what the profile shows rather than an empty form.
  factory TherapistEditableProfile.fromTherapist(TherapistModel therapist) =>
      TherapistEditableProfile(
        fullName: therapist.name,
        title: therapist.title,
        yearsExperience: therapist.yearsExperience,
        bio: therapist.about,
        avatarUrl: therapist.avatarUrl,
        specialties: List.unmodifiable(therapist.specialties),
        sessionRate: therapist.pricePerSession.toInt().toString(),
        availability: therapist.availability,
      );

  /// Overlays this draft onto [base], leaving server-owned fields untouched.
  /// The only direction data flows between the two models.
  TherapistModel applyTo(TherapistModel base) => base.copyWith(
        name: fullName.trim(),
        title: title.trim(),
        yearsExperience: yearsExperience ?? base.yearsExperience,
        about: bio.trim(),
        avatarUrl: avatarUrl,
        specialties: specialties,
        pricePerSession:
            (rate.amount ?? base.pricePerSession.toInt()).toDouble(),
        availability: availability,
      );

  Map<String, dynamic> toJson() => {
        'full_name': fullName,
        'title': title,
        'years_experience': yearsExperience,
        'bio': bio,
        'avatar_url': avatarUrl,
        'specialties': specialties,
        'session_rate': sessionRate,
        'availability': availability.toJson(),
        'session_duration_minutes': sessionDurationMinutes,
      };

  factory TherapistEditableProfile.fromJson(Map<String, dynamic> json) =>
      TherapistEditableProfile(
        fullName: json['full_name'] as String? ?? '',
        title: json['title'] as String? ?? '',
        yearsExperience: json['years_experience'] as int?,
        bio: json['bio'] as String? ?? '',
        avatarUrl: json['avatar_url'] as String? ?? '',
        specialties: List<String>.unmodifiable(
          (json['specialties'] as List?)?.whereType<String>() ?? const [],
        ),
        sessionRate: json['session_rate'] as String? ?? '',
        availability: WeeklyAvailability.fromJson(
            (json['availability'] as List?) ?? const []),
        sessionDurationMinutes: json['session_duration_minutes'] as int? ??
            kDefaultSessionDurationMinutes,
      );

  String encode() => jsonEncode(toJson());

  factory TherapistEditableProfile.decode(String raw) =>
      TherapistEditableProfile.fromJson(
          jsonDecode(raw) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        fullName,
        title,
        yearsExperience,
        bio,
        avatarUrl,
        pendingAvatarPath,
        specialties,
        sessionRate,
        availability,
        sessionDurationMinutes,
      ];
}
