import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'therapist_booking_state.dart';
part 'therapist_booking_event.dart';

class TherapistBookingBloc extends Bloc<TherapistBookingEvent, TherapistBookingState> {
  TherapistBookingBloc() : super(const TherapistBookingState()) {
    on<TherapistBookingSelectDate>((event, emit) {
      if (state.status == TherapistBookingStatus.initial) {
        emit(state.copyWith(selectedDate: event.date));
      }
    });

    on<TherapistBookingSelectTime>((event, emit) {
      if (state.status == TherapistBookingStatus.initial) {
        emit(state.copyWith(selectedTime: event.time));
      }
    });

    on<TherapistBookingUpdateNote>((event, emit) {
      if (state.status == TherapistBookingStatus.initial) {
        emit(state.copyWith(note: event.note));
      }
    });

    on<TherapistBookingSubmit>((event, emit) async {
      if (state.status == TherapistBookingStatus.initial) {
        emit(state.copyWith(status: TherapistBookingStatus.loading));
        
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 2));

        // Randomly succeed or fail
        final isSuccess = DateTime.now().second % 2 == 0;

        if (isSuccess) {
          emit(state.copyWith(status: TherapistBookingStatus.success));
        } else {
          emit(state.copyWith(
            status: TherapistBookingStatus.failure,
            errorMessage: "Unable to process payment at this time. Please try again.",
          ));
        }
      }
    });

    on<TherapistBookingReset>((event, emit) {
      if (event.previousState != null) {
        emit(event.previousState!);
      } else {
        emit(const TherapistBookingState());
      }
    });
  }
}
