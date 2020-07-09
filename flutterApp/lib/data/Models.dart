import 'package:flutter/material.dart';

abstract class UserRol{
	static const int Admin = 1;
	static const int Employee = 2;
	static const int Client = 3;
	static const int Guest = 99;
}

class TokenMessage {
  String token;
  DateTime issuedAt;
  DateTime expireDate;
  TokenMessage(this.token, this.issuedAt, this.expireDate);

  TokenMessage.fromJson(Map<String, dynamic> json):
    token = json['token'],
    issuedAt = json['issuedAt'],
    expireDate = json['expireDate'];

  Map<String, dynamic> toJson() => {
    'token': token,
    'issuedAt': issuedAt,
    'expireDate': expireDate
  };
}

class User {
	String username;
	String email;
	int rol = UserRol.Guest;

	User(String username, String email, int rol){
		this.username = username;
		this.email = email;
		this.rol = rol;
	}

  User.fromJson(Map<String, dynamic> json):
    username = json['username'], 
    email = json['email'],
    rol = json['rol'];

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'rol': rol
  };
}

class LogInfo extends ChangeNotifier{
	User loggedUser;

	int get userRol => (loggedUser != null) ? loggedUser.rol : UserRol.Guest;

	void login(User newUser){
		//Add login data to state
		this.loggedUser = newUser;
		notifyListeners();
	}

	void logout(){
		//remove login data from state
		this.loggedUser = null;
		notifyListeners();
	}
}
