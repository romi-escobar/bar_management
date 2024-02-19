// category_provider.dart
import 'package:bar_management/models/category.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  void addCategory(Category category) {
    _categories.add(category);
    notifyListeners();
  }

  void editCategory(int id, String newName) {
    final category = _categories.firstWhere((s) => s.id == id);
    category.name = newName;
    notifyListeners();
  }

  void deleteCategory(int id) {
    _categories.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}
