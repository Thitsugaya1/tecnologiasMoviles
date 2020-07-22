import 'package:flutter/material.dart';
import 'package:ticketapp/data/ticketService.dart';
import 'package:ticketapp/ui/common/TicketList.dart';

class AdminTicketListPage extends StatelessWidget {
  final TicketService _ticketService;
  const AdminTicketListPage(this._ticketService, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tickets"),
        actions: <Widget>[
          Container(
            child: Icon(Icons.replay),
          ),
          Container(
            child: Icon(Icons.add)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: TicketList(_ticketService)
      ),
      drawer: Container(),
    );
  }
}