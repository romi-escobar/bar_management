// product_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bar_management/models/category.dart';
import 'package:bar_management/models/product.dart';
import 'package:bar_management/providers/product_provider.dart';
import 'package:bar_management/widgets/product/add_product_dialog.dart';
import 'package:bar_management/widgets/product/edit_product_dialog.dart';
import 'package:bar_management/widgets/product/read_product_dialog.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String filterType = '';

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddProductDialog(
          onAdd: (String newCode, String newName, Category newCategory, int newPrice) {
            final productProvider = Provider.of<ProductProvider>(context, listen: false);

            final newProduct = Product(
              id: productProvider.products.length + 1,
              code: newCode,
              name: newName,
              category: newCategory,
              price: newPrice,
            );

            productProvider.addProduct(newProduct);
          },
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filter by Name or Category'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                filterType = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Enter name or category',
            ),
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
                Navigator.pop(context);
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productProvider.products.length,
        itemBuilder: (context, index) {
          final product = productProvider.products[index];

          if ((filterType.isEmpty ||
              product.name.toLowerCase().contains(filterType.toLowerCase()) ||
              product.category.name.toLowerCase().contains(filterType.toLowerCase()))) {
            return ListTile(
              title: Text(product.name),
              subtitle: Text('${product.category.name} - \$${product.price.toStringAsFixed(2)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      final selectedProduct = productProvider.getProductById(product.id);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ReadProductDialog(product: selectedProduct);
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return EditProductDialog(
                            currentCode: product.code,
                            currentName: product.name,
                            currentCategory: product.category,
                            currentPrice: product.price,
                            onEdit: (String newCode, String newName, Category newCategory, int newPrice) {
                              final productProvider = Provider.of<ProductProvider>(context, listen: false);

                              productProvider.editProduct(
                                product.id,
                                newCode,
                                newName,
                                newCategory,
                                newPrice,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      productProvider.deleteProduct(product.id);
                    },
                  ),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
