import 'package:flutter/material.dart';
class NotImplementedPage extends StatelessWidget {
  const NotImplementedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not-Implemented"),
      ),
      body: Center(child: Text('Not-implemented'),
      )
    );
  }
}