import 'package:clockworks/models/recipe.dart';
import 'package:clockworks/screens/add_recipe_screen.dart';
import 'package:clockworks/screens/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cookbook Recipes'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const AddRecipeScreen()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FirestoreListView<Recipe>(
        query: FirebaseFirestore.instance
            .collection('recipes')
            .orderBy('name', descending: false)
            .withConverter(fromFirestore: (map, _) => Recipe.fromJson(map.data()!), toFirestore: (recipe, _) => recipe.toJson()),
        itemBuilder: (context, snapshot) {
          final recipe = snapshot.data();
          return ListTile(
            tileColor: Colors.grey.shade100,
            title: Text(recipe.name),
            subtitle: Text(recipe.description),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => RecipeScreen(recipe: recipe))),
          );
        },
      ),
    );
  }
}
