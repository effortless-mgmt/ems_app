import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ems_app/util/user.dart';
// import 'package:ems_app/util/thirdParty/page-transformer.dart';

class ContactsPageItem extends StatelessWidget {
  ContactsPageItem({
    @required this.user,
    // @required this.pageVisibility,
  });

  final User user;
  // final PageVisibility pageVisibility;

  @override
  Widget build(BuildContext context) {
    // padding around the card
    return Card(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildAvatar(context),
            _buildTextContainer(context),
            _buildIconButtons(context)
          ],
        ),
        margin: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 8.0,
        ),
        elevation: 3.0,
    );
  }

  _buildAvatar(BuildContext context) {
    var avatar = CircleAvatar(
      backgroundImage: NetworkImage(user.imgURL),
      radius: 80.0,
    );
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: avatar,
    );
  }

  _buildTextContainer(BuildContext context) {
    var fullName = Text(
      user.firstName + " " + user.lastName,
    );
    var title = Text(
      user.title,
    );
    var company = Text(
      user.company,
    );
    var description = Text(
      user.description,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: fullName,
          padding: EdgeInsets.only(bottom: 8.0),
        ),
        Container(
          child: title,
          padding: EdgeInsets.only(bottom: 8.0),
        ),
        Container(
          child: company,
          padding: EdgeInsets.only(bottom: 8.0),
        ),
        Container(
          child: description,
          padding: EdgeInsets.only(bottom: 8.0),
        ),
      ],
    );
  }

  _buildIconButtons(BuildContext context) {
    var phoneIconButton = IconButton(
      icon: Icon(Icons.call),
      onPressed: () {
        // go to call screen
      },
    );
    // TODO: figure out how to put a "new message"-thingie on the icon
    var chatIconButton = IconButton(
      icon: Icon(Icons.chat),
      onPressed: () {
        // go to chat screen
      },
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        phoneIconButton,
        chatIconButton,
      ],
    );
  }
}
