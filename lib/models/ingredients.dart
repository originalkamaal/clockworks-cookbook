class Ingredient {
  final String name;
  final String unit;
  double? quantity;
  final String? image;

  Ingredient({required this.name, required this.unit, this.quantity, this.image});

  updateQuantity(double quantity) {
    this.quantity = quantity;
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      unit: json['unit'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'unit': unit, 'image': image, 'quantity': quantity};
  }
}
