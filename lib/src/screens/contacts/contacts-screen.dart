import 'package:flutter/material.dart';
// import 'package:ems_app/util/thirdParty/page-transformer.dart';
import 'package:ems_app/util/user-list.dart';
import 'package:ems_app/src/screens/contacts/contacts-card.dart';

class ContactsPageView extends StatelessWidget {
//   State createState() => new ContactsPageState();
// }

// class ContactsPageState extends State<ContactsPageView> {
//   UserLoader _userLoader;
//   List<User> _userList;
//   User _currentUser;
//   User _nextUser;
//   User _previousUser;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _userLoader.fetchUserList("MitFlotteToken").then((userList) {
//       setState(() {
//         _userList = userList.userList;
//         _currentUser = userList.userList.first;
//       });
//     });
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.85),
                itemCount: sampleUserList.userList.length,
                itemBuilder: (context, index) {
                  final user = sampleUserList.userList[index];
                  return ContactsPageItem(
                    user: user,
                  );
                },
          )
          // TODO: Incorporate some fancy animation stuff maybe?
          // child: PageTransformer(
          //   pageViewBuilder: (context, visibilityResolver) {
          //     return PageView.builder(
          //       controller: PageController(viewportFraction: 0.85),
          //       itemCount: sampleUserList.userList.length,
          //       itemBuilder: (context, index) {
          //         final user = sampleUserList.userList[index];
          //         final pageVisibility =
          //           visibilityResolver.resolvePageVisibility(index);
          //         return ContactsPageItem(
          //           user: user,
          //           pageVisibility: pageVisibility,
          //         );
          //       },
          //     );
          //   },
          // ),
        ),
      ),
    );
  }
}
