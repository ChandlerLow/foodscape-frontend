import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class _ItemsWidgetState extends State<ItemsWidget> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ramsay Hall'),
        actions: <Widget>[ // Add 3 lines from here...
          IconButton(icon: Icon(Icons.favorite), onPressed: _pushSaved),
        ],
        /*leading: new IconButton(
          icon: new Icon(Icons.list),
          onPressed: () {
            openToggle();
          },
        ),*/
      ),
      drawer: Drawer(
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
      ),
      //body: _buildSuggestions(),
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

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }

          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
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