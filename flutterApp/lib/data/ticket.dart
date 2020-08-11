import 'package:ticketapp/data/gpsLocation.dart';

abstract class TicketStatus{
  static const int Pendiente = 0;
  static const int Aceptado = 1;
  static const int Cancelado = 2;
  static const int Rechazado = 3;
}

class TicketImage {
  int id;
  String img;

  TicketImage({this.id, this.img});

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = Map();
    if(this.id != null) map['id'] = id;
    if(this.img != null) map['img'] = img;
    return map;
  }

  TicketImage.fronJson(Map<String,dynamic> json) : 
    id = json['id'],
    img = json['img'];
    
}

class TicketAudio {
  int id;
  String au;

  TicketAudio({this.id, this.au});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    if(this.id != null) map['id'] = id;
    if(au != null) map['au'] = au;
    return map;
  }

  TicketAudio.fronJson(Map<String,dynamic> json) : 
    id = json['id'],
    au = json['au'];
  
}

class Ticket{ 
  int id;
  DateTime dateTime;
  String user;
  int horaInicio;
  int estado;
  String comentario = '';
  GPSLocation direccion;
  List<TicketImage> images;
  List<TicketAudio> audios;

  Ticket();

  Ticket.half(this.id, this.dateTime, this.user, this.direccion);

  Ticket.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    dateTime = DateTime.parse(json['dateTime']),
    user = json['clienteEmail'],
    horaInicio = json['horaInicio'],
    estado = json['estado'],
    comentario = json['comentario'],
    direccion = (json['direccion'] != null) ? GPSLocation.fromJson(json['direccion']) : null,
    images = (json['images'] as List).map((e) => TicketImage.fronJson(e)).toList(),
    audios = (json['audios'] as List).map((e) => TicketAudio.fronJson(e)).toList()
    ;
    

  Map<String, dynamic> toJson()
  {
    Map<String,dynamic> map = Map();
    if(this.id != null) map['id'] = this.id;
    if(this.dateTime != null) map['dateTime'] = dateTime.toIso8601String();
    if(this.user != null) map['user'] = user;
    if(this.horaInicio != null) map['horaInicio'] = horaInicio;
    if(this.estado != null) map['estado'] = estado;
    if(this.comentario != null) map['comentario'] = comentario;
    if(this.direccion != null) map['direccion'] = direccion.toJson();
    if(this.images != null) map['images'] = images.map((e) => e.toJson()).toList();
    if(this.audios != null) map['audios'] = audios.map((e) => e.toJson()).toList();
    return map;
  }
  
  Map<String, dynamic> toJsonStub() => {
    'dateTime' : dateTime.toIso8601String(),
    'horaInicio' : horaInicio,
    'comentario' : comentario,
    'direccion' : direccion.toJson()
  };

}
