import 'package:ticketapp/data/gpsLocation.dart';

abstract class TicketStatus{
  static const int Pendiente = 0;
  static const int Aceptado = 1;
  static const int Cancelado = 2;
  static const int Rechazado = 3;
}

class Ticket{ 
  int id;
  DateTime dateTime;
  String user;
  int horaInicio;
  double horaTermino;
  int estado;
  String comentario = '';
  GPSLocation direccion;

  Ticket();

  Ticket.half(this.id, this.dateTime, this.user, this.direccion);

  Ticket.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    dateTime = DateTime.parse(json['dateTime']),
    user = json['user'],
    horaInicio = json['horaInicio'],
    horaTermino = json['horaTermino'],
    estado = json['estado'],
    comentario = json['comentario'],
    direccion = (json['Direccion'] != null) ? GPSLocation.fromJson(json['Direccion']) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'dateTime' : dateTime.toIso8601String(),
    'user' : user,
    'horaInicio' : horaInicio,
    'horaTermino' : horaTermino,
    'estado' : estado,
    'comentario' :  comentario,
    'direccion' : direccion.toJson()
  };

  Map<String, dynamic> toJsonStub() => {
    'dateTime' : dateTime.toIso8601String(),
    'horaInicio' : horaInicio,
    'comentario' : comentario,
    'direccion' : direccion.toJsonStub()
  };

}