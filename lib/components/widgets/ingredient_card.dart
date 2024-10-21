import 'dart:convert';
import 'dart:typed_data';

import 'package:clockworks/models/ingredients.dart';
import 'package:flutter/material.dart';

class IngredientCard extends StatefulWidget {
  final Ingredient ingredient;
  const IngredientCard({super.key, required this.ingredient});

  @override
  State<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            (widget.ingredient.image != null)
                ? Image.memory(
                    Uint8List.fromList(base64Decode(widget.ingredient.image!)),
                    height: 50,
                    width: 50,
                    fit: BoxFit.fill,
                  )
                : Image.memory(
                    Uint8List.fromList(base64Decode('R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==')),
                    height: 50,
                    width: 50,
                    fit: BoxFit.fill,
                  ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${widget.ingredient.name}'),
                Text('Unit: ${widget.ingredient.unit}'),
              ],
            )
          ])
        ],
      ),
    );
  }
}
