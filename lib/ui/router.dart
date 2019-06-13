import 'package:flutter/material.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/models/recipe.dart';
import 'package:frontend/core/models/recipe_recommendation.dart';
import 'package:frontend/ui/views/filter_view.dart';
import 'package:frontend/ui/views/full_recipe_view.dart';
import 'package:frontend/ui/views/home_view.dart';
import 'package:frontend/ui/views/item_creation_view.dart';
import 'package:frontend/ui/views/item_editing_view.dart';
import 'package:frontend/ui/views/item_operation_view.dart';
import 'package:frontend/ui/views/item_view.dart';
import 'package:frontend/ui/views/items_view.dart';
import 'package:frontend/ui/views/login_view.dart';
import 'package:frontend/ui/views/profile_view.dart';
import 'package:frontend/ui/views/register_view.dart';
import 'package:frontend/ui/views/user_items_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute<dynamic>(builder: (_) => HomeView());
      case '/items/add':
        return MaterialPageRoute<dynamic>(builder: (_) => ItemCreationView());
      case '/items/edit':
        final Item item = settings.arguments;
        return MaterialPageRoute<dynamic>(
            builder: (_) => ItemEditingView(item: item));
      case '/items/filter':
        return MaterialPageRoute<dynamic>(builder: (_) => FilterView());
      case '/item':
        final Item item = settings.arguments;
        return MaterialPageRoute<dynamic>(builder: (_) => ItemView(item: item));
      case '/login':
        return MaterialPageRoute<dynamic>(builder: (_) => LoginView());
      case '/register':
        return MaterialPageRoute<dynamic>(builder: (_) => RegisterView());
      case '/profile':
        return MaterialPageRoute<dynamic>(builder: (_) => ProfileView());
      case '/user/items':
        return MaterialPageRoute<dynamic>(builder: (_) => UserItemsView());
      case '/operations':
        final Item item = settings.arguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => ItemOperationsView(item: item),
        );
      case '/recipe':
        final RecipeRecommendation recipe = settings.arguments;
        return MaterialPageRoute<dynamic>(builder: (_) => RecipeView(recipe: recipe));
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
