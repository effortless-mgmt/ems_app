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
  Widget map;
  bool isLoading;
  var progressIndicator = Center(child: CircularProgressIndicator());

  final CameraPosition denmark =
      CameraPosition(target: LatLng(55.963398, 10.046297), zoom: 4);

  @override
  void initState() {
    map = progressIndicator;
    isLoading = true;

    // setState(() async {
    //   map = await googleMap().then();
    // });
    // googleMap().then((test) {
    //   setState(() => map = test);
    // });
    setState(() => setGoogleMap());
    super.initState();
  }

  setGoogleMap() {
    Stopwatch sw = new Stopwatch()..start();
    map = GoogleMap(
        onMapCreated: _onMapCreated,
        options: GoogleMapOptions(
          cameraPosition: denmark,
          mapType: MapType.normal,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          zoomGesturesEnabled: false,
        ));
    sw.stop();
    print("Execution time: ${sw.elapsedMilliseconds}ms");
  }

  Future f() {
    return new Future.delayed(
        Duration(milliseconds: 600), () => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: double.infinity,
            height: 168.0,
            child: FutureBuilder(
              future: f(),
              builder: (ctx, snapshot) {
                if (isLoading) {
                  return progressIndicator;
                } else {
                  return map;
                }
              },
            )),
      ],
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    setState(() async {
      isLoading = false;
      Stopwatch sw = new Stopwatch()..start();
      mapController = controller;

      placeMark = await Geolocator().placemarkFromAddress(widget.address);
      position = placeMark[0].position;
      latLng = LatLng(position.latitude, position.longitude);
      marker = MarkerOptions(position: latLng);
      // CameraUpdate.newCameraPosition(CameraPosition(
      //     bearing: 0.0,
      //     target: LatLng(position.latitude, position.longitude),
      //     zoom: 15.0));

      sw.stop();
      print("Execution time: ${sw.elapsedMilliseconds}ms");
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: 0.0,
          target: LatLng(position.latitude, position.longitude),
          zoom: 15.0)));

      mapController.addMarker(marker);
    });
    setState(() {});
  }
}
