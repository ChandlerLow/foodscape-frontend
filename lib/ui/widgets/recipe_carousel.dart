import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/models/recipe.dart';
import 'package:frontend/core/view_models/recipe_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/views/base_view.dart';
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
              onTap: () => _launchURL(recipe.recipeURL),
              child: Card(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                alignment: FractionalOffset.topCenter,
                                image: NetworkImage(recipe.imageURL),
                              ),
                            ),
                            width: 400,
                            height: 120,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                        Container(
                          child: AutoSizeText(
                            recipe.recipeTitle,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )),
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
