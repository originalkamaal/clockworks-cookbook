import 'package:clockworks/models/recipe.dart';
import 'package:flutter/material.dart';

class RecipeScreen extends StatelessWidget {
  final Recipe recipe;
  const RecipeScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(recipe.name),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            if (recipe.image != null) Image.network(recipe.image!),
            Text(
              recipe.name,
              style: const TextStyle(fontSize: 32),
            ),
            Text(recipe.description, style: const TextStyle(fontSize: 20)),
            const SizedBox(
              height: 20,
            ),
            const Text('Ingredients', style: TextStyle(fontWeight: FontWeight.bold)),
            ...recipe.ingredients.map((e) => Text('${e.name}  -  ${e.quantity} ${e.unit}')),
            const SizedBox(
              height: 20,
            ),
            const Text('Steps', style: TextStyle(fontWeight: FontWeight.bold)),
            ...recipe.steps.map((e) => Text('${e.title}  -  ${e.description}')),
          ],
        ));
  }
}
