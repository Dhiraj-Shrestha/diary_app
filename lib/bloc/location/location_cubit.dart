import 'package:diary_app/models/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationLoadingState());

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      await getLocation();
    } else {
      emit(LocationErrorState('Location permission denied.'));
    }
  }

  Future<void> getLocation() async {
    try {
      final locationData = LocationData();
      locationData.currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      await _getAddressFromLatLng(locationData.currentPosition!);

      // emit(LocationLoadedState(locationData.currentPosition!));
    } catch (e) {
      emit(LocationErrorState('Error getting location: $e'));
    }
  }

  Future<void> _getAddressFromLatLng(Position locationData) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude,
        locationData.longitude,
      );

      final Placemark place = placemarks[0];

      final String currentAddress =
          "${place.locality}, ${place.postalCode}, ${place.country}";

      emit(LocationAddressState(currentAddress));
    } catch (e) {
      print(e);
    }
  }
}
