import 'package:frontend/core/models/recipe.dart';
import 'package:frontend/core/services/recipe_api.dart';
import 'package:frontend/core/view_models/base_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/locator.dart';

class RecipeModel extends BaseModel{

  final RecipeApi _recipeApi = locator<RecipeApi>();
  List<Recipe> recipes;

  Future<void> getRecipes(String ingredient) async {
    setState(ViewState.Busy);
    recipes = await _recipeApi.getRecipes(ingredient);
    setState(ViewState.Idle);
  }

}
