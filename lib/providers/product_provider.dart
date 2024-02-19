// product_provider.dart
import 'package:flutter/material.dart';
import 'package:bar_management/models/category.dart';
import 'package:bar_management/models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  Product getProductById(int id) {
    return _products.firstWhere((product) => product.id == id);
  }

  List<Product> getProductsByCategory(Category category) {
    return _products.where((product) => product.category.id == category.id).toList();
  }

  void editProduct(
    int id,
    String newCode,
    String newName,
    Category newCategory,
    int newPrice,
  ) {
    final product = _products.firstWhere((p) => p.id == id);
    product.code = newCode;
    product.name = newName;
    product.category = newCategory;
    product.price = newPrice;

    notifyListeners();
  }

  void deleteProduct(int id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
