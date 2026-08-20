/// GET/POST `/user/notification-preferences` (v2). Flat boolean payload —
/// unrelated to the older wrapped v1 shape in [NotificationsPreferenceResponse].
/// SMS has no server-side field; the UI keeps a toggle for it but it is never
/// sent, since unknown keys (including `can_receive_sms`) are rejected.
class NotificationPreferences {
  const NotificationPreferences({
    this.sessionConfirmation = true,
    this.sessionReminders = true,
    this.postSessionFeedback = true,
    this.paymentConfirmations = true,
    this.repliesToPosts = true,
    this.promotionsUpdates = true,
    this.wellnessNudges = true,
    this.canReceivePush = true,
    this.canReceiveMail = true,
  });

  final bool sessionConfirmation;
  final bool sessionReminders;
  final bool postSessionFeedback;
  final bool paymentConfirmations;
  final bool repliesToPosts;
  final bool promotionsUpdates;
  final bool wellnessNudges;
  final bool canReceivePush;
  final bool canReceiveMail;

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) =>
      NotificationPreferences(
        sessionConfirmation: json['session_confirmation'] ?? true,
        sessionReminders: json['session_reminders'] ?? true,
        postSessionFeedback: json['post_session_feedback'] ?? true,
        paymentConfirmations: json['payment_confirmations'] ?? true,
        repliesToPosts: json['replies_to_posts'] ?? true,
        promotionsUpdates: json['promotions_updates'] ?? true,
        wellnessNudges: json['wellness_nudges'] ?? true,
        canReceivePush: json['can_receive_push'] ?? true,
        canReceiveMail: json['can_receive_mail'] ?? true,
      );

  Map<String, dynamic> toJson() => {
        'session_confirmation': sessionConfirmation,
        'session_reminders': sessionReminders,
        'post_session_feedback': postSessionFeedback,
        'payment_confirmations': paymentConfirmations,
        'replies_to_posts': repliesToPosts,
        'promotions_updates': promotionsUpdates,
        'wellness_nudges': wellnessNudges,
        'can_receive_push': canReceivePush,
        'can_receive_mail': canReceiveMail,
      };

  NotificationPreferences copyWith({
    bool? sessionConfirmation,
    bool? sessionReminders,
    bool? postSessionFeedback,
    bool? paymentConfirmations,
    bool? repliesToPosts,
    bool? promotionsUpdates,
    bool? wellnessNudges,
    bool? canReceivePush,
    bool? canReceiveMail,
  }) =>
      NotificationPreferences(
        sessionConfirmation: sessionConfirmation ?? this.sessionConfirmation,
        sessionReminders: sessionReminders ?? this.sessionReminders,
        postSessionFeedback: postSessionFeedback ?? this.postSessionFeedback,
        paymentConfirmations: paymentConfirmations ?? this.paymentConfirmations,
        repliesToPosts: repliesToPosts ?? this.repliesToPosts,
        promotionsUpdates: promotionsUpdates ?? this.promotionsUpdates,
        wellnessNudges: wellnessNudges ?? this.wellnessNudges,
        canReceivePush: canReceivePush ?? this.canReceivePush,
        canReceiveMail: canReceiveMail ?? this.canReceiveMail,
      );

  @override
  bool operator ==(Object other) =>
      other is NotificationPreferences &&
      other.sessionConfirmation == sessionConfirmation &&
      other.sessionReminders == sessionReminders &&
      other.postSessionFeedback == postSessionFeedback &&
      other.paymentConfirmations == paymentConfirmations &&
      other.repliesToPosts == repliesToPosts &&
      other.promotionsUpdates == promotionsUpdates &&
      other.wellnessNudges == wellnessNudges &&
      other.canReceivePush == canReceivePush &&
      other.canReceiveMail == canReceiveMail;

  @override
  int get hashCode => Object.hash(
        sessionConfirmation,
        sessionReminders,
        postSessionFeedback,
        paymentConfirmations,
        repliesToPosts,
        promotionsUpdates,
        wellnessNudges,
        canReceivePush,
        canReceiveMail,
      );
}
