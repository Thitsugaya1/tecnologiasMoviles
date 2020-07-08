import 'package:ticketapp/data/httpService.dart';

import 'package:ticketapp/data/ticket.dart';

class TicketService {
  HttpService _httpService;
 
  TicketService(this._httpService);

  //TODO: ADD REPOSITORY

  Future<Ticket> get(int id){
    return Future.error('NotImplemented');
  }

  Future<bool> post(Ticket ticket){
    return Future.error('NotImplemented');
  }

}