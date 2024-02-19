// add_sale_dialog.dart
import 'package:bar_management/models/sale.dart';
import 'package:flutter/material.dart';

class AddSaleDialog extends StatelessWidget {
  final Function(Sale) onAdd;

  AddSaleDialog({required this.onAdd});

  // Add necessary controllers here

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Sale'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add form fields for sale header details (e.g., bill number, sale date)
          // Add form fields for sale detail (e.g., product code, quantity, etc.)
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
            // Validate and add sale
            // You can use the onAdd function to add the sale to the provider
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
