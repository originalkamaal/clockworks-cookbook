import 'package:clockworks/constants.dart';
import 'package:clockworks/models/ingredients.dart';
import 'package:clockworks/models/recipe.dart';
import 'package:clockworks/screens/pick_ingredients_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  List<Ingredient> selectedIngredients = [];
  List<RecipeStep> steps = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                controller: descriptionController,
              ),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Ingredients'),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () async {
                    Ingredient? res = await Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => PickIngredientsScreen(
                              selectedItems: selectedIngredients,
                            )));
                    if (res != null) {
                      setState(() {
                        selectedIngredients.add(res);
                      });
                    }
                  },
                  child: const Text('Add'),
                ),
              ]),
              const SizedBox(height: 16),
              ...selectedIngredients.map((e) => Row(
                    children: [
                      Expanded(flex: 2, child: Text(e.name)),
                      Expanded(
                        child: TextField(
                            controller: TextEditingController(text: e.quantity != null ? e.quantity.toString() : ''),
                            decoration: const InputDecoration(
                              labelText: 'Quantity',
                            ),
                            onChanged: (value) {
                              e.quantity = double.parse(value);
                            }),
                      ),
                      Text(' ${e.unit}'),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              selectedIngredients.remove(e);
                            });
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  )),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Steps'),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      steps.add(RecipeStep(title: 'Step ${steps.length + 1}:', description: ''));
                    });
                  },
                  child: const Text('Add'),
                ),
              ]),
              const SizedBox(height: 16),
              ...steps.map((e) => Column(
                    children: [
                      Row(children: [
                        Expanded(child: Text(e.title)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                steps.remove(e);
                              });
                            },
                            icon: const Icon(Icons.delete)),
                      ]),
                      TextField(
                        maxLines: null,
                        decoration: const InputDecoration(
                          labelText: 'Step Details',
                        ),
                        onChanged: (value) {
                          setState(() {
                            e.description = value;
                          });
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Recipe added')),
                    );
                    var data = Recipe(
                      name: nameController.text,
                      description: descriptionController.text,
                      ingredients: selectedIngredients,
                      steps: steps,
                    ).toJson();

                    FirebaseFirestore.instance
                        .collection(recipeCollection)
                        .add(data)
                        .then((value) => Navigator.of(context).pop())
                        .catchError((err) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString()))));
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
