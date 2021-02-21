import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/gps/bloc/location_bloc.dart';
import 'features/gps/views/loading_page.dart';

class FlutterMapsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocationBloc()),
      ],
      child: MaterialApp(
        title: 'FlutterMaps',
        home: LoadingPage(),
        theme: ThemeData(primaryColor: Colors.black),
      ),
    );
  }
}
