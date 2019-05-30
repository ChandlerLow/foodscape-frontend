import 'package:flutter/material.dart';

/// Class for showing the items of the user
class MyItemsWidget extends StatefulWidget {
  @override
  MyItemsState createState() => MyItemsState();
}

class MyItemsState extends State<MyItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Items'),
      ),
      body: ItemListWidget(),
    );
  }
}

class ItemListWidget extends StatefulWidget {
  @override
  ItemListState createState() => ItemListState();
}

class ItemListState extends State<ItemListWidget> {
  //constructs a list view of cards
  // need to modify instead of containing the widget will hold data then constructs card with data
  final List<ItemCardWidget> myItems = <ItemCardWidget>[];

  @override
  void initState() {
    super.initState();
    myItems.add(ItemCardWidget());
  }

  @override
  Widget build(BuildContext context) {
    // TODO(x): implement build
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int i) => myItems[i],
        itemCount: myItems.length,
      ),
      padding: const EdgeInsets.only(bottom: 100),
    );
  }
}

class ItemCardWidget extends StatefulWidget {
  @override
  ItemCardState createState() => ItemCardState();
}

class ItemCardState extends State<ItemCardWidget> {
  //constructor an item card with Data Class
  @override
  Widget build(BuildContext context) {
    // TODO(x): implement build

    return Card(
      child: Container(
        child: Column(
          children: <Widget>[
            //image widget with overlays
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: const AssetImage('assets/banana.jpg'))),
              width: 300,
              height: 150,
              padding: const EdgeInsets.only(
                right: 10,
              ),
              alignment: Alignment.center,
            ),
            //maybe add another container for padding or increase margins on upper container
            //widget for containing information
            Container(
              child: const Text('ITEM TITLE',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              alignment: Alignment.centerLeft,
              width: 300,
              height: 20,
            ),
          ],
        ),
        padding: const EdgeInsets.only(top: 20),
        width: 400,
        height: 200,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}
