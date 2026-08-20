/// GET/POST `/user/privacy-settings` (v2). Distinct from the onboarding
/// consent flow in `lib/features/privacy` (`/user/consents`) — this covers
/// in-app privacy toggles + the 2FA flag.
class PrivacySettings {
  const PrivacySettings({
    this.anonymousMode = false,
    this.readReceipts = true,
    this.activityStatus = true,
    this.twoFactorEnabled = false,
  });

  final bool anonymousMode;
  final bool readReceipts;
  final bool activityStatus;
  final bool twoFactorEnabled;

  factory PrivacySettings.fromJson(Map<String, dynamic> json) =>
      PrivacySettings(
        anonymousMode: json['anonymous_mode'] ?? false,
        readReceipts: json['read_receipts'] ?? true,
        activityStatus: json['activity_status'] ?? true,
        twoFactorEnabled: json['two_factor_enabled'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'anonymous_mode': anonymousMode,
        'read_receipts': readReceipts,
        'activity_status': activityStatus,
        'two_factor_enabled': twoFactorEnabled,
      };

  PrivacySettings copyWith({
    bool? anonymousMode,
    bool? readReceipts,
    bool? activityStatus,
    bool? twoFactorEnabled,
  }) =>
      PrivacySettings(
        anonymousMode: anonymousMode ?? this.anonymousMode,
        readReceipts: readReceipts ?? this.readReceipts,
        activityStatus: activityStatus ?? this.activityStatus,
        twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      );

  @override
  bool operator ==(Object other) =>
      other is PrivacySettings &&
      other.anonymousMode == anonymousMode &&
      other.readReceipts == readReceipts &&
      other.activityStatus == activityStatus &&
      other.twoFactorEnabled == twoFactorEnabled;

  @override
  int get hashCode => Object.hash(
      anonymousMode, readReceipts, activityStatus, twoFactorEnabled);
}
