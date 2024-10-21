import 'package:clockworks/models/ingredients.dart';

class RecipeStep {
  final String title;
  String description;
  final String? image;

  RecipeStep({required this.title, required this.description, this.image});

  factory RecipeStep.fromJson(Map<String, dynamic> json) {
    return RecipeStep(title: json['title'], description: json['description'], image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'image': image};
  }
}

class Recipe {
  final String name;
  final String description;
  final String? image;
  final List<Ingredient> ingredients;
  final List<RecipeStep> steps;

  Recipe({required this.name, required this.description, this.image, required this.ingredients, required this.steps});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      ingredients: json['ingredients'].map<Ingredient>((ingredient) => Ingredient.fromJson(ingredient)).toList(),
      steps: json['steps'].map<RecipeStep>((step) => RecipeStep.fromJson(step)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
      'steps': steps.map((e) => e.toJson()).toList(),
    };
  }
}
