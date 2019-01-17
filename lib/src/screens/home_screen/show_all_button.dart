import 'package:ems_app/src/screens/home_screen/all_shifts_screen.dart';
import 'package:ems_app/src/screens/home_screen/page_routes.dart';
import 'package:flutter/material.dart';

class ShowAllButton extends StatelessWidget {
  final bool upcoming;

  ShowAllButton({this.upcoming});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                // color: Colors.red,
                padding: const EdgeInsets.only(
                    left: 16.0, top: 16.0, bottom: 16, right: 16.0),
                child: Text(
                  "Show all",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              Positioned(
                left: 0.0,
                top: 0.0,
                bottom: 0.0,
                right: 0.0,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 200));
                      Navigator.push(
                        context,
                        SlowMaterialPageRoute(
                          builder: (context) {
                            return AllShiftsScreen(upcoming: upcoming);
                          },
                          fullscreenDialog: false,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
