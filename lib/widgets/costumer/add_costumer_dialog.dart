// add_costumer_dialog.dart
import 'package:flutter/material.dart';

class AddCostumerDialog extends StatelessWidget {
  final Function(String, String, String, String) onAdd;

  AddCostumerDialog({required this.onAdd});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _rucController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Customer'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _lastNameController,
            decoration: InputDecoration(labelText: 'Last Name'),
          ),
          TextField(
            controller: _rucController,
            decoration: InputDecoration(labelText: 'RUC'),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
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
            final newName = _nameController.text;
            final newLastName = _lastNameController.text;
            final newRuc = _rucController.text;
            final newEmail = _emailController.text;
            if (newName.isNotEmpty && newLastName.isNotEmpty && newRuc.isNotEmpty && newEmail.isNotEmpty) {
              onAdd(newName, newLastName, newRuc, newEmail);
            }
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
