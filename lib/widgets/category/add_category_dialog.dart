// add_category_dialog.dart
import 'package:flutter/material.dart';

class AddCategoryDialog extends StatelessWidget {
  final Function(String) onAdd;

  AddCategoryDialog({required this.onAdd});

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Category'),
      content: TextField(
        controller: _nameController,
        decoration: InputDecoration(labelText: 'Category Name'),
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
            final newName = _nameController.text;
            if (newName.isNotEmpty) {
              onAdd(newName); // Call the onAdd callback with the new category name.
            }
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}


