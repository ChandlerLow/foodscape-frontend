import 'package:flutter/material.dart';
import 'package:frontend/pages/view_item.dart';
import 'items.dart';

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
        title: Text('My Items',),
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
  final myItems = <ItemCardWidget>[];

  @override
  void initState() {
    myItems.add(ItemCardWidget());
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child :ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) => myItems[i],
        itemCount: myItems.length,
      ),
      padding: EdgeInsets.only(
        bottom: 100,
      ),
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
    // TODO: implement build
    return Card(
          child: Container(
            child: Column(
              children: <Widget>[
                //image widget with overlays
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/banana.jpg'),
                      )
                  ),
                  width: 300,
                  height: 150,
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  //This would enable a image to be displayed as the background for the container
                  alignment: Alignment.center,
                ),
                //maybe add another container for padding or increase margins on upper container
                //widget for containing information
                Container(
                  child: Text("ITEM TITLE",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  alignment: Alignment.centerLeft,
                  width: 300,
                  height: 20,
                ),
              ],
            ),
            padding: EdgeInsets.only(
              top: 20,
            ),
            width: 400,
            height: 200,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
    );
  }
}