import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/models/recipe.dart';
import 'package:frontend/core/models/recipe_recommendation.dart';
import 'package:frontend/core/view_models/recipe_model.dart';
import 'package:frontend/core/view_models/recipe_recommendation_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/shared/ui_helpers.dart';
import 'package:frontend/ui/views/base_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeCarousel extends StatelessWidget {
  const RecipeCarousel({this.ingredient});

  final String ingredient;

  @override
  Widget build(BuildContext context) {
    return BaseView<RecipeModel>(
      onModelReady: (RecipeModel model) {
        model.getRecipes(ingredient);
      },
      builder: (BuildContext context, RecipeModel model, Widget child) {
        return RefreshIndicator(
          child: model.state == ViewState.Idle
              ? recipeCarousel(model.recipes)
              : Center(child: const CircularProgressIndicator()),
          onRefresh: () => model.getRecipes(ingredient),
        );
      },
    );
  }

  Widget recipeCarousel(List<Recipe> recipes) => CarouselSlider(
      height: 160,
      items: recipes.map((Recipe recipe) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                _launchURL(recipe.recipeURL);
              },
              child:Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Hero(
                              tag: 'recipe-${recipe.recipeTitle}',
                              child: Container(
                                child: recipe.recipeURL == null || recipe.recipeURL == ''
                                    ? Container(
                                  child: Icon(
                                    defaultCategories[0].icon,
                                    size: 50,
                                    color: Colors.black,
                                  ),
                                  alignment: Alignment.center,
                                  height: 150,
                                  width: 275,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFABBC5),
                                  ),
                                )
                                    : Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey[300],
                                        highlightColor: Colors.grey[100],
                                        child: Container(
                                          height: 120,
                                          width: 275,
                                          color: Colors.white,
                                        ),
                                      ),
                                      FadeInImage.assetNetwork(
                                        placeholder: 'assets/1x1.png',
                                        image: recipe.imageURL,
                                        fit: BoxFit.cover,
                                        height: 120,
                                        width: 275,
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            UIHelper.verticalSpaceSmall(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              width: 275,
                              child: Text(
                                recipe.recipeTitle,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ]
                      )),
                ),
              ),
            );
          },
        );
      }).toList());

  dynamic _launchURL(String recipeUrl) async {
    final String url = recipeUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class MultiRecipeCarousel extends StatelessWidget {

  const MultiRecipeCarousel({this.categoryValues});

  final dynamic categoryValues;

  @override
  Widget build(BuildContext context) {
    return BaseView<RecipeRecommendationModel>(
      onModelReady: (RecipeRecommendationModel model) {
        model.getRecipes(categoryValues);
      },
      builder: (BuildContext context, RecipeRecommendationModel model, Widget child) {
        return RefreshIndicator(
          child: model.state == ViewState.Idle
              ? recipeCarousel(model.recipes)
              : Center(child: const CircularProgressIndicator()),
          onRefresh: () => model.getRecipes(categoryValues),
        );
      },

    );
  }

  Widget recipeCarousel(List<RecipeRecommendation> recipes) => CarouselSlider(
      height: 160,
      items: recipes.map((RecipeRecommendation recipe) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/recipe',
                  arguments: recipe,
                );
              },
              child:Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Hero(
                              tag: 'recipe-${recipe.recipeTitle}',
                              child: Container(
                                child: recipe.imageURL == null || recipe.imageURL == ''
                                    ? Container(
                                  child: Icon(
                                    defaultCategories[0].icon,
                                    size: 50,
                                    color: Colors.black,
                                  ),
                                  alignment: Alignment.center,
                                  height: 150,
                                  width: 275,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFABBC5),
                                  ),
                                )
                                    : Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey[300],
                                        highlightColor: Colors.grey[100],
                                        child: Container(
                                          height: 120,
                                          width: 275,
                                          color: Colors.white,
                                        ),
                                      ),
                                      FadeInImage.assetNetwork(
                                        placeholder: 'assets/1x1.png',
                                        image: recipe.imageURL,
                                        fit: BoxFit.cover,
                                        height: 120,
                                        width: 275,
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            UIHelper.verticalSpaceSmall(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              width: 275,
                              child: Text(
                                recipe.recipeTitle,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ]
                      )),
                ),
              ),
            );
          },
        );
      }).toList());

}