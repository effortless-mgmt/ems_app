import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://thediplomat.com/wp-content/uploads/2017/10/thediplomat-ap_923638204453-386x261.jpg'),
              radius: 80.0,
            ),
            Divider(
              height: 50.0,
            ),
            const ListTile(
              leading: Icon(Icons.portrait),
              title: Text('Kim Jong Un'),
            ),
          ],
        ),
      ),
    );
  }
}
