// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the Provider package.
import 'package:bar_management/screens/welcome_screen.dart';
import 'package:bar_management/providers/category_provider.dart';
import 'package:bar_management/providers/product_provider.dart';
import 'package:bar_management/providers/costumer_provider.dart';
import 'package:bar_management/providers/sale_provider.dart';
import 'package:bar_management/providers/bill_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()), // Provide the CategoryyProvider.
        ChangeNotifierProvider(create: (_) => ProductProvider()), // Provide the ProductProvider.
        ChangeNotifierProvider(create: (_) => CostumerProvider()), // Provide the CostumerProvider.
        ChangeNotifierProvider(create: (_) => SaleProvider()), // Provide the SaleProvider.
        ChangeNotifierProvider(create: (_) => BillProvider()), // Provide the BillProvider.
        // You can add more providers for other data as needed.
      ],
      child: MaterialApp(
        home: WelcomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}