part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class OnLocationChange extends LocationEvent {
  OnLocationChange({@required this.location});

  final LatLng location;
}
