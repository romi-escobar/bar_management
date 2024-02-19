// read_costumer_dialog.dart
import 'package:bar_management/models/product.dart';
import 'package:flutter/material.dart';

class ReadProductDialog extends StatelessWidget {
  final Product product;

  ReadProductDialog({required this.product});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Product Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Code: ${product.code}'),
          Text('Name: ${product.name}'),
          Text('Category: ${product.category}'),
          Text('Price: ${product.price}')
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
