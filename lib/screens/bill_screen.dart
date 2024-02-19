// bills_screen.dart
import 'package:bar_management/models/sale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bar_management/providers/sale_provider.dart';

class BillScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final saleProvider = Provider.of<SaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bills Screen'),
      ),
      body: ListView.builder(
        itemCount: saleProvider.getAllSales().length,
        itemBuilder: (context, index) {
          final sale = saleProvider.getAllSales()[index];

          return ListTile(
            title: Text('Bill Number: ${sale.billNumber}'),
            subtitle: Text('Total: \$${sale.totalPurchase.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                _showSaleDetailsDialog(context, sale);
              },
            ),
          );
        },
      ),
    );
  }

  void _showSaleDetailsDialog(BuildContext context, Sale sale) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sale Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bill Number: ${sale.billNumber}'),
              Text('Sale Date: ${sale.saleDate}'), // Adjust the date format accordingly
              Text('Customer: ${sale.costumer.name} ${sale.costumer.lastName}'),
            
              // Display the total purchase amount
              Text('Total Purchase: \$${sale.totalPurchase.toStringAsFixed(2)}'),

              // Add more sale details as needed
            
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
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _sendBillByEmail(sale.costumer.email, sale); // Replace with your email sending logic
                    // You might want to show a confirmation message here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Bill sent to ${sale.costumer.email}')),
                    );
                  },
                  icon: Icon(Icons.email),
                  label: Text('Send Bill'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Method to simulate sending the bill by email
  void _sendBillByEmail(String email, Sale sale) {
    // Replace this with your actual logic to send the bill by email
    // You might use packages like `mailer` to send emails in Flutter.
    print('Sending bill to $email');
    // Here, you could generate a PDF and attach it to the email.
    // For simplicity, I'm just printing a message to the console.
  }
}
