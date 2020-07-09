import 'package:flutter/material.dart';

class DummyTicket {
  int id;
  String user;
  DateTime dateTime;
}

class UserTicketsPage extends StatelessWidget {
  const UserTicketsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Tickets'),
      ),
      body: SingleChildScrollView(
        child: UserTickets(),
      ),
    );
  }
}

class UserTickets extends StatefulWidget {
  UserTickets({Key key}) : super(key: key);

  @override
  _UserTicketsState createState() => _UserTicketsState();
}

class _UserTicketsState extends State<UserTickets> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: ListView(
         padding: const EdgeInsets.all(7),
         children: <Widget>[
           Container(
             height: 50,
             child: Text('Ticket 1'),
             color: Colors.blue[600],
           ),
           Container(
             height: 50,
             child: Text('Ticket 2'),
             color: Colors.blue[400],
           ),
           Container(
             height: 50,
             child: Text('Ticket 3'),
             color: Colors.blue[200],
           ),
         ],
       ),
    );
  }
}