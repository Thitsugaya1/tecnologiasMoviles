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

  Future<List<Ticket>> getAll() async{
    return Future.error('Not Implemented');
  }


  Future<bool> post(Ticket ticket) async{
    final ticketmap = ticket.toJsonStub();
    print(ticketmap);
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