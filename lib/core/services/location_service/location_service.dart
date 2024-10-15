import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:talkam/common/models/get_countries_response.dart';
import 'package:talkam/common/models/get_states_response.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/api_error.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';

class LocationService {
  static const _errorMsgLocationDisabled = 'Location services are disabled. Please enable the services';
  static const _errorMsgPermissionDenied = 'Location permissions are denied';
  static const _errorMsgPermissionDeniedForever = 'Location permissions are permanently denied, we cannot request permissions.';

  Future<bool> _handleLocationPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      logger.w(_errorMsgLocationDisabled);
      return false;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      try {
        permission = await Geolocator.requestPermission();
      } catch (e) {
        logger.e(e);
      }
      if (permission == LocationPermission.denied) {
        logger.w(_errorMsgPermissionDenied);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      logger.w(_errorMsgPermissionDeniedForever);
      return false;
    }

    return true;
  }

  Future<Position> getCurrentPosition() async {
    if (!await _handleLocationPermission()) {
      throw ApiError('Location Permission Denied');
    }

    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
      // return await _getAddressFromLatLng(position);
    } catch (e) {
      logger.i(e);
      rethrow;
      // return '';
    }
  }

  Future<Location> getLocationFromAddress(String address) async {
    if (!await _handleLocationPermission()) {
      return Location(latitude: 6.5244, longitude: 3.3792, timestamp: DateTime.now());
    }

    try {
      final locations = await locationFromAddress(address);
      if (locations.isNotEmpty) return locations.first;
    } catch (e) {
      logger.e(e.toString());
    }

    return Location(latitude: 6.5244, longitude: 3.3792, timestamp: DateTime.now());
  }

  Future<Position?> getLatLong() async {
    if (!await _handleLocationPermission()) return null;

    try {
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<String> _getAddressFromLatLng(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks[0];
        return '${place.street} ${place.subLocality} ${place.locality} ${place.country}';
      }
    } catch (e) {
      logger.e(e);
    }
    return '';
  }

  Future<bool> permissionGranted() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      logger.w(_errorMsgLocationDisabled);
      return false;
    }
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      return false;
    }
    if (permission == LocationPermission.deniedForever) {
      logger.w(_errorMsgPermissionDeniedForever);
      return false;
    }

    return true;
  }

  Future<GetCountriesResponse> getCountries() async {
    try {
      var response = await NetworkService().call(UrlConfig.countries, RequestMethod.get);
      return GetCountriesResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<GetStatesResponse> getStates(String countryId) async {
    try {
      var response = await NetworkService().call(UrlConfig.states, RequestMethod.get, queryParams: {"country_id": countryId});
      return GetStatesResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
