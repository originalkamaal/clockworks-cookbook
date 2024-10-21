import 'package:clockworks/components/widgets/ingredient_card.dart';
import 'package:clockworks/models/ingredients.dart';
import 'package:clockworks/screens/add_ingredients_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IngredientsScreen extends StatelessWidget {
  const IngredientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingredients'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const AddIngredientsScreen()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FirestoreListView(
        query: FirebaseFirestore.instance
            .collection('ingredients')
            .withConverter<Ingredient>(fromFirestore: (map, _) => Ingredient.fromJson(map.data()!), toFirestore: (ingredient, _) => ingredient.toJson()),
        itemBuilder: (BuildContext context, QueryDocumentSnapshot<Ingredient> doc) {
          Ingredient ingredient = doc.data();
          return IngredientCard(ingredient: ingredient);
        },
      ),
    );
  }
}
