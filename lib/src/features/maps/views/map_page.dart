import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../gps/bloc/location_bloc.dart';

/// MapPage to interact with app's main map
class MapPage extends StatefulWidget {
  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => MapPage());

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    context.read<LocationBloc>().startTracking();
    super.initState();
  }

  @override
  void dispose() {
    context.read<LocationBloc>().endTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (_, state) {
            if (state is LocationTracking) {
              return Text('${state.currentLocation}');
            } else {
              return const Text('not tracking');
            }
          },
        ),
      ),
    );
  }
}
