import 'package:flutter/material.dart';

import '../widgets/grocery_item.dart';
import 'form_screen.dart';
import '../model/grocery_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final List<GroceryItemModel> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 1,
    );
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No item added yet.'),
    );

    if (_groceryItems.isNotEmpty) {
      content = AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Padding(
          padding: EdgeInsets.only(top: animationController.value * 140),
          child: child,
        ),
        child: ListView.builder(
          itemCount: _groceryItems.length,
          itemBuilder: (ctx, i) => Dismissible(
            key: ValueKey(_groceryItems[i].id),
            background: Container(color: Theme.of(context).colorScheme.onError),
            onDismissed: (direction) {
              setState(() {
                _groceryItems.remove(_groceryItems[i]);
              });
            },
            child: GroceryItem(
              categoryColor: _groceryItems[i].category.color,
              name: _groceryItems[i].name,
              quantity: _groceryItems[i].quantity,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Grocery'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push<GroceryItemModel>(
                context,
                MaterialPageRoute(
                  builder: (context) => const FormScreen(),
                ),
              ).then((value) {
                if (value == null) return;
                setState(() {
                  _groceryItems.add(value);
                });
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
