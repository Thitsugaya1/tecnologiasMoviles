import 'package:flutter/material.dart';


class AppStateObserverState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    try{
      if(state == AppLifecycleState.paused)
      Navigator.pushNamed(context, '/local_auth');
    }catch(e){
      print(e);
    }
    super.didChangeAppLifecycleState(state);
  }

}