import 'package:flutter/material.dart';
import 'package:ticketapp/ui/common/TicketList.dart';

class UserTicketsPage extends StatelessWidget {
  const UserTicketsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Tickets'),
      ),
      body: SingleChildScrollView(
        child: TicketList(),
      ),
    );
  }
}
