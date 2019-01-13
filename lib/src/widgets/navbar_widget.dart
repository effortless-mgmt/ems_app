import 'package:ems_app/src/screens/appointment_details/appointment_details_screen.dart';
import 'package:ems_app/src/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../screens/add_screen.dart';
import '../screens/calender_screen.dart';
import '../screens/contacts/contacts_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';

class Navbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavbarState();
  }
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;
  bool _loggedIn = false;

  final List<Widget> _screens = [
    HomeScreen(),
    CalenderScreen(),
    AddScreen(),
    AppointmentDetailsScreen(isJobOffer: false),
    // ContactsCardScreen(),
    ProfileScreen(),
  ];
  List<Widget> appBarIcons = [];

  void login() {
    print("Logging in...");
    setState(() => _loggedIn = true);
  }

  @override
  Widget build(BuildContext context) {
    var mainApp = new Material(
        child: Scaffold(
      // appBar: AppBar(
      //   title: Text("EMS"),
      //   actions: appBarIcons,
      // ),
      body: _screens[_currentIndex], // new
      bottomNavigationBar: customNavbar(),
    ));
    var loginScreen = new LoginScreen(login);

    return _loggedIn ? mainApp : loginScreen;
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 4) {
      appBarIcons = [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => SettingsScreen(),
              ),
            );
          },
        )
      ];
    } else {
      appBarIcons = [];
    }
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