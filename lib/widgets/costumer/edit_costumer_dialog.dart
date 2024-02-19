// edit_costumer_dialog.dart
import 'package:flutter/material.dart';

class EditCostumerDialog extends StatelessWidget {
  final String currentName;
  final String currentLastName;
  final String currentRuc;
  final String currentEmail;
  final Function(String, String, String, String) onEdit;

  EditCostumerDialog({
    required this.currentName,
    required this.currentLastName,
    required this.currentRuc,
    required this.currentEmail,
    required this.onEdit,
  });

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _rucController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = currentName;
    _lastNameController.text = currentLastName;
    _rucController.text = currentRuc;
    _emailController.text = currentEmail;

    return AlertDialog(
      title: Text('Edit Customer'),
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
            Navigator.of(context).pop();
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
              onEdit(newName, newLastName, newRuc, newEmail);
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
