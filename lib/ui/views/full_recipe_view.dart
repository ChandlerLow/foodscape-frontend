import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/models/recipe_recommendation.dart';
import 'package:frontend/core/services/api.dart';
import 'package:frontend/locator.dart';
import 'package:frontend/ui/shared/app_colors.dart' as app_colors;
import 'package:shimmer/shimmer.dart';

class RecipeView extends StatelessWidget {
  const RecipeView({this.recipe});

  final RecipeRecommendation recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: app_colors.backgroundColorPink,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          margin: const EdgeInsets.only(bottom: 75),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3.0,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Item image
              Container(
                child: Hero(
                  tag: 'recipe-${recipe.recipeTitle}',
                  child: recipe.imageURL == null || recipe.imageURL == ''
                      ? Container(
                          child: Icon(
                            defaultCategories[0].icon,
                            size: 50,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                          height: 170.0,
                          width: 300.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFABBC5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        )
                      : Container(
                          height: 170.0,
                          width: 300.0,
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[100],
                                  child: Container(
                                    height: 170.0,
                                    width: 300.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/1x1.png',
                                  image: recipe.imageURL,
                                  fit: BoxFit.cover,
                                  height: 170.0,
                                  width: 300.0,
                                ),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                        ),
                ),
                alignment: Alignment.center,
                height: 175.0,
                width: 305.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
              ),
              // Item name
              Container(
                child: Text(
                  recipe.recipeTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Divider(height: 10),
                  const Text('Ingredients on FoodScape',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  _buildRowUsed(recipe.usedIngredients, recipe, context),
                  const Divider(height: 10),
                  const Text(
                    'Ingredients not on FoodScape',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  _buildRowMissed(recipe.missingIngredients),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowUsed(List<Item> ingredients, RecipeRecommendation recipe,
      BuildContext context) {
    final List<Widget> chips = <Widget>[];
    for (Item i in ingredients) {
      chips.add(ActionChip(
          label: Text(
            i.name.toLowerCase(),
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: () {
            sendItemMetric(i.id, recipe.recipeTitle);
            Navigator.pushNamed(context, '/item', arguments: i);
          },
          backgroundColor: defaultCategories[i.categoryId].color));
      chips.add(Container(
        width: 10,
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chips,
      ),
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Widget _buildRowMissed(List<String> ingredients) {
    List<Widget> chips = <Widget>[];
    for (String i in ingredients) {
      final Color color = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0);
      chips.add(Chip(
          label: Text(
            i,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black45));
      chips.add(Container(
        width: 10,
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chips,
      ),
    );
  }

  Color getTextColor(Color color) {
    int d = 0;

// Counting the perceptive luminance - human eye favors green color...
    final double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    if (luminance > 0.5)
      d = 0; // bright colors - black font
    else
      d = 255; // dark colors - white font

    return Color.fromARGB(color.alpha, d, d, d);
  }

  Future<void> sendItemMetric(int itemId, String recipeName) async {
    final Api _api = locator<Api>();
    await _api.sendItemMetric(
      'open_item',
      source: 'recipe',
      additional: '{\'item: ${itemId.toString()}\', recipe: \'$recipeName\'}',
    );
  }
}
