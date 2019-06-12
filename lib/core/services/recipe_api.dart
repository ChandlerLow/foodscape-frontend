import 'dart:convert';

import 'package:frontend/core/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RecipeApi {
  static const String APIKEY = '2a87a63977b906c19b235d59bde976f3';
  static const String endpoint =
      'https://www.food2fork.com/api/search?key=$APIKEY&q=';

  Client client = http.Client();

  Future<List<Recipe>> getRecipes(String ingredients) async {
   ingredients = ingredients.split(' ').join('%20');
    final Response response = await client.get(
      endpoint + ingredients,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load recipes - ${response.statusCode} - '
          '${response.body}');
    }

    final List<dynamic> recipesJson = json.decode(response.body)['recipes'];
    return recipesJson
        .map((dynamic recipeJson) => Recipe.fromJson(recipeJson))
        .toList();
  }
}
