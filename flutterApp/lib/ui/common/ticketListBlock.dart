import 'package:flutter/material.dart';
import 'package:ticketapp/data/ticket.dart';


class TicketListBlock extends StatelessWidget {
  final Ticket _ticket;
  const TicketListBlock(this._ticket, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        decoration: BoxDecoration(
          border: Border.all()
        ),
        child: Center(
          child: Text(
            "Ticket " + _ticket.id.toString(),
            style: TextStyle(
              fontSize: 30
            ),
          ),
        ),
      );
  }
}