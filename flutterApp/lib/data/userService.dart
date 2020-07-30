import 'package:ticketapp/data/Models.dart';
import 'package:ticketapp/data/httpService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserService {
  User loggedUser;
  HttpService _http;
  
  UserService(this._http): assert(_http != null);

	int get userRol => (loggedUser != null) ? loggedUser.rol : UserRol.Guest;

  Future<User> getAuthUser() async {
    final response = await http.get(HttpService.BaseURL + '/User', headers: _http.getHeaders());
    assert(response.statusCode == 200);
    if (response.statusCode == 200){
      //var apiResponse = ApiResponse.fromJson(convert.jsonDecode(response.body));
      //assert(apiResponse.success);
      //if( apiResponse.success){
        return Future.value(User.fromJson(convert.jsonDecode(response.body)));
      //}
    }
    return Future.error('error adquiring user');
    //TODO: Add Validation and messaggin

  }

  Future<bool> login(String user, String password) async {
    final response = await http.post(
      HttpService.BaseURL + '/auth', 
      body: convert.jsonEncode({'email': user, 'password': password}),
      headers: _http.getHeaders());
    if (response.statusCode == 200){
      var apiResponse = ApiResponse.fromJson(convert.jsonDecode(response.body));
      if(apiResponse.success){
        /*
        var tokenMessage = TokenMessage.fromJson(apiResponse.message);
        this._http.AddAuthToken(tokenMessage.token);
        */
        var token = apiResponse.message['token'];
        this._http.addAuthToken(token);

        return Future.value(true);

      }
      else{
        print("Api Response Error");
        print(apiResponse.errors);
      }
      return Future.error(false);
    }
  
    return Future.error(false);
  }

  Future<User> getUser() async {
    final response = await http.get(HttpService.BaseURL + '/user', headers: _http.getHeaders());
    if (response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      var user = User.fromJson(jsonResponse);
      assert(user != null);
      return user;
    }
    else {
      return null;
    }
  }

  void changeUser(User newuser){
    this.loggedUser = newuser;
  }

  void logout(){
    this.loggedUser = null;
    _http.removeAuthToken();
  }

}