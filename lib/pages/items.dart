import 'package:flutter/material.dart';
import 'package:frontend/pages/view_item.dart';
import 'item_creation.dart';
import 'package:frontend/utils.dart';

class ItemsWidget extends StatefulWidget {
  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
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

      drawer: makeDrawer(context),

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

}

class ItemListWidget extends StatefulWidget {
  final items = <Widget>[];

  @override
  ItemListState createState() {
    for(int i = 0; i < 10; i++) {
      items.add(ItemCardWidget());
    }
    return ItemListState(items);
  }
}

class ItemListState extends State<ItemListWidget> {

  //Constructs a item list parse in the items through the constructor
  //TODO modify items type
  var items = <Widget>[];

  ItemListState(List<Widget> widgets) {
    this.items = widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child :ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) => items[i],
          itemCount: items.length,
      ),
      padding: EdgeInsets.only(
        bottom: 100,
      ),
    );
  }

}

class ItemCardWidget extends StatefulWidget {
  //TODO parse in data to construct cards
  @override
  ItemCardState createState() => ItemCardState();
}

class ItemCardState extends State<ItemCardWidget> {
  //constructor an item card with Data Class
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewItemWidget())),
      child: makeCard(),
    );
  }
}