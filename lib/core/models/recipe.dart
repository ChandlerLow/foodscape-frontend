class Recipe {

  Recipe({this.recipeTitle, this.imageURL, this.recipeURL, });

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

}