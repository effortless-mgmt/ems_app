import 'package:flutter/material.dart';

import 'package:ems_app/src/blocs/nav/bloc_provider.dart';

class CustomNavBar extends StatelessWidget {
  final List<BottomNavigationBarItem> navIcons = [
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

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    return StreamBuilder(
      stream: bloc.page,
      builder: (sink, snapshot) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: bloc.currentPageIndex(),
          onTap: (index) {
            bloc.changePage(index);
            // bloc.changeNavBarIcons(index);
          },
          items: navIcons,
        );
      },
    );
  }
}
