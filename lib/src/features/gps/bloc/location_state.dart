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

class LocationTracking extends LocationState {
  LocationTracking({
    @required bool track,
    @required bool locationExists,
    @required LatLng currentLocation,
  }) : super(
          track: track,
          locationExists: locationExists,
          currentLocation: currentLocation,
        );
}
