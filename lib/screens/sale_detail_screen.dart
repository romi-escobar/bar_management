// sale_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:bar_management/models/sale.dart';

class SaleDetailScreen extends StatelessWidget {
  final Sale sale;

  SaleDetailScreen({required this.sale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sale Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display other sale details
          // ...

          // Display sale details for each item
          for (var saleDetail in sale.saleDetails)
            ListTile(
              title: Text('Product Code: ${saleDetail.product.code}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product Name: ${saleDetail.product.name}'),
                  Text('Quantity: ${saleDetail.quantity}'),
                  Text('Total for Product: \$${saleDetail.totalForProduct.toStringAsFixed(2)}'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

