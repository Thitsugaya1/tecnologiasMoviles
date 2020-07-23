import 'package:flutter/material.dart';
import 'package:ticketapp/data/ticketService.dart';
import 'package:ticketapp/data/userService.dart';
import 'package:ticketapp/ui/common/TicketList.dart';

class AdminMainpage extends StatefulWidget {
  final TicketService _ticketService;
  final UserService _userService;
  AdminMainpage(this._ticketService, this._userService, {Key key}) : super(key: key);

  @override
  _AdminMainpageState createState() => _AdminMainpageState();
}

class _AdminMainpageState extends State<AdminMainpage> {
  int action = 0;
  
  changeAction(int action){
    setState(() {
      this.action = action;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("Tickets"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.replay),
            onPressed: (){
                changeAction(2);
            },
          ),
          Container(
            height: 40,
            width: 40,
            child: Icon(Icons.add)
          )
        ],
      ),
      body: Center(
        child: TicketList(this.widget._ticketService, widget._userService),
      ),
    );
  }
}