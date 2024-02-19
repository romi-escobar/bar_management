// sale.dart model
// sale.dart model
import 'package:bar_management/models/costumer.dart';
import 'package:bar_management/models/product.dart';

class Sale {
  int id;
  String billNumber;
  DateTime saleDate;
  Costumer costumer;
  List<SaleDetail> saleDetails;
  int totalPurchase;

  Sale({
    required this.id,
    required this.billNumber,
    required this.saleDate,
    required this.costumer,
    required this.saleDetails,
    required this.totalPurchase,
  });
}

class SaleDetail {
  //Product productCode;
  //Product productName;
  //Product pricePerUnit;
  Product product;
  int quantity;
  int totalForProduct;

  SaleDetail({
    //required this.productCode,
    //required this.productName,
    //required this.pricePerUnit,
    required this.product,
    required this.quantity,
    required this.totalForProduct,
  });

}
