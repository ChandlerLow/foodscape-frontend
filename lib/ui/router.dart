import 'package:flutter/material.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/ui/views/item_view.dart';
import 'package:frontend/ui/views/items_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/items':
        return MaterialPageRoute<dynamic>(builder: (_) => ItemsView());
      case '/item':
        final Item item = settings.arguments;
        return MaterialPageRoute<dynamic>(builder: (_) => ItemView(item: item));
      default:
        return MaterialPageRoute<dynamic>(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
