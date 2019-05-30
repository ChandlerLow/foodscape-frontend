import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/view_item.dart';
import 'package:frontend/utils/item_utils.dart';
import 'item_creation.dart';
import 'my_items.dart';

class ItemsWidget extends StatefulWidget {
  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  final List<Item> _items = <Item> [];
  //final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ramsay Hall'),
      ),
      body: ItemListWidget(),
      drawer: makeDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        elevation: 2.0,
        child: const Icon(Icons.add),
        //label: const Text('Add an item'),
        onPressed: () {
          //TODO: pass item as an argument for the widget
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreationWidget()));
        },
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
    );
  }

  Drawer makeDrawer() {
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
}

class Item {

}
