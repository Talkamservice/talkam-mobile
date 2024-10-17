part of 'location_bloc.dart';

// Base class for Google Map events
abstract class LocationEvent extends Equatable {
  const LocationEvent();
}

// Event class for searching a place on Google Maps
class SearchPlaceEvent extends LocationEvent {
  final String query;

  SearchPlaceEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class GetStatesEvent extends LocationEvent {
  final String countryId;

  GetStatesEvent(this.countryId);

  @override
  List<Object?> get props => [countryId];
}

class GetCountriesEvent extends LocationEvent {


  const GetCountriesEvent();

  @override
  List<Object?> get props => [];
}
