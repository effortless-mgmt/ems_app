import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ems_app/src/bloc/nav/navbar.dart';

class CustomNavBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  List<BottomNavigationBarItem> _navIcons;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _navIcons = _navIcons ?? _createNavIcons(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<NavBarBloc>(context),
      builder: (BuildContext context, NavBarState navBarState) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex:
              (navBarState is NavBarJump ? navBarState.currentIndex : 0),
          onTap: (index) {
            BlocProvider.of<NavBarBloc>(context)
                .dispatch(Jump(newIndex: index));
          },
          items: _navIcons,
        );
      },
    );
  }

  //######################################
  //CHECK FOR APPOINTMENT CHANGES IN STACK
  //######################################
  _createNavIcons(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: Stack(
          children: <Widget>[
            Icon(Icons.home),
            Positioned(
                top: 0.0,
                right: 0.0,
                child: Icon(Icons.brightness_1,
                    size: 8.0, color: Theme.of(context).errorColor)),
          ],
        ),
        title: Container(height: 0.0),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.event_note),
        title: Container(height: 0.0),
      ),
      BottomNavigationBarItem(
        icon: Stack(
          children: <Widget>[
            Icon(Icons.add_box),
            Positioned(
                top: 0.0,
                right: 0.0,
                child: Icon(Icons.brightness_1,
                    size: 8.0, color: Theme.of(context).errorColor)),
          ],
        ),
        title: Container(height: 0.0),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.group),
        title: Container(height: 0.0),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Container(height: 0.0),
      )
    ];
  }
}
