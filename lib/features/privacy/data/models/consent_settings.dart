import 'dart:convert';

/// The individual consents shown on the Data & Privacy screen.
enum ConsentType {
  accountOperation,
  sessionDelivery,
  anonymousCommunity,
  anonymisedResearch;

  /// Consents the user cannot opt out of — Confirm stays disabled until every
  /// required consent is granted.
  bool get isRequired =>
      this == ConsentType.accountOperation ||
      this == ConsentType.sessionDelivery;

  String get title => switch (this) {
        ConsentType.accountOperation => 'Account operation',
        ConsentType.sessionDelivery => 'Session delivery',
        ConsentType.anonymousCommunity => 'Anonymous community',
        ConsentType.anonymisedResearch => 'Anonymised research',
      };

  String get description => switch (this) {
        ConsentType.accountOperation =>
          'Processing data to maintain your profile and access.',
        ConsentType.sessionDelivery =>
          'Managing video/audio stability, reminders, and notes.',
        ConsentType.anonymousCommunity =>
          'Join peer groups using a pseudonym for privacy.',
        ConsentType.anonymisedResearch =>
          'Non-identifiable data improves mental health research.',
      };
}

/// Immutable snapshot of every consent decision.
class ConsentSettings {
  const ConsentSettings({
    this.accountOperation = false,
    this.sessionDelivery = false,
    this.anonymousCommunity = false,
    this.anonymisedResearch = false,
  });

  final bool accountOperation;
  final bool sessionDelivery;
  final bool anonymousCommunity;
  final bool anonymisedResearch;

  bool valueOf(ConsentType type) => switch (type) {
        ConsentType.accountOperation => accountOperation,
        ConsentType.sessionDelivery => sessionDelivery,
        ConsentType.anonymousCommunity => anonymousCommunity,
        ConsentType.anonymisedResearch => anonymisedResearch,
      };

  ConsentSettings withValue(ConsentType type, bool value) => switch (type) {
        ConsentType.accountOperation => copyWith(accountOperation: value),
        ConsentType.sessionDelivery => copyWith(sessionDelivery: value),
        ConsentType.anonymousCommunity => copyWith(anonymousCommunity: value),
        ConsentType.anonymisedResearch => copyWith(anonymisedResearch: value),
      };

  /// Every required consent has been granted.
  bool get hasRequiredConsents =>
      ConsentType.values.where((t) => t.isRequired).every(valueOf);

  ConsentSettings copyWith({
    bool? accountOperation,
    bool? sessionDelivery,
    bool? anonymousCommunity,
    bool? anonymisedResearch,
  }) =>
      ConsentSettings(
        accountOperation: accountOperation ?? this.accountOperation,
        sessionDelivery: sessionDelivery ?? this.sessionDelivery,
        anonymousCommunity: anonymousCommunity ?? this.anonymousCommunity,
        anonymisedResearch: anonymisedResearch ?? this.anonymisedResearch,
      );

  Map<String, dynamic> toJson() => {
        'account_operation': accountOperation,
        'session_delivery': sessionDelivery,
        'anonymous_community': anonymousCommunity,
        'anonymised_research': anonymisedResearch,
      };

  factory ConsentSettings.fromJson(Map<String, dynamic> json) =>
      ConsentSettings(
        accountOperation: json['account_operation'] ?? false,
        sessionDelivery: json['session_delivery'] ?? false,
        anonymousCommunity: json['anonymous_community'] ?? false,
        anonymisedResearch: json['anonymised_research'] ?? false,
      );

  /// Parses the `/user/consents` GET/POST response shape, where each key
  /// maps to `{key, required, granted, granted_at, revoked_at,
  /// policy_version}` rather than a flat boolean.
  factory ConsentSettings.fromApiJson(Map<String, dynamic> json) =>
      ConsentSettings(
        accountOperation: json['account_operation']?['granted'] ?? false,
        sessionDelivery: json['session_delivery']?['granted'] ?? false,
        anonymousCommunity: json['anonymous_community']?['granted'] ?? false,
        anonymisedResearch: json['anonymised_research']?['granted'] ?? false,
      );

  String encode() => jsonEncode(toJson());

  factory ConsentSettings.decode(String raw) =>
      ConsentSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);

  @override
  bool operator ==(Object other) =>
      other is ConsentSettings &&
      other.accountOperation == accountOperation &&
      other.sessionDelivery == sessionDelivery &&
      other.anonymousCommunity == anonymousCommunity &&
      other.anonymisedResearch == anonymisedResearch;

  @override
  int get hashCode => Object.hash(accountOperation, sessionDelivery,
      anonymousCommunity, anonymisedResearch);
}
