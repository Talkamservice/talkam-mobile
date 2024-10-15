import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talkam/common/models/get_countries_response.dart';
import 'package:talkam/common/models/get_states_response.dart';
import 'package:talkam/core/services/location_service/location_service.dart';

part 'location_event.dart';

part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationService locationService = LocationService();

  LocationBloc() : super(GoogleMapInitial()) {
    on<LocationEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SearchPlaceEvent>(_mapSearchPlaceEvent);
    on<GetStatesEvent>(_mapGetStatesEvent);
    on<GetCountriesEvent>(_mapGetCountriesEvent);
  }

  FutureOr<void> _mapSearchPlaceEvent(SearchPlaceEvent event, Emitter<LocationState> emit) async {
    // emit(SearchPlaceLoading());
    // try {
    //   await locationService(event.query).fold((left) => emit(SearchPlaceFailure(left.errorMessage)), (right) => emit(SearchPlaceSuccess(right)));
    // } on Exception catch (e) {
    //   emit(SearchPlaceFailure(e.toString()));
    // }
  }

  FutureOr<void> _mapGetStatesEvent(GetStatesEvent event, Emitter<LocationState> emit) async {
    emit(const LocationLoading());
    try {
      var response = await locationService.getStates(event.countryId);
      emit(GetStateSuccessState(response));
    } on Exception catch (e) {
      emit(LocationFailure(e.toString()));
    }
  }

  FutureOr<void> _mapGetCountriesEvent(GetCountriesEvent event, Emitter<LocationState> emit) async {
    emit(const LocationLoading());
    try {
      var response = await locationService.getCountries();
      emit(GetCountriesSuccessState(response));
    } on Exception catch (e) {
      emit(LocationFailure(e.toString()));
    }
  }
}
