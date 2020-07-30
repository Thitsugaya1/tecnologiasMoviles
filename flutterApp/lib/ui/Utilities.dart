import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'dart:io';

class Utilities {

  static AlertDialog loadingAlert(){
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            CircularProgressIndicator()
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

  static Future<String> filepathToBase64(String path) async{
    return fileToBase64(File(path));
  }

  static Future<String> fileToBase64(File file) async{
    var bytes = await file.readAsBytes();
    return Future.value(convert.base64Encode(bytes));
  }

}
