import 'package:flutter/material.dart';
import 'package:frontend/locator.dart';

import 'ui/router.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodScape',
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
      initialRoute: '/items',
      onGenerateRoute: Router.generateRoute,
    );
  }
}
