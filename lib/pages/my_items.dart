import 'package:flutter/material.dart';
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