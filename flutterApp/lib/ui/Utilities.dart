import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'dart:io';


import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:ticketapp/ui/common/RecordAudio.dart';

class Utilities {

  static AlertDialog recordAudio(){
    return AlertDialog(
      content: SingleChildScrollView(
        child: RecordAudioWidget()
      ),
      contentPadding: EdgeInsets.all(2),
    );
  }

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

  static AlertDialog imageDialog(Image img){
    return AlertDialog(
      content: img,
      contentPadding: EdgeInsets.all(0),
    );
  }

  static Future<String> filepathToBase64(String path) async{
    return fileToBase64(File(path));
  }

  static Future<String> fileToBase64(File file) async{
    var bytes = await file.readAsBytes();
    return Future.value(convert.base64Encode(bytes));
  }

  static Future<String> base64ToAudioFilePath(String base64) async{
    var bytes = convert.base64Decode(base64);
    final path = Path.join(
          (await getTemporaryDirectory()).path, '${DateTime.now().millisecondsSinceEpoch}.m4a');
    var file = File(path);
    await file.writeAsBytes(bytes);
    return path;
  }

}
