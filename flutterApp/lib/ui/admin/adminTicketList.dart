import 'package:flutter/material.dart';
import 'package:ticketapp/data/gpsLocation.dart';
import 'package:ticketapp/data/ticket.dart';
import 'package:ticketapp/ui/common/detalleTicket.dart';

class AdminTicketListPage extends StatelessWidget {
  const AdminTicketListPage({Key key}) : super(key: key);

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
        child: AdminTicketList()
      ),
      drawer: Container(),
    );
  }
}

class AdminTicketList extends StatefulWidget {
  AdminTicketList({Key key}) : super(key: key);

  @override
  _AdminTicketListState createState() => _AdminTicketListState();
}

class _AdminTicketListState extends State<AdminTicketList> {
  final List<Ticket> tickets = <Ticket>[ // DUMMY DATA
    Ticket.half(1, DateTime.now(), "Kain", GPSLocation.half("San Rafael")),
    Ticket.half(2, DateTime.utc(2012, 10, 21 ), "DarkNacho", GPSLocation.half("Santiago")),
  ];

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
        child: Container(
        height: 70,
        decoration: BoxDecoration(
          border: Border.all()
        ),
        child: Center(
          child: Text(
            "Ticket " + t.id.toString(),
            style: TextStyle(
              fontSize: 30
            ),
          ),
        ),
      ),
      onTap: () {
        print(t.id.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context) => TicketPage(t)));
      },
    );
  }


}