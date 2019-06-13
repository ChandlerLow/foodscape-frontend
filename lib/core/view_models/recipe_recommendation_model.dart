import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/models/recipe.dart';
import 'package:frontend/core/models/recipe_recommendation.dart';
import 'package:frontend/core/services/recipe_api.dart';
import 'package:frontend/core/services/recipe_recommendation_api.dart';
import 'package:frontend/core/view_models/base_model.dart';
import 'package:frontend/core/view_models/items_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/locator.dart';

class RecipeRecommendationModel extends BaseModel {

  final RecipeRecommendationApi _recipeRecommendationApi = locator<RecipeRecommendationApi>();
  List<RecipeRecommendation> recipes;

  Future<void> getRecipes(List<List<Item>> categoryValues) async {
    setState(ViewState.Busy);
    recipes = await _recipeRecommendationApi.getRecipesFromMap(getItemMap(categoryValues));
    setState(ViewState.Idle);
  }

  Map<String, Item> getItemMap(List<List<Item>> categories) {
    final Map<String, Item> itemMap = <String, Item>{};
    for (List<Item> items in categories) {
      for (Item item in items) {
        String ingredientName = item.name;
        if (ingredientName[ingredientName.length - 1] == 's') {
          ingredientName = ingredientName.substring(0, ingredientName.length - 1);
        }
        itemMap.putIfAbsent(ingredientName.toLowerCase(), () =>item);
      }
    }
    return itemMap;
  }
}