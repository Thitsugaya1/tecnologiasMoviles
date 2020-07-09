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
        primarySwatch: Colors.cyan,
        primaryColor: Colors.cyan[800]
      ),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: _routeGenerator.generateRoute,
    );
  }
}
