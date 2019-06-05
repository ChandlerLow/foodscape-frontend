import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/models/recipe.dart';
import 'package:frontend/core/view_models/recipe_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/views/base_view.dart';
import 'package:auto_size_text/auto_size_text.dart';

class RecipeCarousel extends StatelessWidget{

  const RecipeCarousel({this.ingredient});

  final String ingredient;

  @override
  Widget build(BuildContext context) {
    return BaseView<RecipeModel>(onModelReady: (RecipeModel model) {
     model.getRecipes(ingredient);
    },builder: (BuildContext context, RecipeModel model, Widget child) {
      return RefreshIndicator(
        child: model.state == ViewState.Idle ?
        recipeCarousel(model.recipes)
            : Center(child: const CircularProgressIndicator()),
        onRefresh: () => model.getRecipes(ingredient),
      );
    },);
  }

  Widget recipeCarousel(List<Recipe> recipes) => CarouselSlider(
      height: 160,
      items: recipes.map((Recipe recipe) {
        return Builder(
          builder: (BuildContext context) {
            return Card(child :Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: <Widget> [
                    Container(child: FadeInImage.assetNetwork(
                      placeholder: 'assets/camera.png',
                      image: recipe.imageString,
                    ),
                      width: 400,
                      height: 130,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,),
                    Container(child: AutoSizeText(recipe.recipeName, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),),
                  ],
                )
            )
            );
          },
        );
      }).toList()
  );


}
