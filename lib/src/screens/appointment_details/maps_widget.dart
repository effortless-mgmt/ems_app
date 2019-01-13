import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Maps extends StatefulWidget {
  final String address;

  Maps({this.address});

  @override
  State createState() => MapsState();
}

class MapsState extends State<Maps> {
  GoogleMapController mapController;
  List<Placemark> placeMark;
  Position position;
  MarkerOptions marker;
  LatLng latLng;

  final CameraPosition denmark =
      CameraPosition(target: LatLng(55.963398, 10.046297), zoom: 4);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 168.0,
          child: GoogleMap(
              onMapCreated: _onMapCreated,
              options: GoogleMapOptions(
                cameraPosition: denmark,
                mapType: MapType.normal,
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: false,
                zoomGesturesEnabled: false,
              )),
        ),
      ],
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() async {
      mapController = controller;
      placeMark = await Geolocator().placemarkFromAddress(widget.address);
      position = placeMark[0].position;
      latLng = LatLng(position.latitude, position.longitude);
      marker = MarkerOptions(position: latLng);

      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: 0.0,
          target: LatLng(position.latitude, position.longitude),
          zoom: 15.0)));

      mapController.addMarker(marker);
    });
  }
}
