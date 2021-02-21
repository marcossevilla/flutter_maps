import 'package:flutter/material.dart';
import 'package:flutter_maps/src/features/gps/views/loading_page.dart';

import 'package:permission_handler/permission_handler.dart';

import '../../maps/views/map_page.dart';

/// GPSAccessPage to ask the user for GPS permissions
class GPSAccessPage extends StatefulWidget {
  /// Static named route for page
  static const String route = 'GPSAccess';

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => GPSAccessPage());

  @override
  _GPSAccessPageState createState() => _GPSAccessPageState();
}

class _GPSAccessPageState extends State<GPSAccessPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    debugPrint('=== state: $state ===');

    if (state == AppLifecycleState.resumed) {
      if (await Permission.location.isGranted) {
        await Navigator.of(context).pushReplacement(LoadingPage.go());
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('The app needs GPS access to work...'),
            const SizedBox(height: 20),
            MaterialButton(
              child: const Text(
                'Give access',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              shape: const StadiumBorder(),
              elevation: 0,
              onPressed: () async {
                final status = await Permission.location.request();
                await _handleGPSStatus(status);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleGPSStatus(PermissionStatus status) async {
    switch (status) {
      case PermissionStatus.granted:
        await Navigator.of(context).push(MapPage.go());
        break;
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
      case PermissionStatus.undetermined:
      default:
        await openAppSettings();
        break;
    }
  }
}
