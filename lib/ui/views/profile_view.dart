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

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 175.0,
        height: 175.0,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/banana.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(90.0),
          border: Border.all(
            color: Colors.white,
            width: 5.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(Provider.of<User>(context).name,
            style: const TextStyle(fontSize: 24)),
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
                  _buildProfileImage(),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Align(
                    child: Text(
                      Provider.of<User>(context).name,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    alignment: Alignment.center,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    children: <Widget>[
                      Text(
                        Provider.of<User>(context).location,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        Provider.of<User>(context).phoneNumber,
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
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
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
