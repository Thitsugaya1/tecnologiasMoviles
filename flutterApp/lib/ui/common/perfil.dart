import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      drawer: Container(child: Text("")),
      body: SingleChildScrollView(child: ProfileWidget(),),
    );
  }
}

class ProfileWidget extends StatefulWidget {
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
            ),
            alignment: Alignment.center,
            child:  Icon(
              Icons.person_pin,
              size: 300,
              )
          ),
          Align(
            alignment: Alignment(0.9, 0.9),            
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 3),
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
            )
          )
        )
      ]
    );
  }
}