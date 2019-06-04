import 'package:flutter/material.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/ui/views/filter_view.dart';
import 'package:frontend/ui/views/item_creation_view.dart';
import 'package:frontend/ui/views/item_view.dart';
import 'package:frontend/ui/views/items_view.dart';
import 'package:frontend/ui/views/login_view.dart';
import 'package:frontend/ui/views/register_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute<dynamic>(builder: (_) => ItemsView());
      case '/items/filter':
        return MaterialPageRoute<dynamic>(builder: (_) => FilterView());
      case '/items/add':
        return MaterialPageRoute<dynamic>(builder: (_) => ItemCreationView());
      case '/item':
        final Item item = settings.arguments;
        return MaterialPageRoute<dynamic>(builder: (_) => ItemView(item: item));
      case '/login':
        return MaterialPageRoute<dynamic>(builder: (_) => LoginView());
      case '/register':
        return MaterialPageRoute<dynamic>(builder: (_) => RegisterView());
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
