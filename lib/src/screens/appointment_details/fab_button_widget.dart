import 'package:flutter/material.dart';

class JobOfferResponseFab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _JobOfferResponseFabState();
}

class _JobOfferResponseFabState extends State<JobOfferResponseFab> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 10.0,
        child: Icon(Icons.check),
        backgroundColor: Colors.greenAccent,
        onPressed: () => print("Accepted"));
  }
}
