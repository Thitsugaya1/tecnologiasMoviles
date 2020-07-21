import 'package:flutter/material.dart';
import 'package:ticketapp/ui/common/TicketList.dart';


class UserMainPage extends StatefulWidget {
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
    return TicketList();
  }

  Widget _drawer(){
    return Container(
      child: Text('Drawer')
    );
  }

}