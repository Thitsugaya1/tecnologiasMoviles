import 'package:flutter/material.dart';
import 'package:ticketapp/Models.dart';
import 'package:ticketapp/data/httpService.dart';
import 'package:ticketapp/data/userService.dart';
import 'package:ticketapp/ui/user/NewTicketForm.dart';
import 'package:ticketapp/ui/login.dart';
import 'package:ticketapp/ui/notImplementedPage.dart';
import 'package:ticketapp/ui/user/userPage.dart';

import 'ui/login.dart';
import 'ui/user/userPage.dart';

class RouteGenerator {
  HttpService _httpService;
  UserService _userService;
  RouteGenerator(this._httpService, this._userService);

  Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch (_userService.userRol){
      case UserRol.Guest:
        return guestRoutes(settings);
      case UserRol.Client:
        return clientRoutes(settings);
      default: 
        return MaterialPageRoute(builder: (_) => NotImplementedPage());
    }
  }

  Route<dynamic> clientRoutes(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => UserMainPage() );
      case '/tickets/new':
        return MaterialPageRoute(builder: (_) => NewTicketForm());
      default:
        return notImplemented();
    }
  }

  Route<dynamic> guestRoutes(RouteSettings settings){
    return MaterialPageRoute(builder: (_) => Login(_userService));
  }

  Route<dynamic> adminRoutes(RouteSettings settings){
    return MaterialPageRoute(builder: (_) => NotImplementedPage());
  }

  Route<dynamic> notImplemented(){
    return MaterialPageRoute(builder: (_) => NotImplementedPage());
  }
}