part of 'therapist_booking_bloc.dart';

abstract class TherapistBookingEvent extends Equatable {
  const TherapistBookingEvent();

  @override
  List<Object?> get props => [];
}

class TherapistBookingSelectDate extends TherapistBookingEvent {
  final String date;
  const TherapistBookingSelectDate(this.date);

  @override
  List<Object?> get props => [date];
}

class TherapistBookingSelectTime extends TherapistBookingEvent {
  final String time;
  const TherapistBookingSelectTime(this.time);

  @override
  List<Object?> get props => [time];
}

class TherapistBookingUpdateNote extends TherapistBookingEvent {
  final String note;
  const TherapistBookingUpdateNote(this.note);

  @override
  List<Object?> get props => [note];
}

class TherapistBookingSubmit extends TherapistBookingEvent {
  const TherapistBookingSubmit();
}

class TherapistBookingReset extends TherapistBookingEvent {
  final TherapistBookingState? previousState;
  const TherapistBookingReset({this.previousState});

  @override
  List<Object?> get props => [previousState];
}
