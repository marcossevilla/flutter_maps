import 'package:flutter/material.dart';

/// MapPage to interact with app's main map
class MapPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'Map';

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => MapPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is MapPage'),
      ),
    );
  }
}
