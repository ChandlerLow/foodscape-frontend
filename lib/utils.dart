import 'package:flutter/material.dart';

import 'pages/my_items.dart';

/// Utility functions for commonly usable widgets

Drawer makeDrawer(BuildContext context) {
  return Drawer(
    child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      // TODO(x): get name of
      const UserAccountsDrawerHeader(
        accountEmail: Text('jenny.xu18@bristol.ac.uk'),
        accountName: Text('Jenny Xu', style: TextStyle(fontSize: 24)),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.pinkAccent,
          child: Text('JX', style: TextStyle(fontSize: 24)),
        ),
      ),
      ListTile(
        title: const Text('My Items', style: TextStyle(fontSize: 18)),
        onTap: () {
          Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => MyItemsWidget()));
        },
      ),
      ListTile(
        title: const Text('My Details', style: TextStyle(fontSize: 18)),
        onTap: () {
          // TODO(x): add action
        },
      ),
    ]),
  );
}

// Function for making item cards
Card makeCard(String name, String daysLeft, String location) {
  return Card(
      child: Container(
        child: Column(
          children: <Widget>[
            //image widget with overlays
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: const AssetImage('assets/banana.jpg'),
              )),
              width: 300,
              height: 150,
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
            ),
            //maybe add another container for padding or increase margins on upper container
            //widget for containing information
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Container>[
                  Container(
                    child: Text(name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    child: Text(
                      daysLeft,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.center,
                  ),
                  Container(
                    child: Text(
                      location,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
              alignment: Alignment.center,
              width: 300,
              height: 20,
            ),
          ],
        ),
        padding: const EdgeInsets.only(top: 20),
        width: 400,
        height: 200,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10));
}
