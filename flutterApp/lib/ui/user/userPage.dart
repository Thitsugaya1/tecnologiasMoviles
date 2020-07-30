import 'package:flutter/material.dart';
import 'package:ticketapp/data/ticketService.dart';
import 'package:ticketapp/data/userService.dart';
import 'package:ticketapp/ui/common/TicketList.dart';
import 'package:ticketapp/ui/common/drawer.dart';


class UserMainPage extends StatefulWidget {
  final TicketService _ticketService;
  final UserService _userService;
  UserMainPage(this._ticketService, this._userService, {Key key}) : super(key: key);

  @override
  _UserMainPageState createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      drawer: _drawer(),
      floatingActionButton: FloatingActionButton(onPressed: newTicket, child: Icon(Icons.add),),
    );
  }

  void newTicket(){
    Navigator.pushNamed(context, '/tickets/new');
  }

  Widget _appBar(){
    return AppBar(
      title: Text('TicketApp')
    );
  }


  Widget _body(){
    return TicketList(widget._ticketService, widget._userService);
  }

  Widget _drawer(){
    return MenuDrawer(widget._userService);
  }

}