part of 'location_bloc.dart';

// Base class for Google Map states
abstract class LocationState extends Equatable {
  const LocationState();
}

class GoogleMapInitial extends LocationState {
  @override
  List<Object?> get props => [];
}

// Loading state for searching a place on Google Maps
class SearchPlaceLoading extends LocationState {
  @override
  List<Object?> get props => [];
}

// Success state for searching a place on Google Maps
class SearchPlaceSuccess extends LocationState {
  final dynamic placeResult;

  SearchPlaceSuccess(this.placeResult);

  @override
  List<Object?> get props => [placeResult];
}

// Failure state for searching a place on Google Maps
class SearchPlaceFailure extends LocationState {
  final String error;

  SearchPlaceFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class LocationFailure extends LocationState {
  final String error;

  const LocationFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class LocationLoading extends LocationState {
  const LocationLoading();

  @override
  List<Object?> get props => [];
}

class GetCountriesSuccessState extends LocationState {
  final GetCountriesResponse response;

  const GetCountriesSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class GetStateSuccessState extends LocationState {
  final GetStatesResponse response;

  const GetStateSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}
