
import 'item.dart';

class RecipeRecommendation {

  RecipeRecommendation({this.recipeTitle, this.imageURL, this.missingIngredients, this.usedIngredients});

  factory RecipeRecommendation.fromJson(Map<String, dynamic> json, Map<String, Item> itemMap, List<Item> usedItems) {
    return RecipeRecommendation(
      recipeTitle: json['title'],
      imageURL: json['image'],
      missingIngredients: RecipeRecommendation.getMissingIngredients(json['missedIngredients']),
      usedIngredients: usedItems,
    );
  }

  final String recipeTitle;
  final String imageURL;
  final List<String> missingIngredients;
  final List<Item> usedIngredients;

  static List<String> getMissingIngredients(List<dynamic> ingredientsList) {
    return ingredientsList.map<String>((dynamic i) => i['name']).toList();
  }

  static String getIngredient(Map<String, dynamic> ingredient) {
    String ingredientName = ingredient['name'];
    if (ingredientName[ingredientName.length - 1] == 's') {
      ingredientName = ingredientName.substring(0, ingredientName.length - 1);
    }
   // print(ingredientName);
    return ingredientName;
  }
}