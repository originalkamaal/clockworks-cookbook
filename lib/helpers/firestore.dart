import 'package:clockworks/constants.dart';
import 'package:clockworks/models/ingredients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static Future<void> addRecipe(Map<String, dynamic> recipe) async {
    await FirebaseFirestore.instance.collection(recipeCollection).add(recipe);
  }

  static Future<void> addIngredient(Ingredient ingredient) async {
    await FirebaseFirestore.instance.collection(ingredientCollection).add(ingredient.toJson());
  }
}
