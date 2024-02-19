// edit_product_dialog.dart
import 'package:flutter/material.dart';
import 'package:bar_management/models/category.dart';

class EditProductDialog extends StatelessWidget {
  final String currentCode;
  final String currentName;
  final Category currentCategory;
  final int currentPrice;
  final Function(String, String, Category, int) onEdit;

  EditProductDialog({
    required this.currentCode,
    required this.currentName,
    required this.currentCategory,
    required this.currentPrice,
    required this.onEdit,
  });

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _codeController.text = currentCode;
    _nameController.text = currentName;
    _categoryController.text = currentCategory.name;
    _priceController.text = currentPrice.toString();

    return AlertDialog(
      title: Text('Edit Product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _codeController,
            decoration: InputDecoration(labelText: 'Code'),
          ),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _categoryController,
            decoration: InputDecoration(labelText: 'Category'),
          ),
          TextField(
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Price'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final newCode = _codeController.text;
            final newName = _nameController.text;
            final newCategory = Category(id: 1, name: _categoryController.text); // Replace with actual category logic
            final newPrice = int.tryParse(_priceController.text) ?? 0;

            if (newCode.isNotEmpty && newName.isNotEmpty && newCategory.name.isNotEmpty && newPrice > 0) {
              onEdit(newCode, newName, newCategory, newPrice);
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
