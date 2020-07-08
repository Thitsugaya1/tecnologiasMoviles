import 'package:flutter/material.dart';
import 'package:ticketapp/MyApp.dart';
import 'package:ticketapp/data/httpService.dart';
import 'package:ticketapp/data/userService.dart';
import 'router.dart';

void main() {
  final HttpService httpService = HttpService();
  final UserService userService = UserService(httpService);
  final RouteGenerator routeGenerator = RouteGenerator(httpService, userService);
  runApp(
			MyApp(routeGenerator)
	);
}

