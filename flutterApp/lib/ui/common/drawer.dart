import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: drawerRow()
    );
  }

  Widget title(){
    return ListTile(
      title: Text("TicketApp", textScaleFactor: 2,)
    );
  }

  Widget drawerRow(){ 
    return ListView(
      children: <Widget>[
        title(),
        divider(),
        ListTile(
          leading: Icon(Icons.folder),
          title: Text("Tickets"),
          onTap: (){},
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text("Favoritos"),
          onTap: (){}
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Ver Perfil"),
          onTap: (){}
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
          onTap: (){}
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