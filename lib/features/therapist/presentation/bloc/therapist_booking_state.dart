part of 'therapist_booking_bloc.dart';

enum TherapistBookingStatus { initial, loading, success, failure }

class TherapistBookingState extends Equatable {
  final TherapistBookingStatus status;
  final String? selectedDate;
  final String? selectedTime;
  final String? note;
  final String? errorMessage;

  const TherapistBookingState({
    this.status = TherapistBookingStatus.initial,
    this.selectedDate,
    this.selectedTime,
    this.note,
    this.errorMessage,
  });

  TherapistBookingState copyWith({
    TherapistBookingStatus? status,
    String? selectedDate,
    String? selectedTime,
    String? note,
    String? errorMessage,
  }) {
    return TherapistBookingState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      note: note ?? this.note,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, selectedDate, selectedTime, note, errorMessage];
}
