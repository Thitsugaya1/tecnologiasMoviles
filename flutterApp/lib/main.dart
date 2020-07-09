import 'package:flutter/material.dart';
import 'package:ticketapp/MyApp.dart';
import 'package:ticketapp/data/httpService.dart';
import 'package:ticketapp/data/ticketService.dart';
import 'package:ticketapp/data/userService.dart';
import 'router.dart';

void main() {
  final HttpService httpService = HttpService();
  final UserService userService = UserService(httpService);
  final TicketService ticketService = TicketService(httpService);
  final RouteGenerator routeGenerator = RouteGenerator(httpService, userService, ticketService);
  runApp(
			MyApp(routeGenerator)
	);
}

