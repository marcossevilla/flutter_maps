import 'package:flutter/material.dart';

import '../../maps/views/map_page.dart';

/// LoadingPage to show the permission request for GPS on hold
class LoadingPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'Loading';

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => LoadingPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _checkGPSLocationPermission(context),
          builder: (context, snapshot) {
            return const CircularProgressIndicator(strokeWidth: 2);
          },
        ),
      ),
    );
  }

  Future _checkGPSLocationPermission(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    await Navigator.of(context).push(MapPage.go());
  }
}
