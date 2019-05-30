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
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewItemWidget())),
      child: makeCard(),
    );
  }
}