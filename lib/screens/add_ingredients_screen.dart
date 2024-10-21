import 'dart:typed_data';

import 'package:clockworks/constants.dart';
import 'package:clockworks/helpers/firestore.dart';
import 'package:clockworks/models/ingredients.dart';
import 'package:clockworks/models/pick_image.dart';
import 'package:clockworks/utils/pick_image.dart';
import 'package:flutter/material.dart';

class AddIngredientsScreen extends StatefulWidget {
  const AddIngredientsScreen({super.key});

  @override
  State<AddIngredientsScreen> createState() => _AddIngredientsScreenState();
}

class _AddIngredientsScreenState extends State<AddIngredientsScreen> {
  String selectedUnit = 'grams';
  String name = '';
  String description = '';
  String quantity = '';
  final _formKey = GlobalKey<FormState>();
  PickImageResult? _pickImageResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Ingredients')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: " Name",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                name = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
              onSaved: (value) {
                description = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButton(
              itemHeight: 60,
              isExpanded: true,
              value: selectedUnit,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedUnit = value;
                  });
                }
              },
              items: ingredientUnits.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            if (_pickImageResult != null)
              Stack(
                children: [
                  Image.memory(
                    Uint8List.fromList(_pickImageResult!.imageBytes),
                    width: 100,
                    height: 100,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _pickImageResult = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
            if (_pickImageResult == null)
              ElevatedButton(
                onPressed: () async {
                  await pickImage()
                      .then((value) => setState(() {
                            _pickImageResult = value;
                          }))
                      .catchError((error) => {});
                },
                child: const Text('Pick Image'),
              ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  FirestoreHelper.addIngredient(Ingredient(name: name, unit: selectedUnit, image: _pickImageResult?.base64String)).then((value) => {
                        Navigator.of(context).pop(),
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ingredient added successfully'))),
                        setState(() {
                          _pickImageResult = null;
                        })
                      });
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
