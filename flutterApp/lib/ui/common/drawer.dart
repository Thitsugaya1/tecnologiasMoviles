import 'package:flutter/material.dart';
import 'package:ticketapp/data/userService.dart';

class MenuDrawer extends StatelessWidget {
  final UserService _userService;

  const MenuDrawer(this._userService, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: drawerRow(context)
    );
  }

  Widget title(){
    return ListTile(
      title: Text("TicketApp", textScaleFactor: 2,)
    );
  }

  Widget drawerRow(BuildContext context){ 
    return ListView(
      children: <Widget>[
        title(),
        divider(),
        ListTile(
          leading: Icon(Icons.folder),
          title: Text("Tickets"),
          onTap: (){
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text("Favoritos"),
          onTap: (){
          }
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Ver Perfil"),
          onTap: (){
            Navigator.pushNamed(context, '/profile');
          }
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Configuración"),
          onTap: (){}
        ),
        divider(),
        ListTile(
          leading: Icon(Icons.person_outline),
          title: Text("Cerrar Sesión"),
          onTap: (){
            this._userService.logout();
            Navigator.pushReplacementNamed(context, '/');
          }
        ),
      ]
    );
  }

  Widget divider(){
    return Divider(
      height: 10,
      thickness: 3,
    );
  }



}