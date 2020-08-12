import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';

import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:ticketapp/ui/common/AudioPlayer.dart';


class RecordAudioWidget extends StatefulWidget {
  RecordAudioWidget({Key key}) : super(key: key);

  @override
  _RecordAudioWidgetState createState() => _RecordAudioWidgetState();
}

class _RecordAudioWidgetState extends State<RecordAudioWidget> {
  FlutterAudioRecorder _recorder;
  RecordingStatus _recordingStatus = RecordingStatus.Unset;
  Recording _current;
  Timer _t;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _recorder?.stop();
    _t.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
              Expanded(child: startButton(context)),
              Expanded(child: pauseButton(context)),
              Expanded(child: stopButton(context))
              ],),
              player(context),
              bottomBar(context),
          ],
        ) ,
      )
    );
  }

  Widget startButton(BuildContext context){
    return (_recordingStatus == RecordingStatus.Initialized || _recordingStatus == RecordingStatus.Stopped) ? 
      RaisedButton(child: Icon(Icons.mic), color: Colors.redAccent, onPressed: _record,):
      RaisedButton(child: Icon(Icons.mic), disabledColor: Colors.grey, onPressed: null);
  }

  Widget pauseButton(BuildContext context){
    switch (_recordingStatus) {
      case RecordingStatus.Recording:
        return RaisedButton(child: Icon(Icons.pause), onPressed: _pause);
      case RecordingStatus.Paused:
        return RaisedButton(child: Icon(Icons.play_arrow), onPressed: _resume);
      default:
        return RaisedButton(child: Icon(Icons.pause), 
        onPressed: null, 
        disabledColor: Color.alphaBlend(Theme.of(context).primaryColor.withAlpha(60), Colors.grey),
        );
    }
  }

  Widget stopButton(BuildContext context){
    if(_recordingStatus == RecordingStatus.Recording || _recordingStatus == RecordingStatus.Paused){
      return RaisedButton(child: Icon(Icons.stop), onPressed: _stop, color: Colors.red);
    }
    else{
      return RaisedButton(child: Icon(Icons.stop), onPressed: null, disabledColor: Color.alphaBlend(Colors.red.withAlpha(60), Colors.grey));
    }
  }

  Future<int> _init() async{
    try{
      if (await FlutterAudioRecorder.hasPermissions){
        final path = Path.join(
          (await getTemporaryDirectory()).path, '${DateTime.now().millisecondsSinceEpoch}.m4a');
        _recorder = FlutterAudioRecorder(path);

        await _recorder.initialized;

        var current = await _recorder.current(channel: 0);
        print(current);
        setState(() {
          _current = current;
          _recordingStatus = current.status;
          print(_recordingStatus);
        });
      }
    }catch(e){
      print(e);
    }
    return 1;
  }


  void _stop() async {
    if(_recordingStatus != RecordingStatus.Recording){
      return ;
    }
    var result = await _recorder.stop();
    print('stop recording: ${result.path} :: ${result.duration}');
    setState(() {
      _current =result;
      _recordingStatus = _current.status;
    });
  }

  void _resume() async {
    await _recorder.resume();
    setState(() {
      _recordingStatus = _current.status;
    });
  }

  void _pause() async {
    await _recorder.pause();
    setState(() {
      _recordingStatus = _current.status;
    });
  }

  void _record() async {
    if(_recordingStatus == RecordingStatus.Stopped){
      _recordingStatus = RecordingStatus.Unset;
      //await File(_current.path).delete();
      _t.cancel();
      await _init();
    }
    try{
      await _recorder.start();
      var recording = await _recorder.current(channel:0);
      setState(() {
        _current = recording;
        _recordingStatus = _current.status;
      });

      const tick = const Duration(milliseconds: 50);
      _t = new Timer.periodic(tick, _tickEvent);
    }catch(e){
      print(e);
    }
  }

  void _tickEvent(Timer t) async {
    if(_recordingStatus == RecordingStatus.Stopped){
      t.cancel();
    }
    var current = await _recorder.current(channel: 0);
    setState(() {
      _current = current;
      _recordingStatus = _current.status;
    });
  }

  Widget player(BuildContext context) {
    if(_recordingStatus == RecordingStatus.Stopped){
      return AudioPlayer(_current.path);
    } else return Container(
      child: Text('${_current?.duration ?? ' '}')
    );
  }

  Widget bottomBar(BuildContext context){
    return ButtonBar(
      children: [
        FlatButton(child: Text("Cancel"), onPressed: (){
          _stop();
          Navigator.pop(context);
          this.dispose();
        },),
        RaisedButton(
          child: Text("Aceptar"),
          onPressed: (_recordingStatus == RecordingStatus.Stopped) ? (){
            Navigator.pop(context, _current.path);
          } : null,
          disabledColor: Color.alphaBlend(Theme.of(context).primaryColor.withAlpha(70), Colors.grey),
        )
      ],);
  }

}