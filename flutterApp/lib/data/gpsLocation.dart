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
    direccion = json['reverseGeoCode'],
    id = json['id'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    if(id != null) map['id'] = id;
    if(latitud != null) map['latitud'] = latitud;
    if(longitud != null) map['longitud'] = longitud;
    if(direccion != null) map['reverseGeoCode'] = direccion;
    return map;
  }
}