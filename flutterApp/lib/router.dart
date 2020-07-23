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

class RouteGenerator {
  HttpService _httpService;
  UserService _userService;
  TicketService _ticketService;
  RouteGenerator(this._httpService, this._userService, this._ticketService);

  Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch (_userService.userRol){
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

  Route<dynamic> clientRoutes(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => UserMainPage(_ticketService, _userService) );
      case '/tickets/new':
        return MaterialPageRoute(builder: (_) => NewTicketForm(_ticketService));
      default:
        return notImplemented();
    }
  }

  Route<dynamic> guestRoutes(RouteSettings settings){
    return MaterialPageRoute(builder: (_) => Login(_userService));
  }

  Route<dynamic> adminRoutes(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => AdminMainpage(_ticketService,  _userService));
      default:
        return notImplemented();
    }
  }

  Route<dynamic> notImplemented(){
    return MaterialPageRoute(builder: (_) => NotImplementedPage());
  }
}