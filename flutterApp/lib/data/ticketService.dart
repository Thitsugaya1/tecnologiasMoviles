import 'package:ticketapp/data/httpService.dart';
import 'package:ticketapp/data/ticket.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TicketService {
  static const String Apartado = '/Ticket';
  HttpService _httpService;
 
  TicketService(this._httpService);

  //TODO: ADD REPOSITORY

  Future<Ticket> get(int id){
    return Future.error('NotImplemented');
  }

  Future<bool> resolverTicket(int id, int estado) async{
    var query = {'id': id, 'estado': estado};
    var response = await http.post(
      HttpService.BaseURL + Apartado + '/estado?id=$id&estado=$estado', 
      headers: _httpService.getHeaders());
    assert(response.statusCode == 200);
    //TODO: Resolve errors.
    return Future.value(true);
  }

  Future<List<Ticket>> getAll() async{
    var response = await http.get(HttpService.BaseURL + TicketService.Apartado, headers: _httpService.getHeaders());
    assert(response.statusCode == 200);
    List payload = convert.jsonDecode(response.body);
    List<Ticket> tickets = List<Ticket>();
    payload.forEach((element) {
      tickets.add(Ticket.fromJson(element));
    });
    return Future.value(tickets);
  }


  Future<bool> post(Ticket ticket) async{
    final ticketmap = ticket.toJson();
    print(ticketmap);
    var obj = convert.jsonEncode(ticketmap);
    var response = await http.post(HttpService.BaseURL + TicketService.Apartado, body: convert.jsonEncode(ticketmap), headers : _httpService.getHeaders());
    assert(response.statusCode == 200);
    if(response.statusCode == 200){
      print(response);
      return Future.value(true);
    }
    else{
      return Future.value(false);
    }
  }

}