class Recipe {

  Recipe({this.id, this.recipeName, this.imageString});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      recipeName: json['title'],
      imageString: json['image']
    );
  }

  final int id;
  final String recipeName;
  final String imageString;

}