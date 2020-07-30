import 'package:flutter/material.dart';
import 'package:ticketapp/data/userService.dart';
import 'package:ticketapp/ui/common/drawer.dart';

class ProfilePage extends StatelessWidget {
	final UserService _userService;
  const ProfilePage(this._userService,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      drawer: MenuDrawer(_userService),
      body: SingleChildScrollView(child: ProfileWidget(),),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  final Map<String, String> dummy = 
  {'Image': "https://thispersondoesnotexist.com/image", 
  'Username': "Username", 
  "Tickets": "8"};

  ProfileWidget({Key key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
       child: Container(
         margin: EdgeInsets.all(20),
         child: content(context),
       )
    );
  }

  Widget content(BuildContext context){
    return Column(
      children: <Widget>[
         picture(),
         username(false),
         ticketsRealizados()
      ]
    );
  }

  Widget username(bool edit){
    return Row(
      children: <Widget>[
        Expanded(child: 
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: "Username",
              labelText: "Nombre"
            ),
            initialValue: widget.dummy['Username'],
          )
        ),
        IconButton(icon: Icon(Icons.edit), onPressed: (){})
      ],      
    );
  }

  Widget picture(){
    return Container(
      height: 300.0,
      width: 300.0,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(widget.dummy['Image'])
              )
            ),
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment(0.9, 0.9),            
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 5),
              ),
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: (){})
              )
          )
        ]
      )
    );
  }
  
  Widget ticketsRealizados(){
    return Row(
      children: <Widget>[
        Expanded(child: 
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.info),
              hintText: "8",
              labelText: "Tickets Realizados"
            ),
            initialValue: widget.dummy["Tickets"],
          )
        )
      ]
    );
  }
}
