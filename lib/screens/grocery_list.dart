import 'package:flutter/material.dart';

import '../data/dummy_items.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Grocery'),
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, i) => ListTile(
          leading: Container(
            width: 24,
            height: 24,
            color: groceryItems[i].category.color,
          ),
          title: Text(groceryItems[i].name),
          trailing: Text(groceryItems[i].quantity.toString()),
        ),
      ),
    );
  }
}
