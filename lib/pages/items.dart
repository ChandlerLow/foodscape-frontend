import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'item_creation.dart';

class _ItemsWidgetState extends State<ItemsWidget> {
  final List<Item> _items = <Item> [];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ramsay Hall'),
        /*actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite), onPressed: _pushSaved),
        ],*/
      ),
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
                //TODO: add action
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

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}

class ItemsWidget extends StatefulWidget {
  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class Item {

}
