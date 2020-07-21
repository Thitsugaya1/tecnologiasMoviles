import 'package:flutter/material.dart';

class Utilities {

  static AlertDialog loadingAlert(){
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Image(
              image: AssetImage('assets/loader.gif'),
              width: 150,
              height: 150,
              )
          ],
          )
      )
    );
  } 

  static AlertDialog successAlert(Function() callback){
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text("Success")
          ],
        )
      ),
      actions: <Widget>[
        RaisedButton(
          child: Text("OK"),
          onPressed: callback,
        )
      ],
    );
  }


}