import 'package:ticketapp/data/gpsLocation.dart';

abstract class TicketStatus{
  static const int Pendiente = 0;
  static const int Aceptado = 1;
  static const int Cancelado = 2;
  static const int Rechazado = 3;
}

class Ticket{ 
  int id;
  DateTime datetime;
  String user;
  double horaInicio;
  double horaTermino;
  int estado;
  String comentario;
  GPSLocation direccion;

  Ticket();

  Ticket.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    datetime = json['datetime'],
    user = json['user'],
    horaInicio = json['horaInicio'],
    horaTermino = json['horaTermino'],
    estado = json['estado'],
    comentario = json['comentario'],
    direccion = GPSLocation.fromJson(json['Direccion']);

}