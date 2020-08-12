import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart' as players;


class AudioPlayer extends StatefulWidget {
  final String audiopath;
  AudioPlayer( this.audiopath, {Key key}) : super(key: key);

  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  players.AudioPlayer _player;
  players.AudioPlayerState _playerState = players.AudioPlayerState.STOPPED;
  Duration _duration;
  Duration _position;

  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerStateSubscription;
  StreamSubscription _playerErrorSubcription;
  StreamSubscription _playercompleteSubscription;

  get _durationText => _duration?.toString()?.split('.')?.first ?? '';
  get _positionText => _position?.toString()?.split('.')?.first ?? '';
  get _isPlaying => (_playerState == players.AudioPlayerState.PLAYING);
  get _isPaused => (_playerState == players.AudioPlayerState.PAUSED);

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    this._player = players.AudioPlayer(mode: players.PlayerMode.MEDIA_PLAYER);
    _durationSubscription = _player.onDurationChanged.listen((event) {
      setState(()=> _duration = event);
    });
    _positionSubscription = _player.onAudioPositionChanged.listen((event) {
      setState(()=> _position = event);
    });
    _playerErrorSubcription = _player.onPlayerError.listen((event) {
      print('Audio Error $event');
      setState(() {
        _playerState = players.AudioPlayerState.STOPPED;
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    });
    _playercompleteSubscription = _player.onPlayerCompletion.listen((event) {
      setState((){
        _position = _duration;
      });
    });
    _playerStateSubscription = _player.onPlayerStateChanged.listen((event) {
      if(!mounted) return;
      setState((){
        _playerState = event;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
    _playercompleteSubscription.cancel();
    _playerErrorSubcription.cancel();
    _playerStateSubscription.cancel();
    _durationSubscription.cancel();
    _positionSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.play_circle_outline),
              onPressed: _isPlaying ? null : _play,
            ),
            IconButton(
              icon: Icon(Icons.pause_circle_outline),
              onPressed: _isPlaying ? _pause : null,
            ),
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: (_isPlaying || _isPaused) ? _stop : null,
            ),
          ]
        ,),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Stack(
                children: [
                  Slider(
                    onChanged: (v) {
                      Duration position = Duration(milliseconds: (v * _duration.inMilliseconds).round());
                      _player.seek(position);
                    },
                    value: (_position != null && 
                            _duration != null && 
                            _position.inMilliseconds > 0 && 
                            _position < _duration ) ? _position.inMilliseconds / _duration.inMilliseconds : 0,
                  ),
                ],
              ),
            ),
            Text(
              (_position != null) ? '$_positionText / $_durationText' : _durationText,
            ),
          ],
        )
      ],
    );
  }

 
  _play() async{
    final playPosition  = ( _position != null && _duration != null &&
    _position.inMilliseconds > 0 && _position.inMilliseconds < _duration.inMilliseconds) ? _position : null;
    await _player.play(widget.audiopath, isLocal: true, position: playPosition);
  }

  _pause() async{
    await _player.pause();
  }

  _stop() async{
    final result = await _player.stop();
    if (result == 1){
      setState(() {
        _position = Duration();
      });
    }
  }
}


class MiniPlayer extends AudioPlayer {
  MiniPlayer(String audiopath, {Key key}) : super(audiopath, key: key);

  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends _AudioPlayerState {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        playButton(context),
        slider(context)
      ],
    );
  }

  Widget slider(BuildContext context){
    return Slider(
      onChanged: (v) {
        Duration position = Duration(milliseconds: (v * _duration?.inMilliseconds ?? 0).round());
        _player.seek(position);
      },
      value: (_position != null && 
              _duration != null && 
              _position.inMilliseconds > 0 && 
              _position < _duration ) ? _position.inMilliseconds / _duration.inMilliseconds : 0,
    );
  }

  Widget playButton(BuildContext context){
    return (_playerState == players.AudioPlayerState.PLAYING) ?
      IconButton(
        icon: Icon(Icons.stop),
        onPressed: _stop) :
      IconButton(
        icon: Icon(Icons.play_arrow),
        onPressed: _play,);
  }
}