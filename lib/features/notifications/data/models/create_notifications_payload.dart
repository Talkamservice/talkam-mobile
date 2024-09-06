class CreateNotificationPayload {
  final String title;
  final String message;
  final int notifiableId;
  final String type;
  final int owner;
  final int typeId;
  final int connectionId;

  CreateNotificationPayload({
    required this.title,
    required this.message,
    required this.notifiableId,
    required this.type,
    required this.owner,
    required this.typeId,
    required this.connectionId,
  });

  CreateNotificationPayload copyWith({
    String? title,
    String? message,
    int? notifiableId,
    String? type,
    int? owner,
    int? typeId,
  }) =>
      CreateNotificationPayload(
        title: title ?? this.title,
        message: message ?? this.message,
        notifiableId: notifiableId ?? this.notifiableId,
        type: type ?? this.type,
        owner: owner ?? this.owner,
        typeId: typeId ?? this.typeId,
        connectionId: connectionId,
      );

  // factory CreateNotificationPayload.fromJson(Map<String, dynamic> json) =>
  //     CreateNotificationPayload(
  //       title: json["title"],
  //       message: json["message"],
  //       notifiableId: json["notifiable_id"],
  //       type: json["type"],
  //       typeId: json["type_id"],
  //       owner: json["owner_id"],
  //     );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "notifiable_id": owner,
        "type": type,
        "type_id": typeId,
        "owner_id": notifiableId,
        "extra": {"story_id": "$connectionId"}
      };

  @override
  String toString() {
    return 'CreateNotificationPayload{title: $title, message: $message, notifiableId: $notifiableId, type: $type, owner: $owner, typeId: $typeId}';
  }
}
