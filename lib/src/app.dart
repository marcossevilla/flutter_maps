import 'package:flutter/material.dart';

import 'features/gps/views/loading_page.dart';

class FlutterMapsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterMaps',
      home: LoadingPage(),
    );
  }
}
