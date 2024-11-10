import 'category.dart';

class GroceryItemModel {
  final String id;
  final String name;
  final int quantity;
  final Category category;

  const GroceryItemModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });
}
