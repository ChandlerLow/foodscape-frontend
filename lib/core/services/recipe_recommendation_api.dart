
import 'dart:convert';

import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:frontend/core/models/recipe_recommendation.dart';

class RecipeRecommendationApi {

  static const String spoonEndpoint = 'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?number=20&ranking&ignorePantry=true&ingredients=';

  Client client = http.Client();

  Future<List<RecipeRecommendation>> getRecipesFromMap(Map<String, Item> itemMap) async {
    final Map<String, String> requestHeaders = {'X-RapidAPI-Host': 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com', 'X-RapidAPI-Key' : '811ef08dd6msh1e111c963829c02p1a6df3jsn2302f50aa016'};
    final String ingredients = itemMap.keys.join('%2C');
    final Response response = await client.get(spoonEndpoint + ingredients,
      headers: requestHeaders,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load recipes - ${response.statusCode} - '
          '${response.body}');
    }

    final List<dynamic> recipesJson =
    json.decode(response.body);
    return recipesJson
        .map((dynamic recipeJson) => RecipeRecommendation.fromJson(recipeJson, itemMap))
        .toList();
  }
}