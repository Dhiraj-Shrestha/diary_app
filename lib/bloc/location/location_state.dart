part of 'location_cubit.dart';

abstract class LocationState {}

class LocationLoadingState extends LocationState {}

class LocationLoadedState extends LocationState {
  final Position position;

  LocationLoadedState(this.position);
}

class LocationAddressState extends LocationState {
  final String address;
  LocationAddressState(this.address);
}

class LocationErrorState extends LocationState {
  final String error;

  LocationErrorState(this.error);
}
