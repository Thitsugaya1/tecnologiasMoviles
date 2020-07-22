import 'package:flutter/material.dart';
import 'package:ticketapp/data/gpsLocation.dart';
import 'package:ticketapp/data/ticket.dart';
import 'package:ticketapp/data/ticketService.dart';
import 'package:ticketapp/ui/common/detalleTicket.dart';
import 'package:ticketapp/ui/common/ticketListBlock.dart';


class TicketList extends StatefulWidget {
  TicketService _service;
  TicketList(this._service, {Key key}) : super(key: key);

  @override
  _TicketListState createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  List<Ticket> tickets = <Ticket>[ // DUMMY DATA
    Ticket.half(1, DateTime.now(), "Kain", GPSLocation.half("San Rafael")),
    Ticket.half(2, DateTime.utc(2012, 10, 21 ), "DarkNacho", GPSLocation.half("Santiago")),
  ];

  @override
  void initState() {
    this.widget._service.getAll().then((value) {
        setState(() {
          tickets = value;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: ListView(
         padding: const EdgeInsets.all(12),
         children: makeTicketContainers()
       ),
    );
  }

  List<Widget> makeTicketContainers(){
    List<Widget> list = <Widget>[];
    for (var ticket in this.tickets) {
      list.add(ticketItem(ticket));
    }
    return list;
  }

  Widget ticketItem(Ticket t){
    return GestureDetector(
      child: TicketListBlock(t),
      onTap: () {
        print(t.id.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context) => TicketPage(t)));
      },
    );
  }
}