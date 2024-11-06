import 'package:flutter/material.dart';

import '../data/dummy_items.dart';
import '../widgets/grocery_item.dart';

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
        itemBuilder: (ctx, i) => GroceryItem(
          categoryColor: groceryItems[i].category.color,
          name: groceryItems[i].name,
          quantity: groceryItems[i].quantity,
        ),
      ),
    );
  }
}

