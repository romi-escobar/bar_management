// read_costumer_dialog.dart
import 'package:flutter/material.dart';
import 'package:bar_management/models/costumer.dart';

class ReadCostumerDialog extends StatelessWidget {
  final Costumer costumer;

  ReadCostumerDialog({required this.costumer});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Customer Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${costumer.name}'),
          Text('Last Name: ${costumer.lastName}'),
          Text('RUC: ${costumer.ruc}'),
          Text('Email: ${costumer.email}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
