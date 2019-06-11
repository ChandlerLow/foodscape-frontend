import 'dart:convert';

import 'item.dart';

class Recipe {

  Recipe({this.recipeTitle, this.imageURL, this.recipeURL});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipeTitle: json['title'],
      imageURL: json['image_url'],
      recipeURL: json['f2f_url']
    );
  }

  final String recipeTitle;
  final String imageURL;
  final String recipeURL;

  /*
  Recipe({this.recipeTitle, this.imageURL, this.recipeURL, this.missingIngredients, this.usedIngredients});

  factory Recipe.fromJson(Map<String, dynamic> json, Map<String, Item> itemMap) {
    return Recipe(
      recipeTitle: json['title'],
      imageURL: json['image'],
      missingIngredients: Recipe.getIngredients(json['missedIngredients'], itemMap),
      usedIngredients: Recipe.getIngredients(json['usedIngredients'], itemMap),
      recipeURL: 'https://www.imperial.ac.uk/',
    );
  }

  final String recipeTitle;
  final String imageURL;
  final String recipeURL;
  final List<Item> missingIngredients;
  final List<Item> usedIngredients;


  static List<Item> getIngredients(List<dynamic> ingredientsList, Map<String, Item> itemMap) {
    return ingredientsList = ingredientsList.map((dynamic i) => itemMap[Recipe.getIngredient(i)]).toList();
  }

  static String getIngredient(Map<String, dynamic> ingredient) {
    String ingredientName = ingredient['name'];
    if (ingredientName[ingredientName.length - 1] == 's') {
      ingredientName = ingredientName.substring(0, ingredientName.length - 1);
    }
    print(ingredientName);
    return ingredientName;
  }
  */

}