import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';

class TomarFoto extends StatefulWidget {
  final CameraDescription cam;
  final Function(String) callback;
  TomarFoto(this.cam, {Key key, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TomarFotoState();
  }
}

class _TomarFotoState extends State<TomarFoto> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = CameraController(widget.cam, ResolutionPreset.medium);

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: body(context), floatingActionButton: floatingButton(context));
  }

  void takePicture() async {
    try {
      await _initializeControllerFuture;
      final path = Path.join(
          (await getTemporaryDirectory()).path, '${DateTime.now()}.png');
      await _controller.takePicture(path);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DisplayPicture(
                  path: path,
                  callback: (String s) {
                    Navigator.pop(context, s);
                  })));
    } catch (e) {
      print(e);
    }
  }

  Widget floatingButton(BuildContext context) {
    return FloatingActionButton(
        onPressed: takePicture, child: Icon(Icons.camera));
  }

  Widget body(BuildContext context) {
    return FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class DisplayPicture extends StatelessWidget {
  final String path;
  final Function(String) callback;
  DisplayPicture({Key key, this.path, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Picture")), body: body(context));
  }

  Widget body(BuildContext context) {
    return Column(children: [
      Image.file(File(path)),
      Row(children: [
        Expanded(
            child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancelar"))),
        Expanded(
            child: RaisedButton(
          onPressed: () => accept(context),
          child: Text("Acceptar"),
          color: Theme.of(context).primaryColor,
        )),
      ]),
    ]);
  }

  void accept(context) {
    Navigator.pop(context);
    this.callback(path);
  }
}
