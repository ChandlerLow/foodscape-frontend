import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:frontend/core/models/recipe.dart';
import 'package:frontend/core/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeApi {
  static const String APIKEY = 'a292391b38d9f11537efa3871ed824ea';
  static const String endpoint =
      'https://www.food2fork.com/api/search?key=$APIKEY&q=';

  Client client = http.Client();

  Future<List<Recipe>> getRecipes(String ingredients) async {
   //final Map<String, String> requestHeaders = {'X-RapidAPI-Host': 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com', 'X-RapidAPI-Key' : '811ef08dd6msh1e111c963829c02p1a6df3jsn2302f50aa016'};
   ingredients = ingredients.split(' ').join('%20');
    final Response response = await client.get(
      endpoint + ingredients,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load recipes - ${response.statusCode} - '
          '${response.body}');
    }

    final List<dynamic> recipesJson =
    json.decode(response.body)['recipes'];
    return recipesJson
        .map((dynamic recipeJson) => Recipe.fromJson(recipeJson))
        .toList();
  }

}