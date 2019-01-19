import 'package:flutter/material.dart';

class ThemeSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(
                    image: AssetImage('assets/blue.png'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                print("Theme black is selected");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(
                    image: AssetImage('assets/black.png'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                print("Red theme selected");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(
                    image: AssetImage('assets/red.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Themes"),
        iconTheme: Theme.of(context).accentIconTheme,
      ),
    );
  }
}
