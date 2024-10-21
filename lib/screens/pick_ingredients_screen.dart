import 'package:clockworks/models/ingredients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class PickIngredientsScreen extends StatelessWidget {
  final List<Ingredient> selectedItems;
  const PickIngredientsScreen({super.key, required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Ingredients'),
      ),
      body: FirestoreListView<Ingredient>(
        query: FirebaseFirestore.instance
            .collection('ingredients')
            .withConverter<Ingredient>(fromFirestore: (map, _) => Ingredient.fromJson(map.data()!), toFirestore: (ingredient, _) => ingredient.toJson()),
        itemBuilder: (BuildContext context, QueryDocumentSnapshot<Ingredient> doc) {
          Ingredient ingredient = doc.data();
          if (selectedItems.firstWhereOrNull((element) => element.name == ingredient.name) != null) {
            return const SizedBox.shrink();
          }
          return ListTile(
            title: Text(ingredient.name),
            subtitle: Text(ingredient.name),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pop(ingredient);
              },
            ),
          );
        },
      ),
    );
  }
}
