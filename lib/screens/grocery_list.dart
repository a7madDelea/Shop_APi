import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/categories.dart';
import '../model/category.dart';
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
  List<GroceryItemModel> _groceryItems = [];
  bool _isLoading = true;
  String? _error;

  _loadData() async {
    final Uri url = Uri.https(
      'flutter-6ae9f-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );
    final http.Response res = await http.get(url);
    if (res.statusCode >= 400) {
      setState(() {
        _error = 'Faild to fetch data. Please try again later.';
      });
    }
    final Map<String, dynamic> loadedData = json.decode(res.body);
    final List<GroceryItemModel> loadedItems = [];
    for (var item in loadedData.entries) {
      final Category category = categories.entries
          .firstWhere(
            (element) => element.value.title == item.value['category'],
          )
          .value;
      loadedItems.add(
        GroceryItemModel(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    setState(() {
      _groceryItems = loadedItems;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
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
    _loadData().dispose;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No item added yet.'),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Padding(
          padding: EdgeInsets.only(top: 200 - animationController.value * 200),
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

    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Grocery'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }

  _addItem() async {
    final newItem = await Navigator.push<GroceryItemModel>(
      context,
      MaterialPageRoute(
        builder: (context) => const FormScreen(),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }
}
