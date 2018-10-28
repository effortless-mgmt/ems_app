import 'package:flutter/material.dart';
import '../screens/add_screen.dart';
import '../screens/calender_screen.dart';
import '../screens/contact_card_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';

class Navbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavbarState();
  }
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    CalenderScreen(),
    AddScreen(),
    ContactCardScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.green,
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Flutter App'),
          ),
          body: _screens[_currentIndex], // new
          bottomNavigationBar: customNavbar(),
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget customNavbar() {
    List<BottomNavigationBarItem> navIconsAndTitle = [
      new BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Container(height: 0.0),
      ),
      new BottomNavigationBarItem(
        icon: Icon(Icons.event_note),
        title: Container(height: 0.0),
      ),
      new BottomNavigationBarItem(
        icon: Icon(Icons.add_box),
        title: Container(height: 0.0),
      ),
      new BottomNavigationBarItem(
        icon: Icon(Icons.group),
        title: Container(height: 0.0),
      ),
      new BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Container(height: 0.0),
      )
    ];
    return Theme(
      data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.blue,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.red,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.white))),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: navIconsAndTitle,
      ),
    );
  }
}
