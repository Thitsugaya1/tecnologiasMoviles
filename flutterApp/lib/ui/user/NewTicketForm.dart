import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ticketapp/data/gpsLocation.dart';
import 'package:ticketapp/data/ticket.dart';
import 'package:ticketapp/data/ticketService.dart';
import 'package:ticketapp/ui/Utilities.dart';
import 'package:ticketapp/ui/common/MapWidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ticketapp/ui/common/AgregarImagenDialog.dart';
import 'package:geocoder/geocoder.dart';

class NewTicketForm extends StatefulWidget {
  final TicketService _service;

  NewTicketForm(this._service);

  @override
  _NewTicketFormState createState() => _NewTicketFormState(this._service);
}

class _NewTicketFormState extends State<NewTicketForm> {
  DateTime initialDate = DateTime.now();
  TimeOfDay initialTimeOfDay = TimeOfDay.now();
  DateTime endDate;
  TimeOfDay endTimeOfDay;
  GPSLocation location;
  TicketService _service;
  List<String> images = new List();

  _NewTicketFormState(this._service);

  final initialDateController = TextEditingController();
  final initialTimeOfDayController = TextEditingController();
  final endDateController = TextEditingController();
  final endTimeOfDayController = TextEditingController();
  final directionTextController = TextEditingController();

  String dateText(DateTime date) {
    if (date != null) {
      return date.month.toString() + "/" + date.day.toString();
    } else {
      return "MM/DD";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pedir Ticket')),
      body: Center(
        child: SingleChildScrollView(child: _pedirTicketForm(context)),
      ),
    );
  }

  Widget Direccion(BuildContext context) {
    List widgets = List<Widget>();
    widgets.add(TextFormField(
      decoration: InputDecoration(
          icon: Icon(Icons.place),
          hintText: "Direccion",
          labelText: "Direccion"),
      onTap: getGeo,
      controller: directionTextController,
    ));
    if (this.location != null) {
      assert(this.location.latitud != null);

      //     widgets.add(MapWidget(
      //        position: LatLng(this.location.latitud, this.location.longitud)));
    }
    return Column(children: widgets);
  }

  Widget imageprev(BuildContext context){
    List<Widget> prevs = List();
    for (var img in images) {
      prevs.add(
        Container(
          width: 64,
          height: 80,
          margin: EdgeInsets.only(top: 5),
          child: Image.file(File(img), width: 64, height: 64,),
        )
      );
    }

    return Row(children: prevs,);
  } 

  Widget _pedirTicketForm(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Direccion(context),
        seleccionDateTimeDesde(initialDateController, initialDate,
            initialTimeOfDayController, initialTimeOfDay, "Desde", "Desde"),
        TextFormField(
          decoration: InputDecoration(labelText: "Comentario"),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 2,
        ),
        imageprev(context),
        Row(children: [
          Expanded(
              child: RaisedButton(
                  onPressed: openAgregarImageDialog,
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    child: Text("Agregar Imagen"),
                  )))
        ]),
        ButtonBar(children: <Widget>[
          FlatButton(onPressed: goBack, child: Text('Cancelar')),
          RaisedButton(onPressed: enviar, child: Text('Enviar'))
        ])
      ]),
    );
  }

  Future<void> checkDateDate(
      DateTime date, TextEditingController controller) async {
    final result = await openDataPicker();
    if (result != null) {
      setState(() {
        date = result;
        controller.value = controller.value.copyWith(text: dateText(date));
      });
    }
  }

  void goBack() {
    Navigator.pop(context);
  }

  Future<void> enviar() async {
    raiseLoadingModal();
    assert(initialTimeOfDay != null);
    List<TicketImage> images = List(); 
    for (var path in this.images) {
      images.add(TicketImage(img: (await Utilities.filepathToBase64(path))));
    }
    var ticket = Ticket();
    ticket.dateTime = initialDate;
    ticket.horaInicio = initialTimeOfDay.hour;
    ticket.direccion = location;
    ticket.images = images;
    ticket.audios = List();
    final res = await _service.post(ticket);
    assert(res == true);
    Navigator.pop(context);
    raiseSuccessModal();
  }

  Future<DateTime> openDataPicker() async {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.utc(2055, 2, 20),
        initialDatePickerMode: DatePickerMode.day);
  }

  Future<TimeOfDay> openHourPicker() async {
    return showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 12, minute: 0));
  }

  Future<void> checkHour(
      TimeOfDay timeOfDay, TextEditingController controller) async {
    final result = await openHourPicker();
    if (result != null) {
      setState(() {
        timeOfDay =
            timeOfDay.replacing(hour: result.hour, minute: result.minute);
        controller.value = controller.value.copyWith(
            text:
                timeOfDay.hour.toString() + ":" + timeOfDay.minute.toString());
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
  ) {
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
                labelText: labelText),
            onTap: () {
              checkDateDate(dateTime, datecontroller);
            },
            controller: datecontroller,
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: 150,
          ),
          child: TextFormField(
              onTap: () {
                checkHour(timeOfDay, hourController);
              },
              controller: hourController,
              decoration: InputDecoration(
                hintText: "Hora",
                labelText: "Hora",
                icon: Icon(Icons.timer),
              )),
        )
      ],
    );
  }

  void raiseLoadingModal() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Utilities.loadingAlert();
        });
  }

  void openAgregarImageDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: AgregarImagenDialog(),
              title:  Center(child: Text("Agregar Imagen")),
              );
        }).then((res) {
          if(res != null){
            setState((){
              this.images.add(res);            
            });
          }
      print(res);
    });
  }

  void raiseSuccessModal() {
    showDialog(
      context: context,
      builder: (context) => Utilities.successAlert(() {
        Navigator.pop(context);
        Navigator.pop(context);
      }),
      barrierDismissible: false,
    );
  }

  Future<void> getGeo() async {
    GPSLocation loc = GPSLocation();
    raiseLoadingModal();
    try {
      var geo = Geolocator();
      var q =
          await geo.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      print(q);
      loc.longitud = q.longitude;
      loc.latitud = q.latitude;
      loc.direccion = 'Placeholder: ' +
          loc.longitud.toString() +
          " " +
          loc.latitud.toString();
      final dir = await Geocoder.local.findAddressesFromCoordinates(Coordinates(loc.latitud, loc.longitud));
      loc.direccion = dir.first.addressLine;
    } catch (e) {
      print(e);
      loc.latitud = 0;
      loc.longitud = 0;
      loc.direccion = "placeholder";
    }

    setState(() {
      directionTextController.value =
          directionTextController.value.copyWith(text: loc.direccion);
      location = loc;
    });
    Navigator.pop(context);
  }
}
