import 'package:flutter/material.dart';

class GroceryItem extends StatelessWidget {
  final Color categoryColor;
  final String name;
  final int quantity;

  const GroceryItem({
    super.key,
    required this.categoryColor,
    required this.name,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 24,
        height: 24,
        color: categoryColor,
      ),
      title: Text(name),
      trailing: Text(quantity.toString()),
    );
  }
}
