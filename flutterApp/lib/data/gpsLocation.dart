class GPSLocation{
  double latitud;
  double longitud;
  String direccion;
  int id;

  GPSLocation();

  GPSLocation.half(this.direccion);

  GPSLocation.fromJson(Map<String, dynamic> json):
    latitud = json['latitud'],
    longitud = json['longitud'],
    direccion = json['direccion'],
    id = json['id'];

  Map<String, dynamic> toJson() => {
    'latitud' : latitud,
    'longitud' : longitud,
    'direccion' : direccion,
    'id' : id
  };

  Map<String, dynamic> toJsonStub() => {
    'latitud' : latitud,
    'longitud' : longitud,
    'direccion' : direccion
  };
}