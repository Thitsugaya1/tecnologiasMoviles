import 'package:flutter/material.dart';
import 'package:ticketapp/data/Models.dart';
import 'package:ticketapp/data/httpService.dart';
import 'package:ticketapp/data/ticketService.dart';
import 'package:ticketapp/data/userService.dart';
import 'package:ticketapp/ui/admin/adminPage.dart';
import 'package:ticketapp/ui/user/NewTicketForm.dart';
import 'package:ticketapp/ui/login.dart';
import 'package:ticketapp/ui/notImplementedPage.dart';
import 'package:ticketapp/ui/user/userPage.dart';
import 'package:ticketapp/ui/common/MapWidget.dart';
import 'package:ticketapp/ui/common/TomarFoto.dart';
import 'package:camera/camera.dart';

class RouteGenerator {
  HttpService _httpService;
  UserService _userService;
  TicketService _ticketService;
  CameraDescription _camera;
  RouteGenerator(
      this._httpService, this._userService, this._ticketService, this._camera);

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (_userService.userRol) {
      case UserRol.Guest:
        return guestRoutes(settings);
      case UserRol.Client:
        return clientRoutes(settings);
      case UserRol.Admin:
        return adminRoutes(settings);
      default:
        return MaterialPageRoute(builder: (_) => NotImplementedPage());
    }
  }

  Route<dynamic> clientRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => UserMainPage(_ticketService, _userService));
      case '/tickets/new':
        return MaterialPageRoute(builder: (_) => NewTicketForm(_ticketService));
      case 'TakeFoto':
        return MaterialPageRoute(builder: (_) => TomarFoto(_camera));
      default:
        return notImplemented();
    }
  }

  Route<dynamic> guestRoutes(RouteSettings settings) {
    switch (settings.name) {
      case 'TakeFoto':
        return MaterialPageRoute(builder: (_) => TomarFoto(_camera));
      default:
        return MaterialPageRoute(builder: (_) => NewTicketForm(_ticketService));
    }
  }

  Route<dynamic> adminRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => AdminMainpage(_ticketService, _userService));
      default:
        return notImplemented();
    }
  }

  Route<dynamic> notImplemented() {
    return MaterialPageRoute(builder: (_) => NotImplementedPage());
  }
}
