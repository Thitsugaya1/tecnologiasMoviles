import 'package:flutter/material.dart';
import 'package:ticketapp/router.dart';

import 'router.dart';

class MyApp extends StatelessWidget {
  final RouteGenerator _routeGenerator;
  MyApp(this._routeGenerator);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicketApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      onGenerateRoute: _routeGenerator.generateRoute,
    );
  }
}
