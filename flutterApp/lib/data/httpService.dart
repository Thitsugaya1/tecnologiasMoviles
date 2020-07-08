class HttpService {
  static const String BaseURL = 'http://192.168.1.6:5001/Api';

  Map<String, String> _headers;

  HttpService(){
    _headers = Map<String, String>();
    _headers['Accept'] = 'text/plain';
    _headers['Content-Type'] = 'application/json';
  }

  void addAuthToken(String token){
    _headers['Authorization'] = 'Bearer ' + token;
  }

  Map<String, String> getHeaders(){
    return _headers;
  }
}

class ApiResponse {
  dynamic message;
  bool success;
  dynamic errors;

  ApiResponse.fromJson(Map<String, dynamic> json): 
    message = json['message'],
    success = json['success'],
    errors = json['errors'];
}