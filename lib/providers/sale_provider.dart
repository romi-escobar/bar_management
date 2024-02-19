import 'package:bar_management/models/sale.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:bar_management/models/product.dart';

class SaleItem {
  final Product product;
  int quantity;
  double total;

  SaleItem({
    required this.product,
    required this.quantity,
    required this.total,
  });

  // Add setters for quantity and total
  set setQuantity(int value) => quantity = value;
  set setTotal(double value) => total = value;
}

class SaleProvider extends ChangeNotifier {
  List<SaleItem> _cartItems = [];
  String _ruc = '';
  List<Sale> _sales = []; // Assuming you have a Sale class

  List<SaleItem> getCartItems() {
    return List.from(_cartItems);
  }

  double getTotal() {
    return _cartItems.fold(0.0, (sum, item) => sum + item.total);
  }

  void setRUC(String ruc) {
    _ruc = ruc;
    notifyListeners();
  }

  List<Sale> getAllSales() {
    return List.from(_sales);
  }

  void addSale(Sale sale) {
    _sales.add(sale);
    notifyListeners();
  }

  void addToCart(Product product, int quantity) {
    // Check if the product is already in the cart
    final existingItem = _cartItems.firstWhereOrNull(
      (item) => item.product.id == product.id,
    );

    if (existingItem != null) {
      // Update quantity and total if the product is already in the cart
      existingItem.setQuantity = quantity;
      existingItem.setTotal = quantity * product.price.toDouble();
    } else {
      // Add a new item to the cart
      final newItem = SaleItem(
        product: product,
        quantity: quantity,
        total: quantity * product.price.toDouble(),
      );
      _cartItems.add(newItem);
    }

    notifyListeners();
  }

  int getQuantityInCart(Product product) {
    final existingItem = _cartItems.firstWhereOrNull((item) => item.product.id == product.id);
    return existingItem?.quantity ?? 0;
  }

  String getRUC() {
    return _ruc;
  }

  void clearCart() {
    _cartItems.clear();
    _ruc = '';
    notifyListeners();
  }
}
