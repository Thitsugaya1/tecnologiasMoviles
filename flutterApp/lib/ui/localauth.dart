import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ticketapp/data/userService.dart';

class LocalAuth extends StatefulWidget {
  final UserService _userService;
  LocalAuth(this._userService, {Key key}) : super(key: key);

  @override
  _LocalAuthState createState() => _LocalAuthState();
}

class _LocalAuthState extends State<LocalAuth> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> _isBiometricAvailable() async{
    bool res = false;
    try {
      res = await _localAuthentication.canCheckBiometrics;
    }catch (e) {
      print (e);
    }

    if (mounted)
    {
      res ? print('We have biometrics') : print('no Bios Available');
    }
    return res;
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> list;
    try {
      list = await _localAuthentication.getAvailableBiometrics();
    }catch(e){
      print(e);
    }
    if(mounted){
      print(list);
    }
    return;
  }

  Future<void> _authUser() async {
    bool res = false;
    try{
      res = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: 'Resume you session',
        useErrorDialogs: true,
        stickyAuth: true
        );
    }catch(e){
      print(e);
    }

    res ? print ("Authed") : print("FAKE!");
    if(res){
      Navigator.pop(context);
    } 
  }

  @override
  Widget build(BuildContext context) {
    return 
     Scaffold(body:
      Container(
      margin: EdgeInsets.all(16),
      child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.tightFor(width: 720, height: 240),
              child: Image.asset('assets/ticket.png')
            ),
            RaisedButton(
              child: Text('Auth'),
              onPressed: () async{
               // if(await _isBiometricAvailable()){
                  await _getListOfBiometricTypes();
                  await _authUser();
               // }
              },
            ),
            RaisedButton(
              child: Text('Logout'),
              onPressed: () async {
                widget._userService.logout();                
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            ),
          ],
      ),
  ));
  }
}