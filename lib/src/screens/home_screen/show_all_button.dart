import 'package:flutter/material.dart';

class ShowAllButton extends StatefulWidget {
  final bool upcoming;
  final bool tapped;
  final VoidCallback onTap;
  ShowAllButton({this.upcoming, this.tapped, this.onTap});
  @override
  State<StatefulWidget> createState() => _ShowAllButtonState();
}

class _ShowAllButtonState extends State<ShowAllButton> {
  bool upcoming;
  bool tapped;
  @override
  void initState() {
    super.initState();
    upcoming = widget.upcoming;
    tapped = widget.tapped;
  }

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
                  style: TextStyle(color: Theme.of(context).accentColor),
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
                    onTap: tapped ? () {} : widget.onTap,
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
