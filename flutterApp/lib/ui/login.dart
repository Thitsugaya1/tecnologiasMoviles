
import 'package:flutter/material.dart';
import 'package:ticketapp/data/Models.dart';
import 'package:ticketapp/data/userService.dart';
import 'package:ticketapp/ui/Utilities.dart';

class Login extends StatelessWidget {
  final UserService _userService;

  Login(this._userService);

 	final emailTextController = TextEditingController();
	final passwordTextController = TextEditingController();

	@override
	Widget build(BuildContext context) {
    return Scaffold(
        body: 
          SingleChildScrollView(child : loginForm(context)),
    );
	}

  Widget loginForm(BuildContext context){
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.tightFor(width: 720, height: 240),
              child: Image.asset('assets/ticket.png')
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: "Email",
                  labelText: "Email",
                  ),
                  autofocus: true,
              controller: emailTextController,
                ),
            TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: "Password",
                    labelText: "Password",
                    ),
                controller: passwordTextController,
                ),
            ButtonBar(
                children: [
                  FlatButton(
                      child: Text("Cancelar"),
                      onPressed: null,
                      ),
                  RaisedButton(
                      child: Text("LogIn"),
                      onPressed: () {
                        this.logIn(context);
                        },
                  ),
                ],
                ),
          ],
      ),
  );
  }

  Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: loadingDialog, 
    );
  }

  AlertDialog loadingDialog(BuildContext context){
    return Utilities.loadingAlert();
  }

  Future<void> errorAlert(BuildContext context) async {
     return showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Request Failed!')
              ]
            )
          ),
        );
      }
    );
  }

  Future<void> successAlert(BuildContext context) async{
    return showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('We have a token!')
              ]
            )
          ),
        );
      }
    );
  }

  Future<Null> logIn(BuildContext context) async{           
    showLoadingDialog(context);      
    _userService.login(
      emailTextController.value.text, 
      passwordTextController.value.text).then(  
        (value) {
          _userService.getAuthUser().then( (usr)  {
            assert(usr.rol != UserRol.Guest);
            _userService.changeUser(usr);
            Navigator.pop(context);
            Navigator.popAndPushNamed(context, '/');
          });
//          _userService.changeUser(User("kain@w40k.net", "kain", UserRol.Client));
        }).catchError((error) {
          print(error);
          Navigator.pop(context); 
          errorAlert(context);
          });
    return Future.value();
  }

}



