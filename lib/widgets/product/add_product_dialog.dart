// add_product_dialog.dart
import 'package:flutter/material.dart';
import 'package:bar_management/models/category.dart';

class AddProductDialog extends StatelessWidget {
  final Function(String, String, Category, int) onAdd;

  AddProductDialog({required this.onAdd});

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Product'),
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
            Navigator.pop(context);
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
              onAdd(newCode, newName, newCategory, newPrice);
            }
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}

