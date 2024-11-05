import 'package:flutter/material.dart';

import 'screens/grocery_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
          seedColor: const Color(0xFF92E6F7),
          surface: const Color(0xFF2C323C),
        ),
        scaffoldBackgroundColor: const Color(0xFF31393B),
      ),
      home: const GroceryList(),
    );
  }
}
