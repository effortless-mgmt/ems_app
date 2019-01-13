import 'package:flutter/material.dart';

class ThemeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Pick a different color scheme",
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("Theme blue is selected");
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                image: AssetImage('assets/blue.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              print("Theme black is selected");
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                image: AssetImage('assets/black.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image(
              image: AssetImage('assets/red.png'),
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text("Themes "),
      ),
    );
  }
}
