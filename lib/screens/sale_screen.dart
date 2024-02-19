// sale_screen.dart
import 'package:bar_management/models/costumer.dart';
import 'package:bar_management/models/sale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bar_management/models/product.dart';
import 'package:bar_management/providers/product_provider.dart';
import 'package:bar_management/providers/sale_provider.dart';
import 'package:bar_management/providers/costumer_provider.dart';

class SaleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final saleProvider = Provider.of<SaleProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final costumerProvider = Provider.of<CostumerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sale Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              _showCartDialog(context, saleProvider, costumerProvider);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productProvider.products.length,
        itemBuilder: (context, index) {
          final product = productProvider.products[index];
          final quantity = saleProvider.getQuantityInCart(product);

          return ListTile(
            title: Text(product.name),
            subtitle: Text('${product.category.name} - \$${product.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    _showQuantityDialog(context, product, saleProvider);
                  },
                ),
                if (quantity > 0) Text('$quantity'),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showQuantityDialog(BuildContext context, Product product, SaleProvider saleProvider) {
    showDialog(
      context: context,
      builder: (context) {
        int quantity = 1;

        return AlertDialog(
          title: Text('Enter Quantity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  quantity = int.tryParse(value) ?? 1;
                },
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                saleProvider.addToCart(product, quantity);
                Navigator.pop(context);
              },
              child: Text('Add to Cart'),
            ),
          ],
        );
      },
    );
  }

  void _showCartDialog(BuildContext context, SaleProvider saleProvider, CostumerProvider costumerProvider) {
    final cartItems = saleProvider.getCartItems();
    final total = saleProvider.getTotal();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Shopping Cart'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var item in cartItems)
                ListTile(
                  title: Text(item.product.name),
                  subtitle: Text('Quantity: ${item.quantity}'),
                  trailing: Text('\$${item.total.toStringAsFixed(2)}'),
                ),
              SizedBox(height: 10),
              Text(
                'Total: \$${total.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(labelText: 'Enter your RUC'),
                onChanged: (ruc) {
                  saleProvider.setRUC(ruc);
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _closeSale(context, saleProvider, costumerProvider);
                Navigator.pop(context);
              },
              child: Text('Close Sale'),
            ),
          ],
        );
      },
    );
  }

  void _closeSale(BuildContext context, SaleProvider saleProvider, CostumerProvider costumerProvider) {
    final cartItems = saleProvider.getCartItems();
    final total = saleProvider.getTotal();
    final ruc = saleProvider.getRUC();

    // Placeholder data for customer
    final customer = costumerProvider.getCostumerByRUC(ruc);

    // Create SaleDetails with placeholder data
    final saleDetails = cartItems.map((item) => SaleDetail(
      product: Product(
        id: item.product.id,
        code: item.product.code,
        name: item.product.name,
        category: item.product.category, // Assuming Product has a 'category' field
        price: item.product.price,
      ),
      quantity: item.quantity,
      totalForProduct: item.total.toInt(),
    )).toList();

    // Create a Sale instance with placeholder data
    final newSale = Sale(
      id: saleProvider.getAllSales().length + 1,
      billNumber: 'B${saleProvider.getAllSales().length + 1}',
      saleDate: DateTime.now(),
      costumer: customer,
      saleDetails: saleDetails,
      totalPurchase: total.toInt(),
    );

    // Add the Sale to SaleProvider
    saleProvider.addSale(newSale);

    // Reset the SaleProvider after closing the sale
    saleProvider.clearCart();
  }

}
