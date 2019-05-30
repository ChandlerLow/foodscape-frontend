import 'package:flutter/material.dart';
import 'package:frontend/pages/view_item.dart';
import 'package:frontend/utils.dart';

import 'item_creation.dart';

class ItemsWidget extends StatefulWidget {
  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ramsay Hall'),
      ),
      body: ItemListWidget(),
      drawer: makeDrawer(context),
      floatingActionButton: showFab
          ? FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.grey,
              elevation: 2.0,
              child: const Icon(Icons.add),
              //label: const Text('Add an item'),
              onPressed: () {
                // TODO(x): pass item as an argument for the widget
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => CreationWidget()),
                );
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ItemListWidget extends StatefulWidget {
  final List<Widget> items = <Widget>[];

  @override
  ItemListState createState() {
    for (int i = 0; i < 10; i++) {
      items.add(const ItemCardWidget('Banana', '1 Day', 'Block A'));
    }
    return ItemListState(items);
  }
}

class ItemListState extends State<ItemListWidget> {
  ItemListState(this.items);

  //Constructs a item list parse in the items through the constructor
  // TODO(x): modify items type
  List<Widget> items = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int i) => items[i],
        itemCount: items.length,
      ),
      padding: const EdgeInsets.only(
        bottom: 100,
      ),
    );
  }
}

class ItemCardWidget extends StatefulWidget {
  const ItemCardWidget(this.name, this.daysLeft, this.location);

  // TODO(x): modify to pass in data/item class
  final String name;
  final String daysLeft;
  final String location;

  @override
  ItemCardState createState() => ItemCardState(name, daysLeft, location);
}

class ItemCardState extends State<ItemCardWidget> {
  ItemCardState(this.name, this.daysLeft, this.location);

  String name;
  String daysLeft;
  String location;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ViewItemWidget(),
            ),
          ),
      child: makeCard(name, daysLeft, location),
    );
  }
}
