import 'package:flutter/material.dart';
import 'package:ticketapp/data/Models.dart';
import 'package:ticketapp/data/ticket.dart';
import 'package:ticketapp/data/ticketService.dart';
import 'package:ticketapp/data/userService.dart';
import 'package:ticketapp/ui/Utilities.dart';

class TicketPage extends StatelessWidget {
  final Ticket t;
  final UserService _userService;
  final TicketService _ticketService;
  const TicketPage(this.t, this._userService, this._ticketService, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket Information")
      ),
      body: Center(
        child: DetalleTicket(t, this._userService, _ticketService)
      )
    );
  }
}

class DetalleTicket extends StatefulWidget {
  final Ticket t;
  final UserService _userService;
  final TicketService _ticketService;
  DetalleTicket(this.t, this._userService, this._ticketService, {Key key}) : super(key: key);

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
    this.clienteTextController.value = this.clienteTextController.value.copyWith(text: (t.user != null)? t.user : "Place Holder" );
    if(t.dateTime != null){
    horaController.value = horaController.value.copyWith(text: t.dateTime.hour.toString() + ":" + t.dateTime.minute.toString());
    fechaController.value = fechaController.value.copyWith(text: t.dateTime.toString());
    }
    else{
      horaController.value = horaController.value.copyWith(text: "PlaceHolder");
      fechaController.value = fechaController.value.copyWith(text: "Placeholder");
    }
    direccionController.value = direccionController.value.copyWith(text: (t.direccion != null && t.direccion.direccion != null) ? t.direccion.direccion : "placeholder");
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
              onPressed: cancelTicket,
              color: Colors.red[800],
              child: Text("Rechazar Hora"),
            )
          ),
          (widget._userService.loggedUser.rol == UserRol.Admin) ? Expanded(
            child: RaisedButton(
              onPressed: acceptTicket,
              color: Colors.cyan[800],
              child: Text('Aceptar hora')
            )
          ) : Expanded (child: Container(),)
        ],
      )
      );
  }

  void cancelTicket(){
    raiseLoadingModal();
    widget._ticketService.resolverTicket(t.id, TicketStatus.Cancelado).then((value) {
      resuelto();
    });
  }

  void acceptTicket(){
    raiseLoadingModal();
    widget._ticketService.resolverTicket(t.id, TicketStatus.Aceptado).then((value) {
      resuelto();
    });
  }

  void resuelto(){
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void raiseLoadingModal(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Utilities.loadingAlert();
      }  
      );
  }

}