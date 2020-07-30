import 'package:flutter/material.dart';

class AgregarImagenDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AgregarImagenState();
  }
}

class _AgregarImagenState extends State<AgregarImagenDialog> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(child: buttons(context));
  }

  Widget preview(BuildContext context) {}

  Widget buttons(BuildContext context) {
    return Center(
      child: Row(children: <Widget>[
        FlatButton(
          onPressed: () {
            throw UnimplementedError();
          },
          child: Text("Subir"),
        ),
        FlatButton(
          onPressed: () async {
            Navigator.pop(
                context, await Navigator.pushNamed(context, 'TakeFoto'));
          },
          child: Text("Tomar"),
        ),
      ]),
    );
  }
}
