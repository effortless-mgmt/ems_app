import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ems_app/src/bloc/nav/navbar.dart';

class CustomNavBar extends StatelessWidget {
  final List<BottomNavigationBarItem> navIcons = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Container(height: 0.0),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.event_note),
      title: Container(height: 0.0),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_box),
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
          items: navIcons,
        );
      },
    );
  }
}
