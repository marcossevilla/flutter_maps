part of 'location_bloc.dart';

@immutable
abstract class LocationState {
  LocationState({
    this.track = true,
    this.locationExists = false,
    this.currentLocation,
  });

  final bool track;
  final bool locationExists;
  final LatLng currentLocation;
}

class LocationInitial extends LocationState {}
