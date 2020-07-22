import 'package:flutter/material.dart';
import 'package:ticketapp/data/ticketService.dart';
import 'package:ticketapp/ui/common/TicketList.dart';

class AdminMainpage extends StatefulWidget {
  TicketService _ticketService;
  AdminMainpage(this._ticketService, {Key key}) : super(key: key);

  @override
  _AdminMainpageState createState() => _AdminMainpageState();
}

class _AdminMainpageState extends State<AdminMainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("Tickets"),
        actions: <Widget>[
          Container(
            height: 40,
            width: 40,
            child: Icon(Icons.replay),
          ),
          Container(
            height: 40,
            width: 40,
            child: Icon(Icons.add)
          )
        ],
      ),
      body: Center(
        child: TicketList(this.widget._ticketService),
      ),
    );
  }
}