import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial());

  StreamSubscription<Position> _positionSubscription;

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is OnLocationChange) {
      yield LocationTracking(
        track: true,
        locationExists: true,
        currentLocation: event.location,
      );
    }
  }

  void startTracking() {
    _positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 10,
    ).listen(
      (position) {
        final newLocation = LatLng(position.latitude, position.longitude);
        add(OnLocationChange(location: newLocation));
      },
    );
  }

  void endTracking() => _positionSubscription?.cancel();
}
