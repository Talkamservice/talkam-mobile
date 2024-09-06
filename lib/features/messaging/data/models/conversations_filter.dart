class ConversationsFilter {
  final String status;
  final String search;
  final String tab;

  ConversationsFilter({
    required this.status,
    required this.search,
    required this.tab,
  });

  // Method to convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'search': search,
      'tab': tab,
    };
  }

  // Factory method to create a Dart object from JSON
  factory ConversationsFilter.fromJson(Map<String, dynamic> json) {
    return ConversationsFilter(
      status: json['status'] as String,
      search: json['search'] as String,
      tab: json['tab'] as String,
    );
  }

  factory ConversationsFilter.empty() {
    return ConversationsFilter(
      status: "",
      search: "",
      tab: '',
    );
  }

  // CopyWith method to create a new object with modified properties
  ConversationsFilter copyWith({
    String? status,
    String? search,
    String? tab,
  }) {
    return ConversationsFilter(
      status: status ?? this.status,
      search: search ?? this.search,
      tab: tab ?? this.tab,
    );
  }
}
