import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapWidget extends StatefulWidget {
  LatLng position;
  MapWidget({Key key, this.position = const LatLng(-34.9780, -71.2529)})
      : super(key: key);
  @override
  State<MapWidget> createState() => _MapWidgetState(this.position);
}

class _MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _placeholderCamera = CameraPosition(
    target: LatLng(-34.9780, -71.2529),
    zoom: 14,
  );

  _MapWidgetState(LatLng position) {
    assert(position != null);
    _placeholderCamera = CameraPosition(target: position, zoom: 14);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _placeholderCamera,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        });
  }
}
