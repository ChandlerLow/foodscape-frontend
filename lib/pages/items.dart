import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/view_item.dart';
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
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ramsay Hall'),
      ),
      body: ItemListWidget(),
      drawer: makeDrawer(),
      floatingActionButton: showFab ? FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.grey,
        elevation: 2.0,
        child: const Icon(Icons.add),
        //label: const Text('Add an item'),
        onPressed: () {
          //TODO: pass item as an argument for the widget
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreationWidget()));
        },
      ) : null,
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

class ItemListWidget extends StatefulWidget {
  @override
  ItemListState createState() => ItemListState();
}

class ItemListState extends State<ItemListWidget> {
  //constructs a list view of cards
  // need to modify instead of containing the widget will hold data then constructs card with data
  final cards = <ItemCardWidget>[];

  //rerenders? unsure how updating will work
  @override
  // ignore: must_call_super
  void initState() {
    cards.add(ItemCardWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child :ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) => cards[i],
          itemCount: cards.length,
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
    return GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewItemWidget())),
        child: Card(
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
        )
    );
  }
}

class Item {

}
