import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/models/user.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  Widget _buildBackground(Size screenSize) {
    return Container(
      height: 325,
      color: Colors.grey,
    );
  }

  String extractInitials(String fullname) {
    List<String> names = fullname.split(' ');
    String initials = '';
    for(String name in names) {
      initials += name[0];
    }
    return initials;
  }

  Widget _buildProfileImage(String name) {
    return Center(
      child: Container(
        /*width: 175.0,
        height: 175.0,*/
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          /*image: const DecorationImage(
            image: AssetImage('assets/banana.jpg'),
            fit: BoxFit.cover,
          ),*/
          borderRadius: BorderRadius.circular(90.0),
          border: Border.all(
            color: Colors.white,
            width: 5.0,
          ),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(extractInitials(name), style: TextStyle(fontSize: 60, color: Colors.white),),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    final Size screenSize = MediaQuery.of(context).size;
    final User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Profile',
            style: TextStyle(fontSize: 24)),
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
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    children: <Widget>[
                      Text(
                        user.location,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        user.phoneNumber,
                        style: const TextStyle(color: Colors.white),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab
          ? FloatingActionButton(
              heroTag: 'main-fab',
              backgroundColor: Colors.grey,
              elevation: 2.0,
              child: const Icon(Icons.edit),
              /*onPressed: () {
                Navigator.pushNamed(context, '/');
              },*/
            )
          : null,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              color: Colors.white,
              iconSize: 40,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              color: Colors.white,
              iconSize: 40,
              onPressed: () {},
            ),
          ],
        ),
        color: Colors.grey,
        shape: const CircularNotchedRectangle(),
      ),
    );
  }
}
