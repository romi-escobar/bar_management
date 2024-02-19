// product.dart model
import 'package:bar_management/models/category.dart';

class Product {
  int id;
  String code;
  String name;
  Category category;
  int price;
  int quantityInCart; // New field to store the quantity added to the cart
  
  Product({
    required this.id,
    required this.code,
    required this.name,
    required this.category,
    required this.price,
    this.quantityInCart = 0, // Default to 0
  });
}
