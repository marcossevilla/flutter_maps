import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../features/maps/views/map_page.dart';

import 'gps_access_page.dart';

/// LoadingPage to show the permission request for GPS on hold
class LoadingPage extends StatefulWidget {
  /// Static named route for page
  static const String route = 'Loading';

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => LoadingPage());

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    debugPrint('=== state: $state ===');

    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        await Navigator.of(context).pushReplacement(MapPage.go());
      }
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _checkGPSLocationPermission(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data);
            } else {
              return CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).primaryColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future _checkGPSLocationPermission(BuildContext context) async {
    final isGPSGranted = await Permission.location.isGranted;
    final isGPSActive = await Geolocator.isLocationServiceEnabled();

    if (isGPSGranted && isGPSActive) {
      await Navigator.of(context).push(MapPage.go());
      return 'All good! Navigating to next page...';
    } else if (!isGPSGranted) {
      await Navigator.of(context).push(GPSAccessPage.go());
      return 'You need to give GPS access';
    } else {
      return 'Turn GPS on';
    }
  }
}
