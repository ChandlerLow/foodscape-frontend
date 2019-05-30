import 'package:flutter/material.dart';
import 'pages/my_items.dart';


Drawer makeDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //TODO: get name of
          new UserAccountsDrawerHeader(
            accountEmail: new Text("jenny.xu18@bristol.ac.uk"),
            accountName: new Text(
              "Jenny Xu", style: TextStyle(fontSize: 24),),
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.pinkAccent,
              child: new Text("JX", style: TextStyle(fontSize: 24),),
            ),
          ),
          ListTile(
            title: Text('My Items',
              style: TextStyle(fontSize: 18),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyItemsWidget()));
            },
          ),
          ListTile(
            title: Text('My Details', style: TextStyle(fontSize: 18),),
            onTap: () {
              //TODO: add action
            },
          ),
        ]
    ),

  );
}

Card makeCard() {
  return Card(
      child: Container(
        child: Column(
          children: <Widget>[
            //image widget with overlays
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/banana.jpg'),)),
              width: 300,
              height: 150,
              padding: EdgeInsets.only(right: 10,),
              alignment: Alignment.center,
            ),
            //maybe add another container for padding or increase margins on upper container
            //widget for containing information
            Container(
              child: Text("ITEM TITLE",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              alignment: Alignment.center,
              width: 300,
              height: 20,
            ),
          ],
        ),
        padding: EdgeInsets.only(top: 20, ),
        width: 400,
        height: 200,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ));
}