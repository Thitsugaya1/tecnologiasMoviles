import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ticketapp/data/gpsLocation.dart';
import 'package:ticketapp/ui/Utilities.dart';

class NewTicketForm extends StatefulWidget {
  @override
  _NewTicketFormState createState() => _NewTicketFormState();
}

class _NewTicketFormState extends State<NewTicketForm> {
  DateTime initialDate = DateTime.now();
  TimeOfDay initialTimeOfDay;
  DateTime endDate;
  TimeOfDay endTimeOfDay;

  final initialDateController = TextEditingController();
  final initialTimeOfDayController = TextEditingController();
  final endDateController =  TextEditingController();
  final endTimeOfDayController = TextEditingController();
  final directionTextController = TextEditingController();

  String dateText(DateTime date){
    if(date != null){
      return date.month.toString() + "/" + date.day.toString();
    }else{
      return "MM/DD";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedir Ticket')
      ),
      body: Center(
        child: SingleChildScrollView( child: _pedirTicketForm(context)),
      ),
    );
  }

  Widget _pedirTicketForm(BuildContext context){
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Descripcion'),
          TextFormField(
            decoration: InputDecoration(
                icon: Icon(Icons.person),
                hintText: "Email",
                labelText: "Email",
                ),
                autofocus: true,
            controller: null,
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: "Nombre",
              labelText: "Nombre"
            )
          ),
          TextFormField(
            decoration: InputDecoration( 
              icon: Icon(Icons.person),
              hintText: "Apellido",
              labelText: "Apellido"
            )
          ),
          Text('Direccion'),
          TextFormField(
            decoration: InputDecoration( 
              icon: Icon(Icons.place),
              hintText: "Direccion",
              labelText: "Direccion"
            ),
            onTap: getGeo,
            controller: directionTextController,
          ),
          Text('Fecha'),
          seleccionDateTimeDesde(initialDateController,
           initialDate,
           initialTimeOfDayController, 
           initialTimeOfDay,
           "Desde",
           "Desde"),
          seleccionDateTimeDesde(
            endDateController, 
            endDate, 
            endTimeOfDayController, 
            endTimeOfDay,
            "Hasta",
            "Hasta"),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                onPressed: goBack,
                child: Text('Cancelar')
              ),
              RaisedButton( 
                onPressed: enviar,
                child: Text('Enviar')
              )
            ]
          )
        ]
      ) ,
    );
  }

  Future<void> checkDateDate(DateTime date, TextEditingController controller) async {
    final result = await openDataPicker();
    if( result != null){
      setState(() {
        date = result;
        controller.value = controller.value.copyWith(
          text: dateText(date)
        );
      });
    }
  }

  void goBack(){
    Navigator.pop(context);
  }

  void enviar(){
    print("Enviar");
  }

  Future<DateTime> openDataPicker() async{
    return showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.utc(2055,2,20),
      initialDatePickerMode: DatePickerMode.day
      );
  }

  Future<TimeOfDay> openHourPicker() async{
    return showTimePicker(context: context, initialTime: TimeOfDay(hour: 12, minute: 0));
  }

  Future<void> checkHour(TimeOfDay timeOfDay, TextEditingController controller) async{
    final result = await openHourPicker();
    if(result != null){
      setState((){
        timeOfDay = result;
        controller.value = controller.value.copyWith(text: timeOfDay.hour.toString() + ":" + timeOfDay.minute.toString());
      });
    }
  }

  Widget seleccionDateTimeDesde(
    TextEditingController datecontroller, 
    DateTime dateTime,
    TextEditingController hourController, 
    TimeOfDay timeOfDay,
    String hintText,
    String labelText,
    ){
    return Row(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
            maxWidth: 150,
          ),
          child: TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.calendar_today),
              hintText: hintText,  
              labelText: labelText
            ),
            onTap: () { checkDateDate(dateTime, datecontroller);},
            controller: datecontroller,
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: 150,
          ),
          child: TextFormField(
            onTap: (){ checkHour(timeOfDay, hourController);},
            controller: hourController,
            decoration: InputDecoration(
              hintText: "Hora",
              labelText: "Hora",
              icon: Icon(Icons.timer),
            )
          ),
        )
      ],
    );
  }

  void raiseLoadingModal(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Utilities.loadingAlert();
      }  
      );
  }

  

  Future<void> getGeo() async {
    GPSLocation loc = GPSLocation();
    raiseLoadingModal();
    try {
      var geo = Geolocator();
      var q = await geo.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      print(q);
      loc.longitud = q.longitude;
      loc.latitud = q.latitude;
      loc.direccion = 'Placeholder: ' + loc.longitud.toString() + " " + loc.latitud.toString();
    } catch (e) {
      print(e);
      loc.latitud = 0;
      loc.longitud = 0;
      loc.direccion = "placeholder";
    }
    Navigator.pop(context);
    directionTextController.value = directionTextController.value.copyWith(text: loc.direccion);
  }
}