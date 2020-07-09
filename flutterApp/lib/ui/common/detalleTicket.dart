import 'package:flutter/material.dart';
import 'package:ticketapp/data/ticket.dart';

class TicketPage extends StatelessWidget {
  final Ticket t;
  const TicketPage(this.t, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket Information")
      ),
      body: Center(
        child: DetalleTicket(t)
      )
    );
  }
}

class DetalleTicket extends StatefulWidget {
  final Ticket t;
  DetalleTicket(this.t, {Key key}) : super(key: key);

  @override
  _DetalleTicketState createState() => _DetalleTicketState(t);
}

class _DetalleTicketState extends State<DetalleTicket> {
  final Ticket t;
  final clienteTextController = TextEditingController();
  final horaController = TextEditingController();
  final fechaController = TextEditingController();
  final direccionController = TextEditingController();

  _DetalleTicketState(this.t){
    this.clienteTextController.value = this.clienteTextController.value.copyWith(text: t.user);
    horaController.value = horaController.value.copyWith(text: t.dateTime.hour.toString() + ":" + t.dateTime.minute.toString());
    fechaController.value = fechaController.value.copyWith(text: t.dateTime.toString());
    direccionController.value = direccionController.value.copyWith(text: t.direccion.direccion);
  }
   
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: <Widget>[
           Expanded(child: SingleChildScrollView(child: form())),
           bottomRow()
         ]
       ),
    );
  }

  Widget form(){
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Cliente'
            ),
            enabled: false,
            controller: clienteTextController,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Hora Solicitada',
            ),
            enabled: false,
            controller: horaController,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Dia Solicitado',
              enabled: false,
            ),
            enabled: false,
            controller: fechaController,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Direccion',
              enabled: false,
            ),
            enabled: false,
            controller: direccionController,
          )
        ],
      )
    );
  }

  Widget bottomRow(){
    return Container(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: RaisedButton(
              onPressed: () {},
              color: Colors.red[800],
              child: Text("Rechazar Hora"),
            )
          ),
          Expanded(
            child: RaisedButton(
              onPressed: (){},
              color: Colors.cyan[800],
              child: Text('Aceptar hora')
            )
          )
        ],
      )
      );
  }

}