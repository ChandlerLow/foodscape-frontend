import 'package:flutter/material.dart';
import 'package:frontend/pages/items.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodScape',
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
      home: ItemsWidget(),
    );
  }
}
