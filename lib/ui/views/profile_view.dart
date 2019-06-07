import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/models/user.dart';
import 'package:frontend/ui/shared/app_colors.dart' as app_colors;
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  Widget _buildBackground(Size screenSize) {
    return Container(
      height: 325,
      color: app_colors.backgroundColorPink,
    );
  }

  String _extractInitials(String fullname) {
    List<String> names = fullname.split(' ');
    String initials = '';
    for (String name in names) {
      initials += name[0];
    }
    return initials;
  }

  Widget _buildProfileImage(String name) {
    return Center(
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90.0),
          border: Border.all(
            color: Colors.white,
            width: 5.0,
          ),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.pink,
          child: Text(
            _extractInitials(name),
            style: const TextStyle(fontSize: 60, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: app_colors.backgroundColorPink,
        automaticallyImplyLeading: false,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () async {
              await user.setLoggedOut();
              await Navigator.of(context).pushNamedAndRemoveUntil(
                '/login',
                (_) => false,
              );
            },
          )
        ],
      ),
      body: Column(children: <Widget>[
        Stack(
          children: <Widget>[
            _buildBackground(screenSize),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                  ),
                  _buildProfileImage(user.name),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Align(
                    child: Text(
                      user.name,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    alignment: Alignment.center,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Row(
                    children: <Widget>[
                      Text(
                        user.location,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        user.phoneNumber,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ),
          ],
        ),
        ListTile(
          title: const Text(
            'My Items',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/user/items');
          },
        )
      ]),
    );
  }
}
