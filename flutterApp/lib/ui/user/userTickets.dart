import 'package:flutter/material.dart';
import 'package:ticketapp/data/ticketService.dart';
import 'package:ticketapp/ui/common/TicketList.dart';

class UserTicketsPage extends StatelessWidget {
  final TicketService _ticketService;
  const UserTicketsPage(this._ticketService, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Tickets'),
      ),
      body: SingleChildScrollView(
        child: TicketList(_ticketService),
      ),
    );
  }
}
