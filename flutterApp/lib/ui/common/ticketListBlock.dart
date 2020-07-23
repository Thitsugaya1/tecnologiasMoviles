import 'package:flutter/material.dart';
import 'package:ticketapp/data/ticket.dart';


class TicketListBlock extends StatelessWidget {
  final Ticket _ticket;
  const TicketListBlock(this._ticket, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (_ticket.estado) {
      case TicketStatus.Aceptado:
        color = Colors.green;
        break;
      case TicketStatus.Cancelado:
        color = Colors.grey;
        break;
      default:
    }

    return Container(
        height: 70,
        decoration: BoxDecoration(
          color: color,
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