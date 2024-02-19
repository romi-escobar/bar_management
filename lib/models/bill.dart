// bill.dart
import 'package:bar_management/providers/sale_provider.dart';

class Bill {
  int id;
  String costumerName;
  String costumerRuc;
  List<SaleItem> items;
  double total;
  DateTime date;

  Bill({
    required this.id,
    required this.costumerName,
    required this.costumerRuc,
    required this.items,
    required this.total,
    required this.date,
  });
}
