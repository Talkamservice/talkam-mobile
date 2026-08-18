import 'package:intl/intl.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';

mixin MessagingFormatterMixin {
  List<AppMessageModel> sortAndInsertDividers(List<AppMessageModel> messages) {
    // Sort messages in ascending order by time
    messages.sort((a, b) => a.time!.compareTo(b.time!));

    // Initialize the list that will hold messages with dividers
    List<AppMessageModel> messagesWithDividers = [];
    DateTime? previousDate;
    String? lastHeader; // Track the last header added

    // Format strings
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));
    final dateFormat = DateFormat('MMMM d, yyyy'); // Custom date format

    for (var message in messages) {
      if (message.time == null) continue; // Skip if the message has no time

      DateTime currentDate = message.time!;
      String? headerText;

      // Check if it's today, yesterday, or another date
      if (_isSameDay(currentDate, today)) {
        headerText = 'Today';
      } else if (_isSameDay(currentDate, yesterday)) {
        headerText = 'Yesterday';
      } else {
        headerText = dateFormat.format(currentDate);
      }

      // If this is the first message or a new date is detected, add a divider
      if (previousDate == null || !_isSameDay(currentDate, previousDate)) {
        if (headerText != lastHeader) {
          // Only add a new divider if it's different from the last one
          logger.w("Message is ${message.content}");
          logger.w(message.time);
          messagesWithDividers.add(
            AppMessageModel(
              content: headerText,
              iAmSender: false,
              isTyping: false,
              messageType: 'divider',
              conversationId: '',
              receiverId: '',
              time: currentDate,
            ),
          );
          lastHeader = headerText; // Update the last header
        }
      }

      // Add the original message to the list
      messagesWithDividers.add(message);

      // Update the previousDate to current date
      previousDate = currentDate;
    }

    // Return chronological list (oldest first, headers at top)
    return messagesWithDividers;
  }

  // Helper function to check if two dates are the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
