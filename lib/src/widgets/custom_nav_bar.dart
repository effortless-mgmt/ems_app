import 'package:flutter/material.dart';
import '../blocs/provider.dart';

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
    final bloc = Provider.of(context);

    return StreamBuilder(
      stream: bloc.page,
      builder: (sink, snapshot) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: bloc.giveInt(),
          onTap: (index) {
            bloc.changePage(index);
            bloc.changeAppBar(index);
          },
          items: navIcons,
        );
      },
    );
  }
}
